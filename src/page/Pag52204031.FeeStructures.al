page 52204031 "Fee Structures"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Fee Structure Header";
    CardPageId = "Fee Structure";
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Structure Code"; "Structure Code")
                {

                }
                field("Structure Description"; "Structure Description") { }
                field("Created By"; "Created By") { }
                field("Created On"; "Created On") { }
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