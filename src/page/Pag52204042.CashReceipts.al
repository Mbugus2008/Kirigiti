page 52204042 "Cash Receipts"
{
    CardPageID = "Cash Receipt Header";
    PageType = List;
    SourceTable = "Cash Receipt Header";
    SourceTableView = WHERE(Posted = CONST(false));
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Receipt No."; Rec."Receipt No.")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = all;
                }
                field("Payment Method"; Rec."Payment Method")
                {
                    ApplicationArea = all;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = all;
                }
                field("Receiving Account Type"; Rec."Receiving Account Type")
                {
                    ApplicationArea = all;
                }
                field("Receiving Account No."; Rec."Receiving Account No.")
                {
                    ApplicationArea = all;
                }
                field("Receiving Account Name"; Rec."Receiving Account Name")
                {
                    ApplicationArea = all;
                }
                field("Amount Received"; Rec."Amount Received")
                {
                    ApplicationArea = all;
                }
                field("Allocated Amount"; Rec."Allocated Amount")
                {
                    ApplicationArea = all;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = all;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = all;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = all;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}