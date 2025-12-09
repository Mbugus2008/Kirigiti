table 52204032 "Fee Structure Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Structure Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Stage Code"; Code[20]) { }
        field(3; "Stage Name"; Text[100])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Program Stages"."Stage Name" where("Stage Code" = field("Stage Code")));
        }
        field(4; "Total Fee"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Fee Structure Det. Lines".Amount where("Structure Code" = field("Structure Code"), "Stage Code" = field("Stage Code")));
        }
    }

    keys
    {
        key(Key1; "Structure Code", "Stage Code")
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