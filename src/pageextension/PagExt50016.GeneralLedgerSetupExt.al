pageextension 50016 "General Ledger Setup Ext" extends "General Ledger Setup"
{
    layout
    {
        addlast(content)
        {
            group(SMS)
            {
                Caption = 'SMS';

                field("Bulk SMS Nos"; Rec."Bulk SMS Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for Bulk SMS.';
                }
            }
        }
    }
}
