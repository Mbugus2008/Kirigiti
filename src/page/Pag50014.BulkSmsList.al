page 50114 "Bulk Sms List"
{
    ApplicationArea = All;
    Caption = 'Bulk Sms';
    PageType = List;
    SourceTable = "Bulk Sms";
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "Bulk Sms Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No"; Rec."No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bulk SMS number.';
                }
                field("Send To"; Rec."Send To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who to send the SMS to.';
                }
                field("Text Message"; Rec."Text Message")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the SMS message.';
                }
                field("Sms Sent"; Rec."Sms Sent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the SMS has been sent.';
                }
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
            action(SendSelected)
            {
                ApplicationArea = All;
                Caption = 'Send Selected';
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Send the selected bulk SMS.';

                trigger OnAction()
                begin
                    SendBulkSms(Rec);
                end;
            }
            action(SendAll)
            {
                ApplicationArea = All;
                Caption = 'Send All Pending';
                Image = SendAllConfirm;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Send all pending bulk SMS messages.';

                trigger OnAction()
                var
                    BulkSms: Record "Bulk Sms";
                    SendCount: Integer;
                begin
                    BulkSms.SetRange("Sms Sent", false);
                    if not BulkSms.FindSet() then begin
                        Message('No pending bulk SMS found.');
                        exit;
                    end;

                    if not Confirm('Send all %1 pending bulk SMS?', false, BulkSms.Count) then
                        exit;

                    repeat
                        SendBulkSms(BulkSms);
                        SendCount += 1;
                    until BulkSms.Next() = 0;

                    Message('%1 bulk SMS batches processed.', SendCount);
                end;
            }
        }
    }

    local procedure SendBulkSms(var BulkSmsRec: Record "Bulk Sms")
    var
        BulkSmsDetails: Record "Bulk Sms Details";
        SmsMessages: Record "SMS Messages";
        EntryNo: Integer;
        MessageText: Text;
    begin
        if BulkSmsRec."Sms Sent" then
            exit;

        if BulkSmsRec."Text Message" = '' then
            exit;

        BulkSmsDetails.SetRange(Bulk, BulkSmsRec."No");
        if not BulkSmsDetails.FindSet() then
            exit;

        // Get the next entry no
        SmsMessages.Reset();
        if SmsMessages.FindLast() then
            EntryNo := SmsMessages."Entry No"
        else
            EntryNo := 0;

        repeat
            EntryNo += 1;

            SmsMessages.Init();
            SmsMessages."Entry No" := EntryNo;
            SmsMessages.Source := BulkSmsRec."No";
            SmsMessages."Telephone No" := BulkSmsDetails."Mobile Number";
            SmsMessages."Account No" := BulkSmsDetails."Code";
            SmsMessages."Batch No" := BulkSmsRec."No";
            SmsMessages."Document No" := BulkSmsRec."No";
            SmsMessages."System Created Entry" := true;

            // Use different text if enabled, otherwise use the main message
            if BulkSmsRec."Different text" and (BulkSmsDetails.Description <> '') then
                MessageText := BulkSmsDetails.Description
            else
                MessageText := BulkSmsRec."Text Message";

            SmsMessages."SMS Message" := CopyStr(MessageText, 1, MaxStrLen(SmsMessages."SMS Message"));

            if StrLen(MessageText) > 250 then
                SmsMessages."SMS Message1" := CopyStr(MessageText, 251, MaxStrLen(SmsMessages."SMS Message1"));
            if StrLen(MessageText) > 500 then
                SmsMessages."SMS Message2" := CopyStr(MessageText, 501, MaxStrLen(SmsMessages."SMS Message2"));
            if StrLen(MessageText) > 750 then
                SmsMessages."SMS Message3" := CopyStr(MessageText, 751, MaxStrLen(SmsMessages."SMS Message3"));

            if BulkSmsRec."Text Message1" <> '' then begin
                if SmsMessages."SMS Message1" = '' then
                    SmsMessages."SMS Message1" := BulkSmsRec."Text Message1"
                else
                    SmsMessages."SMS Message2" := BulkSmsRec."Text Message1";
            end;

            SmsMessages."Sent To Server" := SmsMessages."Sent To Server"::No;
            SmsMessages.Insert(true);

        until BulkSmsDetails.Next() = 0;

        BulkSmsRec."Sms Sent" := true;
        BulkSmsRec.Modify();
    end;
}
