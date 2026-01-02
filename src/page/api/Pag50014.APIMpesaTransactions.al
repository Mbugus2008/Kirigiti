page 50014 "API Mpesa Transactions"
{
    PageType = API;
    APIGroup = 'school';
    APIPublisher = 'trimline';
    APIVersion = 'v1.0';
    EntityName = 'mpesaTransaction';
    EntitySetName = 'mpesaTransactions';
    SourceTable = "Mpesa Transactions";
    DelayedInsert = true;
    ODataKeyFields = "Receipt No.";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Transactions)
            {
                field(receiptNo; Rec."Receipt No.") { }
                field(completionTime; Rec."Completion Time") { }
                field(details; Rec.Detaills) { }
                field(status; Rec.Status) { }
                field(paidIn; Rec."Paid In") { }
                field(accountNo; Rec."A/C No.") { }
                field(otherPartyInfo; Rec."Other Party Info") { }
                field(processed; Rec.Processed) { }
            }
        }
    }
}
