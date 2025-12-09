table 52204024 "Program Setup"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "Program Code", "Program Name";
    DrillDownPageId = "Program Setup";
    LookupPageId = "Program Setup";
    fields
    {
        field(1; "Program Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Program Name"; Text[100]) { }
        field(3; "Student Admission Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Program Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
        fieldgroup(DropDown; "Program Code", "Program Name") { }
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