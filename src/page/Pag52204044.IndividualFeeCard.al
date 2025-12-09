page 52204044 "Individual Fee Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Individual Fee Hdr.";
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                Editable = isOpen;
                field("Admission No"; "Admission No") { }
                field("Student Name"; "Student Name") { }
                field("Posting Date"; "Posting Date") { }
            }
            part("Fee Lines"; "Individual Fee Lines")
            {
                Editable = isOpen;
                SubPageLink = "Document No" = field("Document No");
            }
            group("Audit Trail")
            {
                Editable = isOpen;

                field("Created By"; "Created By") { }
                field("Created On"; "Created On") { }
                field(Processed; Processed) { }
                field("Processed On"; "Processed On") { }
            }
        }
        area(FactBoxes)
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
            action(Post)
            {
                Promoted = true;
                PromotedCategory = Process;
                Image = Position;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    StudentMgt: Codeunit "Student Management";
                begin
                    Rec.TestField("Posting Date");
                    Rec.TestField(Processed, false);
                    if Confirm('Do you want to Post?') = false then
                        exit;
                    StudentMgt.PostIndividualFee("Document No");
                    CurrPage.Close();
                end;
            }
        }
    }

    var
        isOpen: Boolean;

    trigger OnInit()
    begin
        isOpen := true;
    end;

    trigger OnAfterGetRecord()
    begin
        isOpen := (Processed = false);
    end;
}