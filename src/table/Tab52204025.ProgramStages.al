table 52204025 "Program Stages"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Program Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Stage Code"; Code[20]) { }
        field(3; "Stage Name"; Text[100]) { }
    }

    keys
    {
        key(Key1; "Program Code", "Stage Code"
        )
        {
            Clustered = true;
        }
        key(Key2; "Stage Code", "Stage Name") { }
    }

    fieldgroups
    {
        // Add changes to field groups here
        fieldgroup(DropDown; "Stage Code", "Stage Name") { }
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