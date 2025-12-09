page 52204024 "Program Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Program Setup";
    CardPageId = "Program Card";
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Program Code"; "Program Code")
                {

                }
                field("Program Name"; "Program Name") { }
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