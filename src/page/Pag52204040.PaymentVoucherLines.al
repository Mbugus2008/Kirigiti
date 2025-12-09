page 52204040 "Payment Voucher Lines"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Payment Voucher Lines";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Pay-to Account Type"; Rec."Pay-to Account Type")
                {
                    ApplicationArea = all;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = all;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = all;
                }
                field("Payment Amount"; Rec."Payment Amount")
                {
                    ApplicationArea = all;
                }
                field("Applies to Doc-Number"; Rec."Applies to Doc-Number")
                {
                    ApplicationArea = all;
                }
                field("Applies To Docu-Type"; Rec."Applies To Docu-Type")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                end;
            }
        }
    }
}