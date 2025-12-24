table 52204026 "Student Admission"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "Full Name", "Date of Birth";

    fields
    {
        field(1; "Application No"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "First Name"; Text[100])
        {
            trigger OnValidate()
            begin
                Validate("Full Name");
            end;
        }
        field(3; "Middle Name"; Text[100])
        {
            trigger OnValidate()
            begin
                Validate("Full Name");
            end;
        }
        field(4; "Last Name"; Text[100])
        {
            trigger OnValidate()
            begin
                Validate("Full Name");
            end;
        }
        field(5; "Full Name"; Text[300])
        {
            Editable = false;
            trigger OnValidate()
            begin
                "Full Name" := "Last Name" + ' ' + "Middle Name" + ' ' + "First Name";
            end;
        }
        field(6; "Date of Birth"; Date) { }
        field(7; "Gender"; Option)
        {
            OptionMembers = " ",Male,Female;
        }
        field(8; "Program Code"; Code[20])
        {
            TableRelation = "Program Setup"."Program Code";
        }
        field(9; "Program Name"; Text[100])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Program Setup"."Program Name" where("Program Code" = field("Program Code")));
        }
        field(10; "Stage Code"; Code[20])
        {
            TableRelation = "Program Stages"."Stage Code" where("Program Code" = field("Program Code"));
        }
        field(11; "Stage Name"; Text[100])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Program Stages"."Stage Name" where("Program Code" = field("Program Code"), "Stage Code" = field("Stage Code")));
        }
        field(12; "Admission No"; Code[20]) { }
        field(13; "Student Image"; blob)
        {
            Subtype = Bitmap;
        }
        field(14; Address; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15; City; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(16; County; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17; Nationality; Code[20]) { }
        field(18; PWD; Boolean) { }
        field(19; "PWD Description"; Text[50]) { }
        field(50; "Created By"; Code[100])
        {
            Editable = false;
        }
        field(51; "Created On"; DateTime)
        {
            Editable = false;
        }
        field(52; Processed; Boolean) { }

        field(54; Location; Code[50])
        {
            TableRelation = Location."Code";
        }
    }

    keys
    {
        key(Key1; "Application No")
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
        GenSetup.TestField("Student Application Nos.");
        "Application No" := NoSeries.GetNextNo(GenSetup."Student Application Nos.", Today, true);
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