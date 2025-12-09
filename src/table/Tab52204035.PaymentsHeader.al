table 52204035 "Payments Header"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Payment Vouchers";
    LookupPageId = "Payment Vouchers";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Posting Date"; date)
        {
        }
        field(3; "Paying Account Type"; Option)
        {
            OptionMembers = "Bank Account","G/L Account";
        }
        field(4; "Paying Account No."; Code[20])
        {
            TableRelation = if ("Paying Account type" = const("Bank Account")) "Bank Account"
            else
            "G/L Account" where("Direct Posting" = const(true));

            trigger OnValidate()
            var
                BankAccount: Record "Bank Account";
                GLAccount: Record "G/L Account";
            begin
                if "Paying Account Type" = "Paying Account Type"::"Bank Account" then begin
                    if BankAccount.get("Paying Account No.") then "Paying Account Name" := BankAccount.Name;
                end
                else begin
                    if GLAccount.get("Paying Account No.") then "Paying Account Name" := GLAccount.Name;
                end;
            end;
        }
        field(5; "Paying Account Name"; Text[100])
        {
            Editable = false;
        }
        field(6; "Posting Description"; Text[50])
        {
        }
        field(7; "Cheque No"; code[30])
        {
        }
        field(10; "Payee Account Name"; Text[150])
        {
            Editable = false;
        }
        Field(11; "Payment Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Voucher Lines"."Payment Amount" where("Document No" = field("Document No.")));
        }
        field(12; "Approval Status"; Option)
        {
            Editable = false;
            OptionMembers = New,"Approval Pending",Approved;
        }
        field(13; Posted; Boolean)
        {
            Editable = false;
        }
        field(14; "Created By"; code[100])
        {
            Editable = false;
            TableRelation = "User Setup";
        }
        field(15; "Created On"; DateTime)
        {
            Editable = false;
        }
        field(16; "Global Dimension 1 Code"; code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(17; "Global Dimension 2 Code"; code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
    }
    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
    }
    var
        GeneralLedgerSetup: Record "Gen. Setup";
        NoSeries: Codeunit "No. Series";

    trigger OnInsert()
    begin
        GeneralLedgerSetup.Get();
        GeneralLedgerSetup.TestField("PV Nos.");
        "Document No." := NoSeries.GetNextNo(GeneralLedgerSetup."PV Nos.", Today, true);
        "Created By" := UserId;
        "Created On" := CurrentDateTime;
        "Posting Date" := Today;
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


