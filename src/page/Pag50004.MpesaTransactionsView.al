page 50004 "Mpesa Transactions View"
{
    Caption = 'Mpesa Transactions List';
    ApplicationArea = All;
    Editable = true;
    PageType = List;
    SourceTable = "Mpesa Transactions";


    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Processed; Processed) { Editable = false; }
                field("Receipt No."; "Receipt No.") { Editable = false; }
                field("Transaction Date"; "Transaction Date") { Editable = false; }
                field(Student; Student) { }
                field(Action_s; Action_s) { }
                field("Paid In"; "Paid In") { Editable = false; }
                field("A/C No."; "A/C No.") { Editable = false; }
                field(Name; Name) { Editable = false; }
                field("Completion Time"; "Completion Time") { Editable = false; }
                field("Other Party Info"; "Other Party Info") { Editable = false; }
                field(Phone; Phone) { Editable = false; }
                field("Posting Date/Time"; "Posting Date/Time") { Editable = false; }
                field(Time; Time) { Editable = false; }
                field("Modified by"; "Modified by") { Editable = false; }
                field(Charge; Charge) { Editable = false; }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(PostAllUnposted)
            {
                Caption = 'Post All Unposted Mpesa Transactions';
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    post: Codeunit Functions;
                    Count: Integer;
                begin
                    post.PostAllUnpostedMpesaTransactions();
                end;
            }


        }

        area(Navigation)
        {
            action(Import)
            {
                Caption = 'Import from File';
                Image = Import;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    // TODO: call codeunit or implement file import logic here
                    Message('Import action not implemented.');
                end;
            }

            action(RefreshList)
            {
                Caption = 'Refresh';
                Image = Refresh;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    CurrPage.Update(false);
                end;
            }
        }
    }

}
