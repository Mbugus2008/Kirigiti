page 50003 "Mpesa Transactions List"
{
    Caption = 'Mpesa Transactions List';
    ApplicationArea = All;
    Editable = true;
    PageType = List;
    SourceTable = "Mpesa Transactions";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Processed; Processed) { }
                field("Paid In"; "Paid In") { }
                field(Name; Name) { }
                field(District; District) { }
                field(Purpose; Purpose) { }
                field("Completion Time"; "Completion Time") { }
                field("Receipt No."; "Receipt No.") { }
                field(Detaills; Detaills) { }
                field(Status; Status) { }
                field(Withdrawn; Withdrawn) { }
                field(Balance; Balance) { }
                field("Balance Confirmed"; "Balance Confirmed") { }
                field("Deposit Type"; "Deposit Type") { }
                field("Other Party Info"; "Other Party Info") { }
                field("A/C No."; "A/C No.") { }
                field("Initiation Time"; "Initiation Time") { }
                field("Paybil Number"; "Paybil Number") { }
                field(Phone; Phone) { }
                field("Transaction Date"; "Transaction Date") { }
                field("Posting Date/Time"; "Posting Date/Time") { }
                field(Time; Time) { }
                field(Comments; Comments) { }
                field(Keyword; Keyword) { }
                field("ID No"; "ID No") { }
                field("Transaction Type"; "Transaction Type") { }
                field("Loan No"; "Loan No") { }
                field("Modified by"; "Modified by") { }
                field(Transtype; Transtype) { }
                field(Charge; Charge) { }
                field(Reference; Reference) { }
            }
        }
    }


}
