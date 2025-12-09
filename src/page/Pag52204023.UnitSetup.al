page 52204023 "Unit Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Unit Setup";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Unit Code"; "Unit Code")
                {

                }
                field("Unit Name"; "Unit Name") { }
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

    var
        myInt: Integer;
}