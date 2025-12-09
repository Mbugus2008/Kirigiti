codeunit 52204022 "Student Management"
{
    trigger OnRun()
    begin

    end;

    procedure BillFeeStructure(StructureCode: Code[20])
    var
        FeeStructureLines: Record "Fee Structure Lines";
    begin
        FeeStructureLines.Reset();
        FeeStructureLines.SetRange("Structure Code", StructureCode);
        if FeeStructureLines.FindSet() then begin
            repeat
                StudentRegister.Reset();
                StudentRegister.SetRange("Stage Code", FeeStructureLines."Stage Code");
                if StudentRegister.FindSet() then begin
                    repeat
                        BillStudent(StructureCode, StudentRegister."Admission No");
                    until StudentRegister.Next() = 0;
                end;
            until FeeStructureLines.Next() = 0;
        end;
    end;

    procedure CreateStudent(DocumentNo: Code[20]) AdmissionNo: Code[20]
    var
        Parents, Parents1 : Record "Student Admission Guardians";
    begin
        StudentAdmission.Get(DocumentNo);
        AdmissionNo := StudentAdmission."Admission No";
        if AdmissionNo = '' then begin
            ProgramSetup.Get(StudentAdmission."Program Code");
            ProgramSetup.TestField("Student Admission Nos.");
            AdmissionNo := NoSeries.GetNextNo(ProgramSetup."Student Admission Nos.", Today, true);
            StudentAdmission."Admission No" := AdmissionNo;
        end;
        if not StudentRegister.Get(AdmissionNo) then begin
            StudentRegister.Init();
            StudentRegister."Admission No" := AdmissionNo;
            StudentRegister."First Name" := StudentAdmission."First Name";
            StudentRegister."Middle Name" := StudentAdmission."Middle Name";
            StudentRegister."Last Name" := StudentAdmission."Last Name";
            StudentRegister."Full Name" := StudentAdmission."Full Name";
            StudentRegister."Date of Birth" := StudentAdmission."Date of Birth";
            StudentRegister.Gender := StudentAdmission.Gender;
            StudentRegister."Program Code" := StudentAdmission."Program Code";
            StudentRegister."Program Name" := StudentAdmission."Program Name";
            StudentRegister."Stage Code" := StudentAdmission."Stage Code";
            StudentRegister."Stage Name" := StudentAdmission."Stage Name";
            StudentAdmission.CalcFields("Student Image");
            StudentRegister."Student Image" := StudentAdmission."Student Image";
            StudentRegister.Address := StudentAdmission.Address;
            StudentRegister.County := StudentAdmission.County;
            StudentRegister.City := StudentAdmission.City;
            StudentRegister.Nationality := StudentAdmission.Nationality;
            StudentRegister.PWD := StudentAdmission.PWD;
            StudentRegister."PWD Description" := StudentAdmission."PWD Description";
            StudentRegister."Created By" := UserId;
            StudentRegister."Created On" := CurrentDateTime;
            StudentRegister.Insert();
        end;
        Parents.Reset();
        Parents.SetRange("Application No", DocumentNo);
        if Parents.FindSet() then begin
            repeat
                Parents1.Init();
                Parents1.TransferFields(Parents, false);
                Parents1."Application No" := AdmissionNo;
                Parents1."Entry No" := Parents."Entry No";
                Parents1.Insert();
            until Parents.Next() = 0;
        end;
        StudentAdmission.Processed := true;
        StudentAdmission.Modify();
        CreateBillingAccount(AdmissionNo, StudentAdmission."Full Name");
        exit(AdmissionNo);
    end;

    procedure CreateBillingAccount(AdmissionNo: Code[20]; FullName: Text[100])
    var
        Customer: Record Customer;
    begin
        SchoolSetup.Get();
        if not Customer.get(AdmissionNo) then begin
            Customer.Init();
            Customer."No." := AdmissionNo;
            Customer.Name := FullName;
            Customer."Customer Posting Group" := SchoolSetup."Student Posting Group";
            Customer."Gen. Bus. Posting Group" := SchoolSetup."Student Bus. Posting Group";
            Customer.Insert();
        end;
    end;

    procedure BillStudent(StructureCode: Code[20]; AdmissionNo: Code[20])
    var
        FeeSetup: Record "Fee Codes";
        InvoiceNo: Code[20];
        LineNo: Integer;
        SalesHeader: Record "Sales Header";
        SalesPost: Codeunit "Sales Post Invoice";
        FeeStructure: Record "Fee Structure Header";
        CustLedger: Record "Cust. Ledger Entry";
    begin
        CustLedger.Reset();
        CustLedger.SetRange("External Document No.", StructureCode);
        CustLedger.SetRange(Reversed, false);
        CustLedger.SetRange("Customer No.", AdmissionNo);
        if CustLedger.IsEmpty then begin
            FeeStructure.Get(StructureCode);
            FeeStructure.TestField("Posting Date");
            LineNo := 1000;
            StudentRegister.Get(AdmissionNo);
            CreateBillingAccount(AdmissionNo, StudentRegister."Full Name");
            InvoiceNo := '';
            InvoiceNo := CreateSalesHeader(StudentRegister."Admission No", FeeStructure."Posting Date", StructureCode, FeeStructure."Structure Description");
            FeeStructureDetailLines.Reset();
            FeeStructureDetailLines.SetRange("Structure Code", StructureCode);
            FeeStructureDetailLines.SetRange("Stage Code", StudentRegister."Stage Code");
            if FeeStructureDetailLines.FindSet() then begin
                repeat
                    FeeSetup.Get(FeeStructureDetailLines."Fee Code");
                    if StudentRegister."Fee % Payable" = 0 then
                        StudentRegister."Fee % Payable" := 100;
                    CreateSalesLine(InvoiceNo, LineNo, FeeSetup."Post to Account No", FeeStructureDetailLines.Amount * StudentRegister."Fee % Payable" * 0.01);
                until FeeStructureDetailLines.Next() = 0;
            end;
            SalesHeader.get(SalesHeader."Document Type"::Invoice, InvoiceNo);
            Codeunit.Run(Codeunit::"Sales-Post", SalesHeader);
        end;
    end;

    procedure PostIndividualFee(DocumentNo: Code[20])
    var
        LineNo: Integer;
        IndividualFee: Record "Individual Fee Hdr.";
        AdmissionNo, InvoiceNo : Code[20];
        IndividualLines: Record "Individual Fee Lines";
        SalesHeader: Record "Sales Header";
    begin
        IndividualFee.Get(DocumentNo);
        AdmissionNo := IndividualFee."Admission No";
        StudentRegister.Get(IndividualFee."Admission No");
        LineNo := 1000;
        StudentRegister.Get(AdmissionNo);
        CreateBillingAccount(AdmissionNo, StudentRegister."Full Name");
        InvoiceNo := '';
        InvoiceNo := CreateSalesHeader(StudentRegister."Admission No", Today, DocumentNo, 'Individual Invoicing ' + AdmissionNo);
        IndividualLines.Reset();
        IndividualLines.SetRange("Document No", DocumentNo);
        if IndividualLines.FindSet() then begin
            repeat
                CreateSalesLine(InvoiceNo, LineNo, IndividualLines."Account No", IndividualLines.Amount);
            until IndividualLines.Next() = 0;
        end;
        SalesHeader.get(SalesHeader."Document Type"::Invoice, InvoiceNo);
        Codeunit.Run(Codeunit::"Sales-Post", SalesHeader);
        IndividualFee.Processed := true;
        IndividualFee."Processed By" := UserId;
        IndividualFee."Processed On" := CurrentDateTime;
        IndividualFee.Modify();
    end;

    local procedure CreateSalesHeader(CustomerNo: Code[20]; PostingDate: Date; StructureCode: Code[20]; PostingDescription: Text) InvoiceNo: Code[20]
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesReceivablesSetup.get;
        SalesReceivablesSetup.TestField("Invoice Nos.");
        SalesReceivablesSetup.TestField("Posted Invoice Nos.");
        InvoiceNo := '';
        InvoiceNo := NoSeries.GetNextNo(SalesReceivablesSetup."Invoice Nos.", PostingDate, true);
        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
        SalesHeader."No." := InvoiceNo;
        SalesHeader."Document Date" := PostingDate;
        SalesHeader.Validate("Sell-to Customer No.", CustomerNo);
        SalesHeader."Posting No. Series" := SalesReceivablesSetup."Posted Invoice Nos.";
        SalesHeader.Validate("Posting Date", PostingDate);
        SalesHeader."External Document No." := StructureCode;
        SalesHeader."Posting Description" := PostingDescription;
        SalesHeader.Insert();
        exit(InvoiceNo);
    end;

    local procedure CreateSalesLine(InvoiceNo: Code[20]; var LineNo: Integer; AccountNo: Code[20]; Amount: Decimal)
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.Init();
        SalesLine."Document Type" := SalesLine."Document Type"::Invoice;
        SalesLine."Document No." := InvoiceNo;
        SalesLine."Line No." := LineNo;
        LineNo += 1000;
        SalesLine.Type := SalesLine.Type::"G/L Account";
        SalesLine.Validate("No.", AccountNo);
        SalesLine.Validate(Quantity, 1);
        SalesLine.Validate("Unit Price", Amount);
        SalesLine.Insert();
    end;

    procedure PostPaymentVoucher(PaymentVoucher: record "Payments Header")
    var
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalBatch: Record "Gen. Journal Batch";
        JournalTemplate: Code[20];
        JournalBatch: Code[20];
        DocumentNo: Code[20];
        LineNo: Integer;
        PostingDate: date;
        PaymentVoucherLines: Record "Payment Voucher Lines";
    begin
        Dim1 := PaymentVoucher."Global Dimension 1 Code";
        Dim2 := PaymentVoucher."Global Dimension 2 Code";
        JournalBatch := 'PV';
        JournalTemplate := 'PAYMENT';
        if not GenJournalBatch.get(JournalTemplate, JournalBatch) then begin
            GenJournalBatch.Init();
            GenJournalBatch."Journal Template Name" := JournalTemplate;
            GenJournalBatch.Name := JournalBatch;
            GenJournalBatch.Insert();
        end;
        PaymentVoucher.CalcFields("Payment Amount");
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
        GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
        if GenJournalLine.FindSet() then
            GenJournalLine.DeleteAll();
        LineNo := 1000;
        PostingDate := PaymentVoucher."Posting Date";
        DocumentNo := PaymentVoucher."Document No.";
        GenJournalLine.INIT;
        GenJournalLine."Journal Template Name" := JournalTemplate;
        GenJournalLine."Journal Batch Name" := JournalBatch;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Posting Date" := PostingDate;
        LineNo += 1000;
        case PaymentVoucher."Paying Account Type" of
            PaymentVoucher."Paying Account Type"::"Bank Account":
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::"Bank Account";
            PaymentVoucher."Paying Account Type"::"G/L Account":
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
        end;
        GenJournalLine.VALIDATE("Account No.", PaymentVoucher."Paying Account No.");
        GenJournalLine."Credit Amount" := PaymentVoucher."Payment Amount";
        GenJournalLine.VALIDATE("Credit Amount");
        GenJournalLine."Message to Recipient" := PaymentVoucher."Posting Description";
        GenJournalLine.Description := GenJournalLine."Message to Recipient";
        GenJournalLine."Due Date" := PaymentVoucher."Posting Date";
        GenJournalLine."Reason Code" := DocumentNo;
        GenJournalLine."Source Code" := 'PAYMENTS';
        GenJournalLine."External Document No." := PaymentVoucher."Cheque No";
        GenJournalLine.Validate("Shortcut Dimension 1 Code", Dim1);
        GenJournalLine.Validate("Shortcut Dimension 2 Code", Dim2);
        IF GenJournalLine.Amount <> 0 THEN GenJournalLine.INSERT;

        PaymentVoucherLines.Reset();
        PaymentVoucherLines.SetRange("Document No", PaymentVoucher."Document No.");
        if PaymentVoucherLines.FindSet() then begin
            repeat
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := JournalTemplate;
                GenJournalLine."Journal Batch Name" := JournalBatch;
                GenJournalLine."Document No." := DocumentNo;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Posting Date" := PostingDate;
                LineNo += 1000;
                case PaymentVoucherLines."Pay-to Account Type" of
                    PaymentVoucherLines."Pay-to Account Type"::"Bank Account":
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"Bank Account";
                    PaymentVoucherLines."Pay-to Account Type"::Customer:
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
                    PaymentVoucherLines."Pay-to Account Type"::"Fixed Asset":
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"Fixed Asset";
                    PaymentVoucherLines."Pay-to Account Type"::"G/L Account":
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                    PaymentVoucherLines."Pay-to Account Type"::Vendor:
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                end;
                GenJournalLine.VALIDATE("Account No.", PaymentVoucherLines."Account No");
                GenJournalLine."Debit Amount" := PaymentVoucherLines."Payment Amount";
                GenJournalLine.VALIDATE("Debit Amount");
                GenJournalLine."Message to Recipient" := PaymentVoucher."Posting Description";
                GenJournalLine.Description := GenJournalLine."Message to Recipient";
                GenJournalLine."Due Date" := PaymentVoucher."Posting Date";
                GenJournalLine."Reason Code" := DocumentNo;
                GenJournalLine."Source Code" := 'PAYMENTS';
                GenJournalLine."External Document No." := PaymentVoucher."Cheque No";
                GenJournalLine."Applies-to Doc. Type" := PaymentVoucherLines."Applies To Docu-Type";
                GenJournalLine."Applies-to Doc. No." := PaymentVoucherLines."Applies to Doc-Number";
                GenJournalLine.Validate("Shortcut Dimension 1 Code", Dim1);
                GenJournalLine.Validate("Shortcut Dimension 2 Code", Dim2);
                IF GenJournalLine.Amount <> 0 THEN GenJournalLine.INSERT;
            until PaymentVoucherLines.Next() = 0;
        end;
        Commit();
        GenJournalLine.RESET;
        GenJournalLine.SETFILTER("Account No.", '<>%1', '');
        GenJournalLine.SETRANGE("Journal Batch Name", JournalBatch);
        GenJournalLine.SETRANGE("Journal Template Name", JournalTemplate);
        IF GenJournalLine.FINDFIRST THEN CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJournalLine);
        PaymentVoucher.Posted := true;
        PaymentVoucher.Modify();
    end;

    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        StudentAdmission: Record "Student Admission";
        StudentRegister: Record "Student Register";
        NoSeries: Codeunit "No. Series";
        ProgramSetup: Record "Program Setup";
        SchoolSetup: Record "Gen. Setup";
        FeeStructureDetailLines: Record "Fee Structure Det. Lines";
        Dim1, Dim2 : COde[20];
}