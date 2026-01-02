page 50020 "API Cash Receipt Lines"
{
    PageType = API;
    APIGroup = 'school';
    APIPublisher = 'trimline';
    APIVersion = 'v1.0';
    EntityName = 'cashReceiptLine';
    EntitySetName = 'cashReceiptLines';
    SourceTable = "Cash Receipt Lines";
    DelayedInsert = true;
    ODataKeyFields = "Cash Receipt No.", "Line No";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field(cashReceiptNo; Rec."Cash Receipt No.") { }
                field(lineNo; Rec."Line No") { }
                field(accountType; Rec."Account Type") { }
                field(accountNo; Rec."Account No.") { }
                field(receivingAccountName; Rec."Receiving Account Name") { }
                field(originalAmount; Rec."Original Amount") { }
                field(remainingAmount; Rec."Remaining Amount") { }
                field(appliedAmount; Rec."Applied Amount") { }
                field(description; Rec.Description) { }
                field(appliesToDocNo; Rec."Applies-To-Doc No") { }
                field(dueDate; Rec."Due Date") { }
            }
        }
    }
}
