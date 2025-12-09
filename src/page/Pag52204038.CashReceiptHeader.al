page 52204038 "Cash Receipt Header"
{
    PageType = Card;
    SourceTable = "Cash Receipt Header";
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group(General)
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
            }
            part(Control22; "Cash Receipt Lines")
            {
                SubPageLink = "Cash Receipt No." = FIELD("Receipt No.");
            }
            group(Audit)
            {
                field("Created By"; Rec."Created By")
                {
                }
                field("Created On"; Rec."Created On")
                {
                }
                field("Source Type"; Rec."Source Type")
                {
                }
                field(Posted; Rec.Posted)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Post)
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Do you want to Post?') then
                        Rec.PostReceipt;
                end;
            }
            action(Print)
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CashReceiptHeader.Reset;
                    CashReceiptHeader.SetRange("Receipt No.", Rec."Receipt No.");
                    //if CashReceiptHeader.FindFirst then
                    //REPORT.RunModal(Report::"Cash Receipt", true, false, CashReceiptHeader);
                end;
            }
        }
    }


    var
        CashReceiptHeader: Record "Cash Receipt Header";
}