page 50116 "Bulk Sms Details Subpage"
{
    ApplicationArea = All;
    Caption = 'Bulk Sms Details';
    PageType = ListPart;
    SourceTable = "Bulk Sms Details";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code.';
                }
                field("Mobile Number"; Rec."Mobile Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the mobile number.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description or custom message.';
                }
            }
        }
    }
}
