page 52204032 "Fee Structure"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Fee Structure Header";

    layout
    {
        area(Content)
        {
            group("Fee Details")
            {
                field("Structure Code"; "Structure Code")
                {

                }
                field("Program Code"; "Program Code") { }
                field("Structure Description"; "Structure Description") { }
                field("Start Date"; "Start Date") { }
                field("End Date"; "End Date") { }
                field("Posting Date"; "Posting Date") { }
            }
            part("Fee Structure Details"; "Fee Structure Lines")
            {
                SubPageLink = "Structure Code" = field("Structure Code");
            }
            group("Audit Trails")
            {
                Editable = false;
                field("Created By"; "Created By") { }
                field("Created On"; "Created On") { }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Post Student Fees")
            {
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    StudentMgt: Codeunit "Student Management";
                begin
                    if not Confirm('Do you want to Invoice') then
                        exit;
                    StudentMgt.BillFeeStructure(Rec."Structure Code");
                end;
            }
        }
    }

    var
        myInt: Integer;
}