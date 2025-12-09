page 52204027 "Student Admissions"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Admission";
    CardPageId = "Student Admission Card";
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Application No"; "Application No")
                {

                }
                field("First Name"; "First Name") { }
                field("Middle Name"; "Middle Name") { }
                field("Last Name"; "Last Name") { }
                field(Gender; Gender) { }
                field("Program Code"; "Program Code") { }
                field("Program Name"; "Program Name") { }
                field("Stage Code"; "Stage Code") { }
                field("Stage Name"; "Stage Name") { }
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