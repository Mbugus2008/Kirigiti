page 50115 "Bulk Sms Card"
{
    ApplicationArea = All;
    Caption = 'Bulk Sms Card';
    PageType = Card;
    SourceTable = "Bulk Sms";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No"; Rec."No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bulk SMS number.';

                    trigger OnAssistEdit()
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Send To"; Rec."Send To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who to send the SMS to.';
                }
                field("Send To Details"; Rec."Send To Details")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies additional details for the send to option.';
                }
                field("Different text"; Rec."Different text")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if different text should be sent to each recipient.';
                }
                field("Sms Sent"; Rec."Sms Sent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the SMS has been sent.';
                }
            }
            group(Message)
            {
                Caption = 'Message';

                field("Text Message"; Rec."Text Message")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the SMS message.';
                    MultiLine = true;
                }
                field("Text Message1"; Rec."Text Message1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies additional SMS message content.';
                    MultiLine = true;
                }
            }
            part(Details; "Bulk Sms Details Subpage")
            {
                ApplicationArea = All;
                Caption = 'Recipients';
                SubPageLink = Bulk = field("No");
            }
            group(Audit)
            {
                Caption = 'Audit';

                field("Created by"; Rec."Created by")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created the record.';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the record was created.';
                }
                field("Time Created"; Rec."Time Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the time the record was created.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series used.';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SendSMS)
            {
                ApplicationArea = All;
                Caption = 'Send SMS';
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Send this bulk SMS.';

                trigger OnAction()
                begin
                    SendBulkSms();
                end;
            }
        }
    }

    local procedure SendBulkSms()
    var
        BulkSmsDetails: Record "Bulk Sms Details";
        SmsMessages: Record "SMS Messages";
        EntryNo: Integer;
        SmsCount: Integer;
        MessageText: Text;
    begin
        if Rec."Sms Sent" then
            Error('This SMS has already been sent.');

        Rec.TestField("Text Message");

        BulkSmsDetails.SetRange(Bulk, Rec."No");
        if not BulkSmsDetails.FindSet() then
            Error('No recipients found. Please add recipients before sending.');

        // Get the next entry no
        SmsMessages.Reset();
        if SmsMessages.FindLast() then
            EntryNo := SmsMessages."Entry No"
        else
            EntryNo := 0;

        repeat
            EntryNo += 1;
            SmsCount += 1;

            SmsMessages.Init();
            SmsMessages."Entry No" := EntryNo;
            SmsMessages.Source := Rec."No";
            SmsMessages."Telephone No" := BulkSmsDetails."Mobile Number";
            SmsMessages."Account No" := BulkSmsDetails."Code";
            SmsMessages."Batch No" := Rec."No";
            SmsMessages."Document No" := Rec."No";
            SmsMessages."System Created Entry" := true;

            // Use different text if enabled, otherwise use the main message
            if Rec."Different text" and (BulkSmsDetails.Description <> '') then
                MessageText := BulkSmsDetails.Description
            else
                MessageText := Rec."Text Message";

            SmsMessages."SMS Message" := CopyStr(MessageText, 1, MaxStrLen(SmsMessages."SMS Message"));

            // Handle overflow to additional message fields
            if StrLen(MessageText) > 250 then
                SmsMessages."SMS Message1" := CopyStr(MessageText, 251, MaxStrLen(SmsMessages."SMS Message1"));
            if StrLen(MessageText) > 500 then
                SmsMessages."SMS Message2" := CopyStr(MessageText, 501, MaxStrLen(SmsMessages."SMS Message2"));
            if StrLen(MessageText) > 750 then
                SmsMessages."SMS Message3" := CopyStr(MessageText, 751, MaxStrLen(SmsMessages."SMS Message3"));

            // Also handle Text Message1 from bulk sms
            if Rec."Text Message1" <> '' then begin
                if SmsMessages."SMS Message1" = '' then
                    SmsMessages."SMS Message1" := Rec."Text Message1"
                else
                    SmsMessages."SMS Message2" := Rec."Text Message1";
            end;

            SmsMessages."Sent To Server" := SmsMessages."Sent To Server"::No;
            SmsMessages.Insert(true);

        until BulkSmsDetails.Next() = 0;

        Rec."Sms Sent" := true;
        Rec.Modify();

        Message('%1 SMS message(s) created and queued for sending.', SmsCount);
        CurrPage.Update(false);
    end;

    local procedure AssistEdit(OldBulkSms: Record "Bulk Sms"): Boolean
    var
        GLSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        GLSetup.Get();
        GLSetup.TestField("Bulk SMS Nos");
        if NoSeriesMgt.SelectSeries(GLSetup."Bulk SMS Nos", OldBulkSms."No. Series", Rec."No. Series") then begin
            NoSeriesMgt.SetSeries(Rec."No");
            exit(true);
        end;
    end;
}
