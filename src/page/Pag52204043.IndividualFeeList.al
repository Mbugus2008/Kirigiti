page 52204043 "Individual Fee List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Individual Fee Card";
    SourceTable = "Individual Fee Hdr.";
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Document No"; "Document No")
                {

                }
                field("Admission No"; "Admission No") { }
                field("Student Name"; "Student Name") { }
                field("Posting Date"; "Posting Date") { }
                field("Created By"; "Created By") { }
                field("Created On"; "Created On") { }
                field(Processed; Processed) { }
                field("Processed On"; "Processed On") { }
            }
        }
        area(Factboxes)
        {
            part("Student Statistics"; "Customer Statistics FactBox")
            {
                SubPageLink = "No." = field("Admission No");
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
}