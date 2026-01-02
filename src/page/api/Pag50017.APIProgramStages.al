page 50017 "API Program Stages"
{
    PageType = API;
    APIGroup = 'school';
    APIPublisher = 'trimline';
    APIVersion = 'v1.0';
    EntityName = 'programStage';
    EntitySetName = 'programStages';
    SourceTable = "Program Stages";
    DelayedInsert = true;
    ODataKeyFields = "Program Code", "Stage Code";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Stages)
            {
                field(programCode; Rec."Program Code") { }
                field(stageCode; Rec."Stage Code") { }
                field(stageName; Rec."Stage Name") { }
            }
        }
    }
}
