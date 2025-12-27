
table 50100 "Mpesa Transactions"
{
    Caption = 'Mpesa Transactions';
    DataPerCompany = true;

    fields
    {
        field(1; "Receipt No."; Code[20])
        {
            Caption = 'Receipt No.';
        }
        field(2; "Completion Time"; DateTime)
        {
            Caption = 'Completion Time';
        }
        field(3; "Detaills"; Text[250])
        {
            Caption = 'Detaills';
        }
        field(4; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = ,Completed,Incomplete;
            OptionCaption = ',Completed,Incomplete';
        }
        field(5; Withdrawn; Decimal)
        {
            Caption = 'Withdrawn';
        }
        field(6; "Paid In"; Decimal)
        {
            Caption = 'Paid In';
        }
        field(7; Balance; Decimal)
        {
            Caption = 'Balance';
        }
        field(8; "Balance Confirmed"; Option)
        {
            Caption = 'Balance Confirmed';
            OptionMembers = ,"TRUE","FALSE";
            OptionCaption = ',TRUE,FALSE';
        }
        field(9; "Deposit Type"; Text[100])
        {
            Caption = 'Deposit Type';
        }
        field(10; "Other Party Info"; Text[200])
        {
            Caption = 'Other Party Info';
        }
        field(11; "A/C No."; Text[200])
        {
            Caption = 'A/C No.';
        }
        field(12; Processed; Boolean)
        {
            Caption = 'Processed';
        }
        field(13; "Initiation Time"; DateTime)
        {
            Caption = 'Initiation Time';
        }
        field(14; "Paybil Number"; Code[50])
        {
            Caption = 'Paybil Number';
        }
        field(15; Phone; Text[250])
        {
            Caption = 'Phone';
        }
        field(16; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(17; "Transaction Date"; Date)
        {
            Caption = 'Transaction Date';
        }
        field(18; "Posting Date/Time"; DateTime)
        {
            Caption = 'Posting Date/Time';
        }
        field(19; "Time"; Time)
        {
            Caption = 'Time';
        }
        field(20; Comments; Text[250])
        {
            Caption = 'Comments';
        }
        field(21; Keyword; Code[30])
        {
            Caption = 'Keyword';
        }
        field(22; "ID No"; Code[30])
        {
            Caption = 'ID No';
        }
        field(23; "Transaction Type"; Option)
        {
            Caption = 'Transaction Type';
            OptionMembers = None,"Loan Repayment","Shares Capital","Deposit Contribution","Toto Savings","Chrismas savings","Plaza shares","Plaza Contribution","Sms Savings","RRF";
            OptionCaption = 'None,Loan Repayment,Shares Capital,Deposit Contribution,Toto Savings,Chrismas savings,Plaza shares,Plaza Contribution,Sms Savings,RRF';
        }
        field(24; "Loan No"; Code[30])
        {
            Caption = 'Loan No';
        }
        field(25; "Modified by"; Code[50])
        {
            Caption = 'Modified by';
        }
        field(26; Purpose; Code[20])
        {
            Caption = 'Purpose';
        }
        field(27; District; Code[50])
        {
            Caption = 'District';
        }
        field(28; "Posted Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Bank Account Ledger Entry".Amount WHERE("Document No." = FIELD("Receipt No.")));
            Caption = 'Posted Amount';
        }
        field(29; Currency; Code[20])
        {
            Caption = 'Currency';
        }
        field(30; Transtype; Option)
        {
            Caption = 'Transtype';
            OptionMembers = Receipts,Payments;
            OptionCaption = 'Receipts,Payments';
        }
        field(31; Charge; Decimal)
        {
            Caption = 'Charge';
        }
        field(32; Reference; Text[100])
        {
            Caption = 'Reference';
        }
        field(33; Student; Code[100])
        {
            Caption = 'Student';
            TableRelation = "Student Register"."Admission No";
        }
        field(34; Action_s; Option)
        {
            Caption = 'Action';
            optionmembers = Post,"Move to Receipts";
            optioncaption = 'Post,Move to Receipts';

        }
    }

    keys
    {
        key(PK; "Receipt No.")
        {
            Clustered = true;
        }
    }
    trigger OnModify()
    begin
        if StrLen(UserId()) > 50 then
            "Modified by" := CopyStr(UserId(), StrLen(UserId()) - 49, 50)
        else
            "Modified by" := UserId();
    end;

}
