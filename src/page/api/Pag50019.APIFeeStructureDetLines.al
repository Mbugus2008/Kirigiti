page 50019 "API Fee Structure Det Lines"
{
    PageType = API;
    APIGroup = 'school';
    APIPublisher = 'trimline';
    APIVersion = 'v1.0';
    EntityName = 'feeStructureDetail';
    EntitySetName = 'feeStructureDetails';
    SourceTable = "Fee Structure Det. Lines";
    DelayedInsert = true;
    ODataKeyFields = "Structure Code", "Stage Code", "Line No";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Details)
            {
                field(structureCode; Rec."Structure Code") { }
                field(stageCode; Rec."Stage Code") { }
                field(lineNo; Rec."Line No") { }
                field(feeCode; Rec."Fee Code") { }
                field(description; Rec.Description) { }
                field(amount; Rec.Amount) { }
            }
        }
    }
}
