tableextension 50100 ProgramStageExt extends 52204025
{
    Caption = 'Program Stage Extension';

    fields
    {
        field(50100; Students; Integer)
        {
            Caption = 'Number of Students';
            FieldClass = FlowField;
            CalcFormula = Count("Student Register" where("Stage Code" = field("Stage Code")));
        }

        field(50101; IsActive; Boolean)
        {
            Caption = 'Is Active';
            DataClassification = CustomerContent;
            InitValue = true;
        }
    }



    trigger OnInsert()
    begin
        // ensure IsActive default on insert
        if not IsActive then
            IsActive := true;
    end;
}
