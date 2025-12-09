table 52204023 "Unit Setup"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Unit Setup";
    LookupPageId = "Unit Setup";
    fields
    {
        field(1; "Unit Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Unit Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Unit Code")
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