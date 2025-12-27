table 50101 "School Summary"
{
    Caption = 'School Summary';
    DataPerCompany = true;

    fields
    {
        field(1; "Key"; Code[20])
        {
            Caption = 'Key';
        }
        field(4; "Date"; Date)
        {
            Caption = 'Date';
        }

        field(2; "Student Count"; Integer)
        {
            Caption = 'Student Count';
            FieldClass = FlowField;
            CalcFormula = Count("Student Register");
        }
        field(3; "Grade 1"; Integer)
        {
            Caption = 'Grade 1';
            FieldClass = FlowField;
            CalcFormula = Count("Student Register" where("Stage Code" = const('G1A')));
        }
        field(5; "G1B"; Integer)
        {
            Caption = 'G1B';
            FieldClass = FlowField;
            CalcFormula = Count("Student Register" where("Stage Code" = const('G1B')));
        }

        field(6; "G2"; Integer)
        {
            Caption = 'G2';
            FieldClass = FlowField;
            CalcFormula = Count("Student Register" where("Stage Code" = const('G2')));
        }

        field(7; "G3"; Integer)
        {
            Caption = 'G3';
            FieldClass = FlowField;
            CalcFormula = Count("Student Register" where("Stage Code" = const('G3')));

        }
        field(8; "G4"; Integer)
        {
            Caption = 'G4';
            FieldClass = FlowField;
            CalcFormula = Count("Student Register" where("Stage Code" = const('G4')));
        }

        field(9; "G5"; Integer)
        {
            Caption = 'G5';
            FieldClass = FlowField;
            CalcFormula = Count("Student Register" where("Stage Code" = const('G5')));
        }

        field(10; "G6"; Integer)
        {
            Caption = 'G6';
            FieldClass = FlowField;
            CalcFormula = Count("Student Register" where("Stage Code" = const('G6')));
        }
        field(11; "PG"; Integer)
        {
            Caption = 'PG';
            FieldClass = FlowField;
            CalcFormula = Count("Student Register" where("Stage Code" = const('PG')));
        }

        field(12; "PP1A"; Integer)
        {
            Caption = 'PP1A';
            FieldClass = FlowField;
            CalcFormula = Count("Student Register" where("Stage Code" = const('PP1A')));
        }
        field(13; "PP1B"; Integer)
        {
            Caption = 'PP1B';
            FieldClass = FlowField;
            CalcFormula = Count("Student Register" where("Stage Code" = const('PP1B')));
        }

        field(14; "PP2A"; Integer)
        {
            Caption = 'PP2A';
            FieldClass = FlowField;
            CalcFormula = Count("Student Register" where("Stage Code" = const('PP2A')));
        }
        field(15; "PP2B"; Integer)
        {
            Caption = 'PP2B';
            FieldClass = FlowField;
            CalcFormula = Count("Student Register" where("Stage Code" = const('PP2B')));
        }
        field(16; "Total Student Balances"; Decimal)
        {
            Caption = 'Total Student Balances';
            FieldClass = FlowField;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount);
        }
        field(17; "PG Balance"; Decimal)
        {
            Caption = 'PG Balance';
            DataClassification = CustomerContent;
        }
        field(18; "PP1A Balance"; Decimal)
        {
            Caption = 'PP1A Balance';
            DataClassification = CustomerContent;
        }
        field(19; "PP1B Balance"; Decimal)
        {
            Caption = 'PP1B Balance';
            DataClassification = CustomerContent;
        }
        field(20; "PP2A Balance"; Decimal)
        {
            Caption = 'PP2A Balance';
            DataClassification = CustomerContent;
        }
        field(21; "PP2B Balance"; Decimal)
        {
            Caption = 'PP2B Balance';
            DataClassification = CustomerContent;
        }
        field(22; "Grade 1 Balance"; Decimal)
        {
            Caption = 'Grade 1 Balance';
            DataClassification = CustomerContent;
        }
        field(23; "G2 Balance"; Decimal)
        {
            Caption = 'G2 Balance';
            DataClassification = CustomerContent;
        }
        field(24; "G3 Balance"; Decimal)
        {
            Caption = 'G3 Balance';
            DataClassification = CustomerContent;
        }
        field(25; "G4 Balance"; Decimal)
        {
            Caption = 'G4 Balance';
            DataClassification = CustomerContent;
        }
        field(26; "G5 Balance"; Decimal)
        {
            Caption = 'G5 Balance';
            DataClassification = CustomerContent;
        }

        field(27; "G6 Balance"; Decimal)
        {
            Caption = 'G6 Balance';
            DataClassification = CustomerContent;
        }

        field(28; "Mpesa Not posted"; Decimal)
        {
            Caption = 'Mpesa Not posted';
            FieldClass = FlowField;
            CalcFormula = sum("Mpesa Transactions"."Paid In" where(Processed = const(false)));
        }
    }
    keys
    {
        key(PK; "Key")
        {
            Clustered = true;
        }
    }
}
