tableextension 50016 "General Ledger Setup Ext" extends "General Ledger Setup"
{
    fields
    {
        field(50000; "Bulk SMS Nos"; Code[20])
        {
            Caption = 'Bulk SMS Nos';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
    }
}
