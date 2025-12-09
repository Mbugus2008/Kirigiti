page 52204029 "Student Guardians"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Admission Guardians";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Relationship; Relationship)
                {

                }
                field("Full Name"; "Full Name") { }
                field("Phone No"; "Phone No") { }
                field(Email; Email) { }
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