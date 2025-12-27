page 50101 "School Dashboard"
{
    PageType = CardPart;
    SourceTable = "School Summary";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup("School Overview")
            {
                field("Total Students"; "Student Count")
                {
                    Caption = 'Total Students';
                    DrillDownPageId = "Students";
                    LookupPageId = "Students";
                    ColumnSpan = 2;
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Total Student Balances"; "Total Student Balances")
                {
                    Caption = 'Total Student Balances';

                    ColumnSpan = 2;
                    Style = Unfavorable;
                    StyleExpr = BalanceStyleVar;
                }
                field("Mpesa Not posted"; "Mpesa Not posted")
                {
                    Caption = 'Payments Not posted';

                    ColumnSpan = 2;
                    Style = Unfavorable;
                    StyleExpr = BalanceStyleVar;
                    LookupPageId = "Mpesa Transactions View";
                    DrillDownPageId = "Mpesa Transactions View";
                }
            }
            cuegroup("Students Summary")
            {
                field("PG Students"; "PG")
                {
                    Caption = 'PG Students';
                    DrillDownPageId = "Students";
                    LookupPageId = "Students";
                }
                field("PP1A Students"; "PP1A")
                {
                    Caption = 'PP1A Students';
                    DrillDownPageId = "Students";
                    LookupPageId = "Students";
                }
                field("PP1B Students"; "PP1B")
                {
                    Caption = 'PP1B Students';
                    DrillDownPageId = "Students";
                    LookupPageId = "Students";
                }
                field("PP2A Students"; "PP2A")
                {
                    Caption = 'PP2A Students';
                    DrillDownPageId = "Students";
                    LookupPageId = "Students";
                }
                field("PP2B Students"; "PP2B")
                {
                    Caption = 'PP2B Students';
                    DrillDownPageId = "Students";
                    LookupPageId = "Students";
                }
                field("Grade 1 Students"; "Grade 1")
                {
                    Caption = 'Grade 1 Students';
                    DrillDownPageId = "Students";
                    LookupPageId = "Students";
                }
                field("Grade 2 Students"; "G2")
                {
                    Caption = 'Grade 2 Students';
                    DrillDownPageId = "Students";
                    LookupPageId = "Students";
                }
                field("Grade 3 Students"; "G3")
                {
                    Caption = 'Grade 3 Students';
                    DrillDownPageId = "Students";
                    LookupPageId = "Students";
                }
                field("Grade 4 Students"; "G4")
                {
                    Caption = 'Grade 4 Students';
                    DrillDownPageId = "Students";
                    LookupPageId = "Students";
                }
                field("Grade 5 Students"; "G5")
                {
                    Caption = 'Grade 5 Students';
                    DrillDownPageId = "Students";
                    LookupPageId = "Students";
                }
                field("Grade 6 Students"; "G6")
                {
                    Caption = 'Grade 6 Students';
                    DrillDownPageId = "Students";
                    LookupPageId = "Students";
                }

            }
        }
    }
    var
        SchoolSummary: Codeunit "Functions";
        BalanceStyleVar: Boolean;

    procedure StudentCountStyle(): Text
    begin
        if Rec."Student Count" > 0 then
            exit('Success');
        exit('Attention');
    end;

    procedure BalanceStyleExpr(): Text
    var
        BalanceStyleTxt: Text;
    begin
        Rec.CalcFields("Total Student Balances");
        if Rec."Total Student Balances" = 0 then
            BalanceStyleTxt := 'Favorable'
        else if Rec."Total Student Balances" < 100000 then
            BalanceStyleTxt := 'Attention'
        else
            BalanceStyleTxt := 'Unfavorable';
        exit(BalanceStyleTxt);
    end;

    procedure BalanceStyle(): Boolean
    begin
        Rec.CalcFields("Total Student Balances");
        exit(Rec."Total Student Balances" > 0);
    end;

    trigger OnOpenPage()
    begin

        SchoolSummary.CreateSchoolSummaryIfMissing("Key", Today());
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Total Student Balances");
        BalanceStyleVar := Rec."Total Student Balances" > 0;
    end;
}
