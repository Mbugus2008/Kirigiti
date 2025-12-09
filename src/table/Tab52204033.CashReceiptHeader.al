table 52204033 "Cash Receipt Header"
{

    fields
    {
        field(1; "Receipt No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Posting Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Payment Method"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method".Code;
        }
        field(5; "External Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Receiving Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Customer,Bank Account,G/L Account,Vendor';
            OptionMembers = Customer,"Bank Account","G/L Account",Vendor;
        }
        field(10; "Receiving Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Receiving Account Type" = CONST(Customer)) Customer."No."
            ELSE
            IF ("Receiving Account Type" = CONST("Bank Account")) "Bank Account"."No."
            ELSE
            IF ("Receiving Account Type" = CONST("G/L Account")) "G/L Account"."No." WHERE("Direct Posting" = CONST(true));

            trigger OnValidate()
            begin
                case "Receiving Account Type" of
                    "Receiving Account Type"::"Bank Account":
                        begin
                            if BankAccount.Get("Receiving Account No.") then begin
                                "Currency Code" := BankAccount."Currency Code";
                                "Receiving Account Name" := BankAccount.Name;
                            end;
                        end;
                    "Receiving Account Type"::Customer:
                        begin
                            if Customer.Get("Receiving Account No.") then begin
                                "Receiving Account Name" := Customer.Name;
                                "Currency Code" := Customer."Currency Code";
                            end;
                        end;
                    "Receiving Account Type"::"G/L Account":
                        begin
                            if GLAccount.Get("Receiving Account No.") then
                                "Receiving Account Name" := GLAccount.Name;
                        end;
                    "Receiving Account Type"::Vendor:
                        begin
                            if Vendor.Get("Receiving Account No.") then begin
                                "Receiving Account Name" := Vendor.Name;
                                "Currency Code" := Vendor."Currency Code";
                            end;
                        end;
                end;
            end;
        }
        field(11; "Receiving Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Amount Received"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Allocated Amount"; Decimal)
        {
            CalcFormula = Sum("Cash Receipt Lines"."Applied Amount" WHERE("Cash Receipt No." = FIELD("Receipt No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Created By"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "User Setup";
        }
        field(15; "Created On"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; "Source Type"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'User Created,System Created';
            OptionMembers = "User Created","System Created";
        }
        field(17; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "Currency Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency.Code;

            trigger OnValidate()
            begin
                "Exchange Rate" := CurrencyExchangeRate.ExchangeRate("Posting Date", "Currency Code");
            end;
        }
        field(19; "Exchange Rate"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            end;
        }
    }

    keys
    {
        key(Key1; "Receipt No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        GeneralLedgerSetup.Get;
        GeneralLedgerSetup.TestField("Cash Receipt Nos.");
        if "Receipt No." = '' then
            "Receipt No." := NoSeriesManagement.GetNextNo(GeneralLedgerSetup."Cash Receipt Nos.", Today, true);
        "Created By" := UserId;
        "Created On" := CreateDateTime(Today, Time);
        "Posting Date" := Today;
        "Receiving Account Type" := "Receiving Account Type"::"Bank Account";
    end;

    var
        NoSeriesManagement: Codeunit "No. Series";
        GeneralLedgerSetup: Record "Gen. Setup";
        Customer: Record Customer;
        GLAccount: Record "G/L Account";
        Vendor: Record Vendor;
        BankAccount: Record "Bank Account";
        CashReceiptLines: Record "Cash Receipt Lines";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        Currency: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";

    procedure PostReceipt()
    var
        JournalBatch: Code[20];
        JournalTemplate: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJournalTemplate: Record "Gen. Journal Template";
        RemainingAllocation: Decimal;
        PostingAmount: Decimal;
        PostingDate: Date;
        DocumentNo: Code[20];
        GeneralLedgerSetup: Record "General Ledger Setup";
        Dim1: Code[20];
        Dim2: Code[20];
        LineNo: Integer;
        GenJnlLine: Record "Gen. Journal Line";
    begin
        JournalBatch := 'CRCT';
        JournalTemplate := 'PAYMENT';
        GeneralLedgerSetup.Get;
        GeneralLedgerSetup.TestField("LCY Code");
        DocumentNo := "Receipt No.";
        if "Posting Date" = 0D then
            PostingDate := Today
        else
            PostingDate := "Posting Date";

        PostingAmount := "Amount Received";
        LineNo := 1000;
        if not GenJournalBatch.Get(JournalTemplate, JournalBatch) then begin
            GenJournalBatch.Init;
            GenJournalBatch."Journal Template Name" := JournalTemplate;
            GenJournalBatch.Name := JournalBatch;
            GenJournalBatch.Description := 'Cash Receipt Journals';
            GenJournalBatch.Insert;
        end;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
        GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
        if GenJournalLine.FindFirst then
            GenJournalLine.DeleteAll;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := JournalTemplate;
        GenJournalLine."Journal Batch Name" := JournalBatch;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Posting Date" := PostingDate;
        LineNo += 1000;
        case "Receiving Account Type" of
            "Receiving Account Type"::"Bank Account":
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::"Bank Account";
            "Receiving Account Type"::Customer:
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
            "Receiving Account Type"::"G/L Account":
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
            "Receiving Account Type"::Vendor:
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
        end;
        GenJournalLine.Validate("Account No.", "Receiving Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := Dim1;
        GenJournalLine."Shortcut Dimension 2 Code" := Dim2;
        GenJournalLine."Debit Amount" := Abs(PostingAmount);
        GenJournalLine.Validate("Debit Amount");
        GenJournalLine.Validate("Shortcut Dimension 1 Code");
        GenJournalLine."Message to Recipient" := CopyStr("Posting Description", 1, 50);
        GenJournalLine.Description := CopyStr("Posting Description", 1, 50);
        GenJournalLine."Payer Information" := "Created By";
        GenJournalLine."Payment Method Code" := "Payment Method";
        GenJournalLine."Payment Reference" := "External Document No.";
        GenJournalLine."External Document No." := "External Document No.";
        GenJournalLine.Validate("Currency Code", "Currency Code");
        if "Currency Code" <> '' then
            GenJournalLine.Validate("Currency Factor", "Exchange Rate");
        GenJournalLine.Validate("Shortcut Dimension 1 Code", Dim1);
        GenJournalLine.Validate("Shortcut Dimension 2 Code", Dim2);
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        RemainingAllocation := PostingAmount;
        CashReceiptLines.Reset;
        CashReceiptLines.SetFilter("Applied Amount", '>%1', 0);
        CashReceiptLines.SetRange("Cash Receipt No.", DocumentNo);
        if CashReceiptLines.FindSet() then begin
            repeat
                PostingAmount := CashReceiptLines."Applied Amount";
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := JournalTemplate;
                GenJournalLine."Journal Batch Name" := JournalBatch;
                GenJournalLine."Document No." := DocumentNo;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Posting Date" := PostingDate;
                LineNo += 1000;
                case CashReceiptLines."Account Type" of
                    CashReceiptLines."Account Type"::"Bank Account":
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"Bank Account";
                    CashReceiptLines."Account Type"::Customer:
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
                    CashReceiptLines."Account Type"::"G/L Account":
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                    CashReceiptLines."Account Type"::Vendor:
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                end;
                GenJournalLine.Validate("Account No.", CashReceiptLines."Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := Dim1;
                GenJournalLine."Shortcut Dimension 2 Code" := Dim2;
                GenJournalLine."Credit Amount" := Abs(PostingAmount);
                GenJournalLine.Validate("Credit Amount");
                GenJournalLine.Validate("Shortcut Dimension 1 Code");
                GenJournalLine."Message to Recipient" := CopyStr("Posting Description", 1, 50);
                GenJournalLine.Description := GenJournalLine."Message to Recipient";
                GenJournalLine."Payer Information" := "Created By";
                GenJournalLine."Payment Method Code" := "Payment Method";
                GenJournalLine."Payment Reference" := "External Document No.";
                GenJournalLine."External Document No." := "External Document No.";
                GenJournalLine.Validate("Currency Code", "Currency Code");
                GenJournalLine."External Document No." := "External Document No.";
                GenJournalLine."Applies-to Doc. No." := CashReceiptLines."Applies-To-Doc No";
                GenJournalLine.Validate("Applies-to Doc. No.");
                GenJournalLine."Applies-to Doc. Type" := CashReceiptLines."Applies-To-Doc. Type";
                if "Currency Code" <> '' then
                    GenJournalLine.Validate("Currency Factor", "Exchange Rate");
                GenJournalLine.Validate("Shortcut Dimension 1 Code", Dim1);
                GenJournalLine.Validate("Shortcut Dimension 2 Code", Dim2);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
            until CashReceiptLines.Next = 0;
        end;
        GenJournalLine.Reset;
        GenJournalLine.SetFilter("Account No.", '<>%1', '');
        GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
        GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
        if GenJournalLine.FindSet() then
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJournalLine);

        Posted := true;
        Modify;
        Commit();
        OnAfterPostCashReceipt(Rec);
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterPostCashReceipt(var CashReceiptHeader: Record "Cash Receipt Header")
    begin
    end;
}