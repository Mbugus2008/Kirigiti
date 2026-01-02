page 50018 "API Fee Structure Lines"
{
    PageType = API;
    APIGroup = 'school';
    APIPublisher = 'trimline';
    APIVersion = 'v1.0';
    EntityName = 'feeStructureLine';
    EntitySetName = 'feeStructureLines';
    SourceTable = "Fee Structure Lines";
    DelayedInsert = true;
    ODataKeyFields = "Structure Code", "Stage Code";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field(structureCode; Rec."Structure Code") { }
                field(stageCode; Rec."Stage Code") { }
                field(stageName; Rec."Stage Name") { }
                field(totalFee; Rec."Total Fee") { }
            }
        }
    }
}
