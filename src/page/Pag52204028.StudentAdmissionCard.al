page 52204028 "Student Admission Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Student Admission";

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

                field("Date of Birth"; "Date of Birth") { }
                field(Gender; Gender) { }
                field("Program Code"; "Program Code") { }
                field("Program Name"; "Program Name") { }
                field("Stage Code"; "Stage Code") { }
                field("Stage Name"; "Stage Name") { }
                field("Student Image"; "Student Image") { }
                field(Address; Address) { }
                field(Location; Location) { }
                field(City; City) { }
                field(County; County) { }
                field(PWD; PWD) { }
                field("PWD Description"; "PWD Description") { }
            }
            part(Guardians; "Student Guardians")
            {
                SubPageLink = "Application No" = field("Application No");
                Caption = 'Parents/Guardian Details';
            }
            group("Audit Trail")
            {
                //Editable = false;
                field("Created By"; "Created By") { }
                field("Created On"; "Created On") { }
                field("Admission No"; "Admission No") { }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Create Student")
            {

                trigger OnAction()
                begin
                    if Confirm('Do you want to Create the Student Card') = false then
                        exit;
                    StudentMgt.CreateStudent(Rec."Application No");
                    CurrPage.Close();
                end;
            }
        }
    }

    var
        StudentMgt: Codeunit "Student Management";
}