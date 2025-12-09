table 52204029 "Fee Structure Header"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Fee Structures";
    LookupPageId = "Fee Structures";
    fields
    {
        field(1; "Structure Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Structure Description"; Text[100]) { }
        field(3; "Program Code"; Code[20])
        {
            TableRelation = "Program Setup";
            trigger OnValidate()
            var
                FeeStructureLines: Record "Fee Structure Lines";
                Stages: Record "Program Stages";
            begin
                FeeStructureLines.Reset();
                FeeStructureLines.SetRange("Structure Code", "Structure Code");
                FeeStructureLines.DeleteAll();
                Stages.Reset();
                Stages.SetRange("Program Code", "Program Code");
                if Stages.FindSet() then begin
                    repeat
                        FeeStructureLines.Init();
                        FeeStructureLines."Structure Code" := "Structure Code";
                        FeeStructureLines."Stage Code" := Stages."Stage Code";
                        FeeStructureLines.Insert();
                    until Stages.Next() = 0;
                end;
            end;
        }
        field(4; "Start Date"; Date) { }
        field(5; "End Date"; Date) { }
        field(6; "Posting Date"; Date) { }
        field(50; "Created By"; Code[100])
        {
            Editable = false;
        }
        field(51; "Created On"; DateTime)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Structure Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
        fieldgroup(DropDown; "Structure Code", "Structure Description") { }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin
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