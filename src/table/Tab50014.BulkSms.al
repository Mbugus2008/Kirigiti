table 50014 "Bulk Sms"
{
    Caption = 'Bulk Sms';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No"; Code[30])
        {
            Caption = 'No';
        }
        field(2; "Send To"; Option)
        {
            Caption = 'Send To';
            OptionMembers = " ",Everyone,"External list";
            OptionCaption = ' ,Everyone,External list';
        }
        field(3; "Different text"; Boolean)
        {
            Caption = 'Different text';
        }
        field(4; "Text Message"; Text[250])
        {
            Caption = 'Text Message';
        }
        field(5; "Created by"; Code[30])
        {
            Caption = 'Created by';
            Editable = false;
        }
        field(6; "Date Created"; Date)
        {
            Caption = 'Date Created';
            Editable = false;
        }
        field(7; "Time Created"; Time)
        {
            Caption = 'Time Created';
            Editable = false;
        }
        field(8; "Sms Sent"; Boolean)
        {
            Caption = 'Sms Sent';
        }
        field(9; "Send To Details"; Code[30])
        {
            Caption = 'Send To Details';
        }
        field(10; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(11; "Text Message1"; Text[250])
        {
            Caption = 'Text Message1';
        }
    }

    keys
    {
        key(PK; "No")
        {
            Clustered = true;
        }
    }

    var
        GLSetup: Record "General Ledger Setup";
        NoSeries: Codeunit "No. Series";

    trigger OnInsert()
    begin
        if "No" = '' then begin
            GLSetup.Get();
            GLSetup.TestField("Bulk SMS Nos");
            "No" := NoSeries.GetNextNo(GLSetup."Bulk SMS Nos");
        end;

        "Created by" := CopyStr(UserId, 1, MaxStrLen("Created by"));
        "Date Created" := Today;
        "Time Created" := Time;
    end;
}
