table 50000 "SMS Messages"
{
    Caption = 'SMS Messages';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            AutoIncrement = true;
        }
        field(2; Source; Code[100])
        {
            Caption = 'Source';
        }
        field(3; "Telephone No"; Code[30])
        {
            Caption = 'Telephone No';
        }
        field(4; "Date Entered"; Date)
        {
            Caption = 'Date Entered';
        }
        field(5; "Time Entered"; Time)
        {
            Caption = 'Time Entered';
        }
        field(6; "Entered By"; Code[50])
        {
            Caption = 'Entered By';
        }
        field(7; "SMS Message"; Text[250])
        {
            Caption = 'SMS Message';
        }
        field(8; "Sent To Server"; Option)
        {
            Caption = 'Sent To Server';
            OptionMembers = No,Yes,Failed;
            OptionCaption = 'No,Yes,Failed';
        }
        field(9; "Date Sent to Server"; Date)
        {
            Caption = 'Date Sent to Server';
        }
        field(10; "Time Sent To Server"; Time)
        {
            Caption = 'Time Sent To Server';
        }
        field(11; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(13; "Account No"; Code[30])
        {
            Caption = 'Account No';
        }
        field(14; "Batch No"; Code[30])
        {
            Caption = 'Batch No';
        }
        field(15; "Document No"; Code[30])
        {
            Caption = 'Document No';
        }
        field(16; "System Created Entry"; Boolean)
        {
            Caption = 'System Created Entry';
        }
        field(17; "Bulk SMS Balance"; Decimal)
        {
            Caption = 'Bulk SMS Balance';
        }
        field(18; Comments; Text[200])
        {
            Caption = 'Comments';
        }
        field(19; "SMS Message1"; Text[250])
        {
            Caption = 'SMS Message1';
        }
        field(20; "SMS Message2"; Text[250])
        {
            Caption = 'SMS Message2';
        }
        field(21; "SMS Message3"; Text[500])
        {
            Caption = 'SMS Message3';
        }
    }

    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
        key(Key2; "Telephone No", "Date Entered")
        {
        }
        key(Key3; "Sent To Server")
        {
        }
    }

    trigger OnInsert()
    begin
        "Date Entered" := Today;
        "Time Entered" := Time;
        "Entered By" := CopyStr(UserId, 1, MaxStrLen("Entered By"));
    end;
}
