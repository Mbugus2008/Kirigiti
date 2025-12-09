page 52204041 "Payment Voucher"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Payments Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Editable = isOpen;

                field("Document No."; Rec."Document No.")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
            }
            group("Payer Infomration")
            {
                Editable = isOpen;

                field("Paying Account Type"; Rec."Paying Account Type")
                {
                }
                field("Paying Account No."; Rec."Paying Account No.")
                {
                }
                field("Paying Account Name"; Rec."Paying Account Name")
                {
                }
                field("Posting Description"; Rec."Posting Description")
                {
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ShowMandatory = true;
                }
                field("Payment Amount"; rec."Payment Amount") { }
            }
            part("Payment Voucher Lines"; "Payment Voucher Lines")
            {
                SubPageLink = "Document No" = field("Document No.");
            }
            group("Audit Trail")
            {
                Editable = isOpen;

                field("Created By"; Rec."Created By")
                {
                }
                field("Created On"; Rec."Created On")
                {
                }
                field("Approval Status"; Rec."Approval Status")
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Print)
            {
                Promoted = true;
                Image = Print;

                trigger OnAction()
                var
                    PaymentVoucher: record "Payments Header";
                begin
                    PaymentVoucher.Reset();
                    PaymentVoucher.SetRange("Document No.", Rec."Document No.");
                    //if PaymentVoucher.FindSet() then Report.run(Report::"Payment Voucher", true, false, PaymentVoucher)
                end;
            }
            action(Post)
            {
                Promoted = true;
                Image = Post;

                trigger OnAction()
                var
                    StudentMgt: Codeunit "Student Management";
                begin
                    //Rec.TestField(Rec."Approval Status", Rec."Approval Status"::Approved);
                    if not confirm('Do you want to Post?') then exit;
                    StudentMgt.PostPaymentVoucher(rec);
                    currpage.Close();
                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;

                trigger OnAction();
                begin
                    //Rec.TestField("payment Amount");
                    //Rec.TestField("Payee Account No");
                    Rec.TestField("Paying Account No.");
                    Rec.TestField("Cheque No");
                    //if ApprovalsMgmtExt.CheckPaymentVoucherApprovalsWorkflowEnable(Rec) then
                    //ApprovalsMgmtExt.OnSendPaymentVoucherForApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = All;
                Image = CancelApprovalRequest;

                trigger OnAction();
                begin
                    //ApprovalsMgmtExt.OnCancelPaymentVoucherForApproval(Rec);
                    CurrPage.Close();
                end;
            }
            action(Comments)
            {
                ApplicationArea = all;
                Image = ViewComments;
                Promoted = true;

                trigger OnAction();
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.GetApprovalComment(Rec);
                end;
            }
            action(Approve)
            {
                ApplicationArea = all;
                Image = Approve;
                Promoted = true;

                trigger OnAction();
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    IF NOT CONFIRM('Are you sure you want to Approve the document?') THEN EXIT;
                    ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RECORDID);
                    CurrPage.CLOSE();
                end;
            }
            action(Reject)
            {
                ApplicationArea = all;
                Image = Reject;
                Promoted = true;

                trigger OnAction();
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    IF NOT CONFIRM('Are you sure you want to Reject the document?') THEN EXIT;
                    ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RECORDID);
                    CurrPage.CLOSE();
                end;
            }
            action(Delegate)
            {
                ApplicationArea = all;
                Image = Delegate;
                Promoted = true;

                trigger OnAction();
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    IF NOT CONFIRM('Are you sure you want to Delegate the document?') THEN EXIT;
                    ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RECORDID);
                    CurrPage.CLOSE();
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        isOpen := (Rec."Approval Status" = Rec."Approval Status"::New);
    end;

    trigger OnAfterGetRecord()
    begin
        isOpen := (Rec."Approval Status" = Rec."Approval Status"::New);
    end;

    var
        //ApprovalsMgmtExt: Codeunit "Approval Mgmt. Ext";
        isOpen: boolean;
    //PaymentManagement: Codeunit "Payments Management";
}