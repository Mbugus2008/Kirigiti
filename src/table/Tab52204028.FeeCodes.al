table 52204028 "Fee Codes"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "Fee Code", "Posting Description";
    LookupPageId = "Fee Codes";
    DrillDownPageId = "Fee Codes";
    fields
    {
        field(1; "Fee Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Posting Description"; Text[50]) { }
        field(3; "Post To Account Type"; Option)
        {
            OptionMembers = "G/L Account","Payable Account";
        }
        field(4; "Post to Account No"; Code[20])
        {
            TableRelation = if ("Post To Account Type" = const("G/L Account")) "G/L Account" where("Direct Posting" = const(true))
            else if ("Post To Account Type" = const("Payable Account")) Vendor."No." where(Blocked = const(" "))
            else
            "Bank Account";
        }
    }

    keys
    {
        key(Key1; "Fee Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
        fieldgroup(DropDown; "Fee Code", "Posting Description") { }
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