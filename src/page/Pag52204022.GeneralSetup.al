page 52204022 "General Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Gen. Setup";

    layout
    {
        area(Content)
        {
            group(Numbering)
            {
                field("Student Application Nos."; "Student Application Nos.")
                {

                }
                field("Cash Receipt Nos."; "Cash Receipt Nos.") { }
                field("PV Nos."; "PV Nos.")
                {
                    Caption = 'Payment Voucher Nos.';
                }
                field("Individual Fee Nos."; "Individual Fee Nos.") { }
            }
            group("Student Posting Setup")
            {
                field("Student Bus. Posting Group"; "Student Bus. Posting Group") { }
                field("Student Posting Group"; "Student Posting Group") { }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                var
                    Student: Record "Student Admission";
                    Guardians: Record "Student Admission Guardians";
                    StudentReg: Record "Student Register";
                    GLEntry: Record "G/L Entry";
                    Customer: Record Customer;
                    CustLedger: Record "Cust. Ledger Entry";
                    DetailedLedger: Record "Detailed Cust. Ledg. Entry";
                    SalesHeader: Record "Sales Invoice Header";
                    SalesLine: Record "Sales Invoice Line";
                begin
                    // Student.DeleteAll();
                    // Guardians.DeleteAll();
                    // StudentReg.DeleteAll();
                    // GLEntry.DeleteAll();
                    // CustLedger.DeleteAll();
                    // DetailedLedger.DeleteAll();
                    // SalesHeader.DeleteAll();
                    // SalesLine.DeleteAll();
                end;
            }
        }
    }

    var
        myInt: Integer;
}