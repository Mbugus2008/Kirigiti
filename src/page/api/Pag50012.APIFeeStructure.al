page 50012 "API Fee Structure"
{
    PageType = API;
    APIGroup = 'school';
    APIPublisher = 'trimline';
    APIVersion = 'v1.0';
    EntityName = 'feeStructure';
    EntitySetName = 'feeStructures';
    SourceTable = "Fee Structure Header";
    DelayedInsert = true;
    ODataKeyFields = "Structure Code";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(FeeStructures)
            {
                field(structureCode; Rec."Structure Code") { }
                field(structureDescription; Rec."Structure Description") { }
                field(programCode; Rec."Program Code") { }
                field(startDate; Rec."Start Date") { }
                field(endDate; Rec."End Date") { }
            }
        }
    }
}
