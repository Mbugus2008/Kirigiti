page 52204025 "Program Stages"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Program Stages";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Stage Code"; "Stage Code")
                {

                }
                field("Stage Name"; "Stage Name") { }
            }
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