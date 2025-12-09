table 52204027 "Student Admission Guardians"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Application No"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Relationship"; Enum "Family Tree") { }
        field(4; "Full Name"; Text[100]) { }
        field(5; "Email"; Text[100]) { }
        field(6; "Phone No"; Code[20]) { }
    }

    keys
    {
        key(Key1; "Application No", "Entry No")
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