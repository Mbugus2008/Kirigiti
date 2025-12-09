page 52204033 "Fee Structure Det. Lines"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Fee Structure Det. Lines";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Fee Code"; "Fee Code")
                {

                }
                field(Description; Description) { }
                field(Amount; Amount) { }
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