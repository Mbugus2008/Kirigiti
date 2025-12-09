table 52204037 "Individual Fee Hdr."
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Admission No"; Code[20])
        {
            TableRelation = "Student Register";
            trigger OnValidate()
            var
                Students: Record "Student Register";
            begin
                Students.Get("Admission No");
                "Student Name" := Students."Full Name";
                "Stage Code" := Students."Stage Code";
                "Program Code" := Students."Program Code";
            end;
        }
        field(3; "Student Name"; Text[100])
        {
            Editable = false;
        }
        field(4; "Stage Code"; Code[20])
        {
            Editable = false;
        }
        field(5; "Program Code"; Code[20])
        {
            Editable = false;
        }
        field(6; "Posting Date"; Date) { }
        field(7; "Created On"; DateTime)
        {
            Editable = false;
        }
        field(8; "Created By"; Code[20])
        {
            TableRelation = "User Setup";
            Editable = false;
        }
        field(9; "Processed On"; DateTime)
        {
            Editable = false;
        }
        field(10; "Processed By"; Code[100])
        {
            TableRelation = "User Setup";
            Editable = false;
        }
        field(11; "Processed"; Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        NoSeries: Codeunit "No. Series";
        GenSetup: Record "Gen. Setup";

    trigger OnInsert()
    begin
        GenSetup.Get();
        GenSetup.TestField("Individual Fee Nos.");
        "Document No" := NoSeries.GetNextNo(GenSetup."Individual Fee Nos.", Today, true);
        "Created By" := UserId;
        "Created On" := CurrentDateTime;
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