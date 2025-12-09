page 52204039 "Payment Vouchers"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Payments Header";
    CardPageId = "Payment Voucher";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                }
                field("Payment Amount"; Rec."Payment Amount")
                {
                }
                field("Paying Account Type"; Rec."Paying Account Type")
                {
                }
                field("Paying Account No."; Rec."Paying Account No.")
                {
                }
                field("Paying Account Name"; Rec."Paying Account Name")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
        }
    }
}