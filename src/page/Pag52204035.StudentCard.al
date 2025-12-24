page 52204035 "Student Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Student Register";
    layout
    {
        area(Content)
        {
            group("Student Information")
            {
                field("First Name"; "First Name")
                {

                }
                field("Middle Name"; "Middle Name") { }
                field("Last Name"; "Last Name") { }
                field("Full Name"; "Full Name") { }
                field(Status; Status) { }
                field(Location; Location) { }
                field("Date of Birth"; "Date of Birth") { }
                field(Gender; Gender) { }
                field("Program Code"; "Program Code") { }
                field("Program Name"; "Program Name") { }
                field("Stage Code"; "Stage Code") { }
                field("Stage Name"; "Stage Name") { }
                field("Fee % Payable"; "Fee % Payable") { }
                field("Student Image"; "Student Image") { }
                field(Address; Address) { }
                field(City; City) { }
                field(County; County) { }
                field(PWD; PWD) { }
                field("PWD Description"; "PWD Description") { }
            }
            part(Guardians; "Student Guardians")
            {
                SubPageLink = "Application No" = field("Admission No");
                Caption = 'Parents/Guardian Details';
            }
            group("Audit Trail")
            {
                Editable = false;
                field("Created By"; "Created By") { }
                field("Created On"; "Created On") { }
                field("Admission No"; "Admission No") { }
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
            action("Test Bill")
            {
                trigger OnAction()
                var
                    StudentMgt: Codeunit "Student Management";
                begin
                    StudentMgt.BillStudent('2025T1', Rec."Admission No");
                end;
            }
            action("Student Statement")
            {
                trigger OnAction()
                var
                    StmtReport: Report "Student Statement";
                    Students: Record Customer;
                begin
                    Students.Reset();
                    Students.SetRange("No.", Rec."Admission No");
                    if Students.FindSet() then
                        report.Run(Report::"Student Statement", true, false, Students);
                end;
            }
        }
    }

    var
        myInt: Integer;
}