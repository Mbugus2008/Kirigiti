table 52204030 "Fee Structure Det. Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Structure Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Fee Code"; Code[20])
        {
            TableRelation = "Fee Codes";
        }

        field(4; Description; Text[100])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Fee Codes"."Posting Description" where("Fee Code" = field("Fee Code")));
        }
        field(5; Amount; Decimal)
        {
            BlankZero = true;
        }
        field(6; "Stage Code"; Code[20]) { }
    }

    keys
    {
        key(Key1; "Structure Code", "Stage Code", "Line No")
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