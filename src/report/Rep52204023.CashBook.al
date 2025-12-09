report 52204023 "Cash Book"
{
    UsageCategory = Administration;
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    DefaultLayout = RDLC; //0606
    RDLCLayout = '.\ssrs\Cash Book.rdl';

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            RequestFilterFields = "No.", "Date Filter";

            column(No_; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column("CompanyLogo"; CompanyInformation.Picture)
            {
            }
            column("CompanyName"; CompanyInformation.Name)
            {
            }
            column("CompanyAddress1"; CompanyInformation.Address)
            {
            }
            column("CompanyAddress2"; CompanyInformation."Address 2")
            {
            }
            column("CompanyPhone"; CompanyInformation."Phone No.")
            {
            }
            column("CompanyEmail"; CompanyInformation."E-Mail")
            {
            }
            column(OpenningBalance; OpenningBalance)
            {
            }
            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Posting Date", "Entry No.") where(reversed = const(false));

                column(Entry_No_; "Entry No.")
                {
                }
                column(Posting_Date; "Posting Date")
                {
                }
                column(Document_No_; "Document No.")
                {
                }
                column(Amount; Amount)
                {
                }
                column(Credit_Amount; "Credit Amount")
                {
                }
                column(Debit_Amount; "Debit Amount")
                {
                }
                column(RunningBalance; RunningBalance)
                {
                }
                column(User_ID; "User ID")
                {
                }
                column(Description; Description)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    RunningBalance += "Bank Account Ledger Entry".Amount;
                end;
            }
            trigger OnPreDataItem()
            begin
                DateFilter := "Bank Account".GetFilter("Date Filter");
                OpenningBalance := 0;
                RunningBalance := 0;
            end;

            trigger OnAfterGetRecord()
            begin
                CompanyInformation.get;
                CompanyInformation.CalcFields(Picture);
                OpenningBalance := 0;
                if DateFilter <> '' then begin
                    DateRec.Reset();
                    DateRec.SetFilter("Period Start", DateFilter);
                    if DateRec.FindFirst() then begin
                        LowDate := DateRec.GetRangeMin("Period Start");
                        LowDate := CalcDate('-1D', LowDate);
                    end;
                    BankLedger.Reset();
                    BankLedger.SetFilter("Posting Date", '..%1', LowDate);
                    BankLedger.SetRange("Bank Account No.", "Bank Account"."No.");
                    if BankLedger.FindSet() then begin
                        BankLedger.CalcSums(Amount);
                        OpenningBalance := BankLedger.Amount;
                    end;
                end
                else
                    OpenningBalance := 0;
                RunningBalance := OpenningBalance;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        CompanyInformation: Record "Company Information";
        OpenningBalance: Decimal;
        RunningBalance: Decimal;
        DateFilter: Text;
        BankLedger: Record "Bank Account Ledger Entry";
        DateRec: Record Date;
        LowDate: date;
}
