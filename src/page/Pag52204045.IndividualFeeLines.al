page 52204045 "Individual Fee Lines"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Individual Fee Lines";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Charge Code"; "Charge Code")
                {

                }
                field(Amount; Amount)
                {
                    ShowMandatory = true;
                }
                field("Charge Name"; "Charge Name") { }
                field("Account No"; "Account No") { }
            }
        }

    }

    actions
    {
        area(Processing)
        {

        }
    }
}