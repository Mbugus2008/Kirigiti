page 50016 "API Programs"
{
    PageType = API;
    APIGroup = 'school';
    APIPublisher = 'trimline';
    APIVersion = 'v1.0';
    EntityName = 'program';
    EntitySetName = 'programs';
    SourceTable = "Program Setup";
    DelayedInsert = true;
    ODataKeyFields = "Program Code";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Programs)
            {
                field(programCode; Rec."Program Code") { }
                field(programName; Rec."Program Name") { }
            }
        }
    }
}
