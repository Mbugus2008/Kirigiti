page 50013 "API Payments"
{
    PageType = API;
    APIGroup = 'school';
    APIPublisher = 'trimline';
    APIVersion = 'v1.0';
    EntityName = 'payment';
    EntitySetName = 'payments';
    SourceTable = "Cash Receipt Header";
    DelayedInsert = true;
    ODataKeyFields = "Receipt No.";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Payments)
            {
                field(receiptNo; Rec."Receipt No.") { }
                field(postingDate; Rec."Posting Date") { }
                field(postingDescription; Rec."Posting Description") { }
                field(paymentMethod; Rec."Payment Method") { }
                field(externalDocumentNo; Rec."External Document No.") { }
                field(amountReceived; Rec."Amount Received") { }
                field(allocatedAmount; Rec."Allocated Amount") { }
                field(createdBy; Rec."Created By") { }
                field(createdOn; Rec."Created On") { }
            }
        }
    }
}
