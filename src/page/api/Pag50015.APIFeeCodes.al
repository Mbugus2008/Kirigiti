page 50015 "API Fee Codes"
{
    PageType = API;
    APIGroup = 'school';
    APIPublisher = 'trimline';
    APIVersion = 'v1.0';
    EntityName = 'feeCode';
    EntitySetName = 'feeCodes';
    SourceTable = "Fee Codes";
    DelayedInsert = true;
    ODataKeyFields = "Fee Code";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(FeeCodes)
            {
                field(feeCode; Rec."Fee Code") { }
                field(postingDescription; Rec."Posting Description") { }
            }
        }
    }
}
