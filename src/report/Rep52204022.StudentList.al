report 52204022 "Student List"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = '.\ssrs\Student List.rdl';

    dataset
    {
        dataitem("Student Register"; "Student Register")
        {

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
            column(Admission_No; "Admission No")
            {

            }
            column(Full_Name; "Full Name") { }
            column(Stage_Code; "Stage Code") { }
            column(Stage_Name; "Stage Name") { }
            column(Date_of_Birth; "Date of Birth") { }
            column(FeeBalance; FeeBalance) { }
            column(AsAtDate; AsAtDate) { }
            trigger OnAfterGetRecord()
            begin
                if AsAtDate = 0D then
                    AsAtDate := Today;
                FeeBalance := 0;
                DetailedCustLedger.Reset();
                DetailedCustLedger.SetRange("Customer No.", "Admission No");
                DetailedCustLedger.SetFilter("Posting Date", '..%1', AsAtDate);
                if DetailedCustLedger.FindSet() then begin
                    DetailedCustLedger.CalcSums(Amount);
                    FeeBalance := DetailedCustLedger.Amount;
                end;
            end;

        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field("As At Date"; AsAtDate)
                    {

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {

                }
            }
        }
    }



    var
        CompanyInformation: Record "Company Information";
        AsAtDate: Date;
        DetailedCustLedger: Record "Detailed Cust. Ledg. Entry";

        FeeBalance: Decimal;
}