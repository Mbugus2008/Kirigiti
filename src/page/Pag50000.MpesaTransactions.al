page 50000 "Mpesa Transactions"
{
    Caption = 'Mpesa Transactions';
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Mpesa Transactions";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Receipt No."; "Receipt No.") { }
                field("Completion Time"; "Completion Time") { }
                field("Detaills"; "Detaills") { }
                field("Status"; Status) { }
                field("Withdrawn"; Withdrawn) { }
                field("Paid In"; "Paid In") { }
                field("Balance"; Balance) { }
                field("Balance Confirmed"; "Balance Confirmed") { }
                field("Deposit Type"; "Deposit Type") { }
                field("Other Party Info"; "Other Party Info") { }
                field("A/C No."; "A/C No.") { }
                field("Processed"; Processed) { }
                field("Initiation Time"; "Initiation Time") { }
                field("Paybil Number"; "Paybil Number") { }
                field("Phone"; Phone) { }
                field("Name"; Name) { }
                field("Transaction Date"; "Transaction Date") { }
                field("Posting Date/Time"; "Posting Date/Time") { }
                field("Time"; "Time") { }
                field("Comments"; Comments) { }
                field("Keyword"; Keyword) { }
                field("ID No"; "ID No") { }
                field("Transaction Type"; "Transaction Type") { }
                field("Loan No"; "Loan No") { }
                field("Modified by"; "Modified by") { }
                field("Purpose"; Purpose) { }
                field("District"; District) { }
            }
        }
    }

    actions
    {
    }
}
