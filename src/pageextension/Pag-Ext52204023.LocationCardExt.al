pageextension 52204023 "Location Card Extension" extends "Location Card"
{
    layout
    {
        addafter(Name)
        {
            field("Transport Amount"; Rec."Transport Amount")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the transport amount for this location.';
            }
        }
    }
}
