table 52204034 "Cash Receipt Lines"
{

    fields
    {
        field(1; "Cash Receipt No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            Editable = false;
            AutoIncrement = true;
        }
        field(3; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Bank Account,Student,G/L Account,Vendor';
            OptionMembers = "Bank Account",Customer,"G/L Account",Vendor;
        }
        field(4; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Account Type" = CONST("Bank Account")) "Bank Account"."No."
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer."No."
            ELSE
            IF ("Account Type" = CONST("G/L Account")) "G/L Account"."No." WHERE("Direct Posting" = CONST(true))
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor."No.";

            trigger OnValidate()
            begin
                case "Account Type" of
                    "Account Type"::"Bank Account":
                        begin
                            if BankAccount.Get("Account No.") then begin
                                "Receiving Account Name" := BankAccount.Name;
                            end;
                        end;
                    "Account Type"::Customer:
                        begin
                            if Customer.Get("Account No.") then begin
                                "Receiving Account Name" := Customer.Name;
                            end;
                        end;
                    "Account Type"::"G/L Account":
                        begin
                            if GLAccount.Get("Account No.") then
                                "Receiving Account Name" := GLAccount.Name;
                        end;
                    "Account Type"::Vendor:
                        begin
                            if Vendor.Get("Account No.") then begin
                                "Receiving Account Name" := Vendor.Name;
                            end;
                        end;
                end;
            end;
        }
        field(5; "Receiving Account Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(6; "Original Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Remaining Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Applied Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if (("Applied Amount" > "Remaining Amount") and ("Applies-To-Doc No" <> '')) then
                    Error('You Can Only Receive Upto %1', "Remaining Amount");
            end;
        }
        field(9; Description; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Applies-To-Doc No"; Code[20])
        {
            trigger OnLookup()
            var
                CustLedger: Record "Cust. Ledger Entry";
            begin
                case "Account Type" of
                    rec."Account Type"::Customer:
                        begin
                            CustLedger.Reset();
                            CustLedger.SetRange("Customer No.", "Account No.");
                            CustLedger.SetRange(Positive, true);
                            CustLedger.SetRange(Open, true);
                            if Page.RunModal(0, CustLedger) = Action::LookupOK then begin
                                CustLedger.CalcFields("Original Amount", "Remaining Amount");
                                "Applies-To-Doc No" := CustLedger."Document No.";
                                "Applies-To-Doc. Type" := CustLedger."Document Type";
                                "Original Amount" := CustLedger."Original Amount";
                                "Remaining Amount" := CustLedger."Remaining Amount";
                                Description := CustLedger.Description;
                                "Due Date" := CustLedger."Due Date";
                            end;
                        end;
                end;
            end;
        }
        field(11; "Applies-To-Doc. Type"; Enum "Sales Applies-to Document Type")
        {
            Editable = false;
        }
        field(12; "Due Date"; Date)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Cash Receipt No.", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    var
        Customer: Record Customer;
        BankAccount: Record "Bank Account";
        Vendor: Record Vendor;
        GLAccount: Record "G/L Account";
}