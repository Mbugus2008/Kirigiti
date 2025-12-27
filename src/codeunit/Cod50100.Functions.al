codeunit 50100 Functions
{
    procedure CreateSchoolSummaryIfMissing(KeyValue: Code[20]; RecDate: Date)
    var
        Summary: Record "School Summary";
    begin
        if not Summary.Get(KeyValue) then begin
            Summary.Init();
            Summary."Key" := KeyValue;
            Summary."Date" := RecDate;
            Summary.Insert(true);
        end;

        // TODO: Calculate balances for each stage when field structure is known
        // CalculateStageBalances(Summary);
    end;

    procedure PostAllUnpostedMpesaTransactions()
    var
        MpesaTrans: Record "Mpesa Transactions";
        Recipts: Record "Cash Receipt Header";
        RcptLine: Record "Cash Receipt Lines";

        PostedCount: Integer;
        SkippedCount: Integer;
        ErrorCount: Integer;
    begin
        PostedCount := 0;
        SkippedCount := 0;
        ErrorCount := 0;

        GetOrCreateMpesaJournalSetup('GENERAL', 'MPESA');

        // Filter to unprocessed transactions only
        MpesaTrans.SetRange(Processed, false);

        if not MpesaTrans.FindSet() then begin
            Message('No unposted transactions found.');
            exit;
        end;

        //repeat
        // Check if transaction is ready to post (Student, Transaction Date, and Paid In must be filled)
        if Mpesatrans.Action_s = MpesaTrans.Action_s::Post then begin
            if (MpesaTrans.Student <> '') and (MpesaTrans."Transaction Date" <> 0D) and (MpesaTrans."Paid In" <> 0) then begin
                // if TryPostMpesaTransaction(MpesaTrans) then
                //     PostedCount += 1
                // else
                //     ErrorCount += 1;
                TryPostMpesaTransaction(MpesaTrans)

            end

            else
                SkippedCount += 1;
        end
        else begin
            if MpesaTrans.Action_s = MpesaTrans.Action_s::"Move to Receipts" then begin
                // Move to Cash Receipt Header and Lines
                Recipts.Init();
                Recipts."Receipt No." := MpesaTrans."Receipt No.";
                Recipts."Posting Date" := MpesaTrans."Transaction Date";
                Recipts."Posting Description" := StrSubstNo(MpesaTrans.Name, ' ', MpesaTrans."A/C No.");
                Recipts."Receiving Account Type" := Recipts."Receiving Account Type"::"Bank Account";
                Recipts."Receiving Account No." := 'BNK002'; // Default Bank Account, adjust as needed
                Recipts."Payment Method" := 'MPESA';
                Recipts."Amount Received" := MpesaTrans."Paid In";
                Recipts.Insert(true);

                // Mark transaction as processed
                MpesaTrans.Processed := true;
                MpesaTrans."Posting Date/Time" := CurrentDateTime();
                MpesaTrans.Modify(true);
            end;
        end;
        //  until MpesaTrans.Next() = 0;
        PostTransaction();
        Message('Posting Complete:\%1 transaction(s) posted successfully.\%2 transaction(s) skipped (missing student, date, or amount).\%3 transaction(s) failed.', PostedCount, SkippedCount, ErrorCount);
    end;

    // [TryFunction]
    local procedure TryPostMpesaTransaction(var MpesaTrans: Record "Mpesa Transactions")
    var
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlTemplate: Record "Gen. Journal Template";
        LineNo: Integer;
        PostingDate: Date;
    begin
        // Use Transaction Date (already validated before calling this function)
        PostingDate := MpesaTrans."Transaction Date";
        // Get next line number
        GenJnlLine.SetRange("Journal Template Name", 'GENERAL');
        GenJnlLine.SetRange("Journal Batch Name", 'MPESA');
        if GenJnlLine.FindLast() then
            LineNo := GenJnlLine."Line No." + 10000
        else
            LineNo := 10000;
        // Create journal line
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := 'GENERAL';
        GenJnlLine."Journal Batch Name" := 'MPESA';
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Posting Date" := PostingDate;
        //GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Document No." := MpesaTrans."Receipt No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No." := 'BNK002'; // Default Bank Account, adjust as needed
        GenJnlLine.Description := StrSubstNo(MpesaTrans.Name, ' ', MpesaTrans."A/C No.");
        GenJnlLine.Amount := MpesaTrans."Paid In";
        GenJnlLine."External Document No." := MpesaTrans."Receipt No.";
        GenJnlLine.Insert(true);

        LineNo += 10000;
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := 'GENERAL';
        GenJnlLine."Journal Batch Name" := 'MPESA';
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Posting Date" := PostingDate;
        //GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Document No." := MpesaTrans."Receipt No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Customer";
        GenJnlLine."Account No." := MpesaTrans.Student;
        GenJnlLine.Description := StrSubstNo(MpesaTrans.Name, ' ', MpesaTrans."A/C No.");
        GenJnlLine.Amount := -MpesaTrans."Paid In";
        GenJnlLine."External Document No." := MpesaTrans."Receipt No.";
        GenJnlLine.Insert(true);

        // Mark transaction as processed
        MpesaTrans.Processed := true;
        MpesaTrans."Posting Date/Time" := CurrentDateTime();
        MpesaTrans.Modify(true);

    end;

    procedure CreateMpesaJournalTemplate(): Code[10]
    var
        GenJnlTemplate: Record "Gen. Journal Template";
        TemplateName: Code[10];
    begin
        TemplateName := 'MPESA';

        if GenJnlTemplate.Get(TemplateName) then
            exit(TemplateName);

        GenJnlTemplate.Init();
        GenJnlTemplate.Name := TemplateName;
        GenJnlTemplate.Description := 'Mpesa Transactions';
        GenJnlTemplate.Type := GenJnlTemplate.Type::General;
        GenJnlTemplate."Page ID" := Page::"General Journal";
        GenJnlTemplate.Recurring := false;
        GenJnlTemplate.Insert(true);

        exit(TemplateName);
    end;

    procedure CreateMpesaJournalBatch(TemplateName: Code[10]): Code[10]
    var
        GenJnlBatch: Record "Gen. Journal Batch";
        BatchName: Code[10];
    begin
        BatchName := 'MPESA';

        if GenJnlBatch.Get(TemplateName, BatchName) then
            exit(BatchName);

        GenJnlBatch.Init();
        GenJnlBatch."Journal Template Name" := TemplateName;
        GenJnlBatch.Name := BatchName;
        GenJnlBatch.Description := 'Mpesa Transactions Batch';
        GenJnlBatch.Insert(true);

        exit(BatchName);
    end;

    procedure GetOrCreateMpesaJournalSetup(TemplateName: Code[10]; BatchName: Code[10])
    begin
        //TemplateName := CreateMpesaJournalTemplate();
        BatchName := CreateMpesaJournalBatch(TemplateName);
    end;

    local procedure PostTransaction()
    var
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        GenJnlLine: Record "Gen. Journal Line";
    begin
        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", 'GENERAL');
        GenJnlLine.SetRange("Journal Batch Name", 'MPESA');

        if GenJnlLine.FindSet() then
            repeat
                GLPosting.Run(GenJnlLine);
            until GenJnlLine.Next() = 0;
    end;


}
