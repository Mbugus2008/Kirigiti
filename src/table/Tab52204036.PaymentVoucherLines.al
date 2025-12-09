table 52204036 "Payment Voucher Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Pay-to Account Type"; Option)
        {
            OptionMembers = "G/L Account",Vendor,Customer,"Bank Account","Fixed Asset";
        }
        field(4; "Account No"; Code[20])
        {
            TableRelation = if ("Pay-to Account Type" = const("G/L Account")) "G/L Account" where("Direct Posting" = const(true))
            else
            if ("Pay-to Account Type" = const(Vendor)) Vendor
            else
            if ("Pay-to Account Type" = const(Customer)) Customer
            else
            if ("Pay-to Account Type" = const("Bank Account")) "Bank Account"
            else
            "Fixed Asset";

            trigger OnValidate()
            var
                FixedAsset: Record "Fixed Asset";
                Customer: Record Customer;
                Vendor: Record Vendor;
                BankAccount: Record "Bank Account";
                GLAccount: Record "G/L Account";
            begin
                case "Pay-to Account Type" of
                    "Pay-to Account Type"::"Bank Account":
                        begin
                            if BankAccount.get("Account No") then "Account Name" := BankAccount.Name;
                        end;
                    "Pay-to Account Type"::Customer:
                        begin
                            if Customer.get("Account No") then "Account Name" := Customer.Name;
                        end;
                    "Pay-to Account Type"::"Fixed Asset":
                        begin
                            if FixedAsset.Get("Account No") then "Account Name" := FixedAsset.Description;
                        end;
                    "Pay-to Account Type"::"G/L Account":
                        begin
                            if GLAccount.get("Account No") then "Account Name" := GLAccount.Name;
                        end;
                    "Pay-to Account Type"::Vendor:
                        begin
                            if Vendor.get("Account No") then "Account Name" := Vendor.Name;
                        end;
                end;
            end;
        }
        field(5; "Account Name"; Text[150])
        {
            Editable = false;
        }
        field(6; "Payment Amount"; Decimal)
        {
        }
        field(7; "Applies To Docu-Type"; Enum "Gen. Journal Document Type")
        {
            Editable = false;
        }
        field(8; "Applies to Doc-Number"; Code[20])
        {
            trigger OnLookup()
            var
                CustLedger: Record "Cust. Ledger Entry";
                VendorLedger: Record "Vendor Ledger Entry";
            begin
                if "Pay-to Account Type" In ["Pay-to Account Type"::Customer, "Pay-to Account Type"::Vendor] = false then Error('Application Can Not Be done for %1', "Pay-to Account Type");
                TestField("Account No");
                if "Pay-to Account Type" = "Pay-to Account Type"::Vendor then begin
                    VendorLedger.Reset();
                    VendorLedger.SetRange(Open, true);
                    VendorLedger.SetRange(Positive, false);
                    VendorLedger.SetRange("Vendor No.", "Account No");
                    IF PAGE.RUNMODAL(0, VendorLedger) = ACTION::LookupOK THEN begin
                        VendorLedger.CalcFields("Original Amount", "Remaining Amount");
                        "Applies to Doc-Number" := VendorLedger."Document No.";
                        "Applies To Docu-Type" := VendorLedger."Applies-to Doc. Type";
                        "Original Amount" := VendorLedger."Original Amount";
                        "Due Date" := VendorLedger."Due Date";
                        Description := VendorLedger.Description;
                        "Remaining Amount" := VendorLedger."Remaining Amount";
                    end;
                end
                else begin
                    CustLedger.Reset();
                    CustLedger.SetRange(Open, true);
                    CustLedger.SetRange(Positive, false);
                    CustLedger.SetRange("Customer No.", "Account No");
                    IF PAGE.RUNMODAL(0, CustLedger) = ACTION::LookupOK THEN begin
                        CustLedger.CalcFields("Original Amount", "Remaining Amount");
                        "Applies to Doc-Number" := CustLedger."Document No.";
                        "Applies To Docu-Type" := CustLedger."Applies-to Doc. Type";
                        "Original Amount" := CustLedger."Original Amount";
                        "Due Date" := CustLedger."Due Date";
                        Description := CustLedger.Description;
                        "Remaining Amount" := CustLedger."Remaining Amount";
                    end;
                end;
            end;
        }
        field(9; Description; Text[50])
        {
            Editable = false;
        }
        field(10; "Original Amount"; Decimal)
        {
            Editable = false;
        }
        field(11; "Due Date"; Date)
        {
            Editable = false;
        }
        field(12; "Remaining Amount"; Decimal)
        {
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "Document No", "Line No")
        {
            Clustered = true;
        }
    }
    var
        myInt: Integer;

    trigger OnInsert()
    begin
    end;

    trigger OnModify()
    begin
    end;

    trigger OnDelete()
    begin
    end;

    trigger OnRename()
    begin
    end;
}