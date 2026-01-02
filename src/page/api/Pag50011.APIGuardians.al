page 50011 "API Guardians"
{
    PageType = API;
    APIGroup = 'school';
    APIPublisher = 'trimline';
    APIVersion = 'v1.0';
    EntityName = 'guardian';
    EntitySetName = 'guardians';
    SourceTable = "Student Admission Guardians";
    DelayedInsert = true;
    ODataKeyFields = "Application No", "Entry No";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Guardians)
            {
                field(applicationNo; Rec."Application No") { }
                field(entryNo; Rec."Entry No") { }
                field(relationship; Rec.Relationship) { }
                field(fullName; Rec."Full Name") { }
                field(email; Rec.Email) { }
                field(phoneNo; Rec."Phone No") { }
            }
        }
    }
}
