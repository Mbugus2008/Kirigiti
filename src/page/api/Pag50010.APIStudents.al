page 50010 "API Students"
{
    PageType = API;
    APIGroup = 'school';
    APIPublisher = 'trimline';
    APIVersion = 'v1.0';
    EntityName = 'student';
    EntitySetName = 'students';
    SourceTable = "Student Register";
    DelayedInsert = true;
    ODataKeyFields = "Admission No";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Students)
            {
                field(admissionNo; Rec."Admission No") { }
                field(firstName; Rec."First Name") { }
                field(middleName; Rec."Middle Name") { }
                field(lastName; Rec."Last Name") { }
                field(fullName; Rec."Full Name") { }
                field(dateOfBirth; Rec."Date of Birth") { }
                field(gender; Rec.Gender) { }
                field(programCode; Rec."Program Code") { }
                field(programName; Rec."Program Name") { }
                field(stageCode; Rec."Stage Code") { }
                field(stageName; Rec."Stage Name") { }
                field(applicationNo; Rec."Application No") { }
                field(status; Rec.Status) { }
                field(feePayablePercent; Rec."Fee % Payable") { }
            }
        }
    }
}
