page 50001 "SMS Messages"
{
    ApplicationArea = All;
    Caption = 'SMS Messages';
    PageType = List;
    SourceTable = "SMS Messages";
    UsageCategory = Lists;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry number.';
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source of the SMS.';
                }
                field("Telephone No"; Rec."Telephone No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the telephone number.';
                }
                field("SMS Message"; Rec."SMS Message")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the SMS message content.';
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date the SMS was entered.';
                }
                field("Time Entered"; Rec."Time Entered")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the time the SMS was entered.';
                }
                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who entered the SMS.';
                }
                field("Sent To Server"; Rec."Sent To Server")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the SMS was sent to the server.';
                }
                field("Date Sent to Server"; Rec."Date Sent to Server")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date the SMS was sent to the server.';
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the account number.';
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document number.';
                }
                field("Bulk SMS Balance"; Rec."Bulk SMS Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bulk SMS balance.';
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
                ToolTip = 'Send the selected SMS message.';

                trigger OnAction()
                begin
                    // TODO: Implement SMS sending logic
                    Message('SMS sending functionality to be implemented.');
                end;
            }
            action(ResendFailed)
            {
                ApplicationArea = All;
                Caption = 'Resend Failed';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Resend all failed SMS messages.';

                trigger OnAction()
                var
                    SMSMsg: Record "SMS Messages";
                begin
                    SMSMsg.SetRange("Sent To Server", SMSMsg."Sent To Server"::Failed);
                    if SMSMsg.FindSet() then begin
                        // TODO: Implement resend logic
                        Message('%1 failed SMS messages found for resending.', SMSMsg.Count);
                    end else
                        Message('No failed SMS messages found.');
                end;
            }
        }
        area(Navigation)
        {
        }
    }
}
