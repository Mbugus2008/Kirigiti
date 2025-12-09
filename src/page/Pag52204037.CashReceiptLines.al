page 52204037 "Cash Receipt Lines"
{
    PageType = ListPart;
    SourceTable = "Cash Receipt Lines";
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Receiving Account Type"; Rec."Account Type")
                {
                    ApplicationArea = all;
                }
                field("Receiving Account No."; Rec."Account No.")
                {
                    ApplicationArea = all;
                }
                field("Applies-To-Doc No"; Rec."Applies-To-Doc No") { }
                field("Receiving Account Name"; Rec."Receiving Account Name")
                {
                    Editable = false;
                }
                field("Original Amount"; Rec."Original Amount")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Applied Amount"; Rec."Applied Amount")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
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