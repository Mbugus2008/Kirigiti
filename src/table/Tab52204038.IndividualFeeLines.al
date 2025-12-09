table 52204038 "Individual Fee Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Individual Fee Hdr.";
        }
        field(2; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Charge Code"; Code[20])
        {
            TableRelation = "Fee Codes";
            trigger OnValidate()
            var
                FeeCodes: Record "Fee Codes";
            begin
                FeeCodes.Get("Charge Code");
                "Charge Name" := FeeCodes."Posting Description";
                "Account No" := FeeCodes."Post to Account No";
            end;
        }
        field(4; "Amount"; Decimal)
        {
            BlankZero = true;
        }
        field(5; "Charge Name"; Text[100])
        {
            Editable = false;
        }
        field(6; "Account No"; Code[20])
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

    fieldgroups
    {
        // Add changes to field groups here
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