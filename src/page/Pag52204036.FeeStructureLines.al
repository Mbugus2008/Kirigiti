page 52204036 "Fee Structure Lines"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Fee Structure Lines";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
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
                field("Total Fee"; "Total Fee")
                {
                    Style = Strong;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                Image = StepInto;
                Caption = 'Fee Details';
                RunObject = page "Fee Structure Det. Lines";
                RunPageLink = "Structure Code" = field("Structure Code"), "Stage Code" = field("Stage Code");
                trigger OnAction()
                begin

                end;
            }
        }
    }
}