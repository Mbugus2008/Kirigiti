page 52204034 Students
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Register";
    Editable = false;
    CardPageId = "Student Card";
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Admission No"; "Admission No")
                {

                }

                field("Full Name"; "Full Name") { }
                field("status"; Status) { }

                field(Gender; Gender) { }
                field("Program Code"; "Program Code") { }
                field("Program Name"; "Program Name") { }
                field("Stage Code"; "Stage Code") { }
                field("Stage Name"; "Stage Name") { }
                field("Created By"; "Created By") { }
                field("Created On"; "Created On") { }
            }
        }
        area(FactBoxes)
        {
            part("Student Statistics"; "Customer Statistics FactBox")
            {
                SubPageLink = "No." = field("Admission No");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Create Billing Account")
            {

                trigger OnAction()
                var
                    StudentMgt: Codeunit "Student Management";
                begin
                    StudentMgt.CreateBillingAccount(Rec."Admission No", "Full Name");
                end;
            }
        }
    }
}