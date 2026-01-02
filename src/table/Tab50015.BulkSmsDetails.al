table 50015 "Bulk Sms Details"
{
    Caption = 'Bulk Sms Details';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[30])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[500])
        {
            Caption = 'Description';
        }
        field(3; Bulk; Code[30])
        {
            Caption = 'Bulk';
            TableRelation = "Bulk Sms"."No";
        }
        field(4; "Mobile Number"; Code[50])
        {
            Caption = 'Mobile Number';
        }
    }

    keys
    {
        key(PK; Bulk, "Code")
        {
            Clustered = true;
        }
    }
}
