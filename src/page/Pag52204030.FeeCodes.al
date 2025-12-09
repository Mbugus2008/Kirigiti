page 52204030 "Fee Codes"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Fee Codes";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Fee Code"; "Fee Code")
                {

                }
                field("Posting Description"; "Posting Description") { }
                field("Post To Account Type"; "Post To Account Type") { }
                field("Post to Account No"; "Post to Account No") { }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
}