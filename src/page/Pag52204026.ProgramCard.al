page 52204026 "Program Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Program Setup";

    layout
    {
        area(Content)
        {
            group("Program Information")
            {
                field("Program Code"; "Program Code")
                {

                }
                field("Program Name"; "Program Name") { }
                field("Student Admission Nos."; "Student Admission Nos.") { }
            }
            part("Stages"; "Program Stages")
            {
                SubPageLink = "Program Code" = field("Program Code");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}