table 52204022 "Gen. Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Student Application Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(3; "Student Posting Group"; Code[20])
        {
            TableRelation = "Customer Posting Group";
        }
        field(4; "Student Bus. Posting Group"; Code[20])
        {
            TableRelation = "Gen. Business Posting Group";
        }
        field(5; "Cash Receipt Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(6; "PV Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(7; "Individual Fee Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
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