page 50100 "My Role Center"
{
    PageType = RoleCenter;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'My Dashboard';

    layout
    {
        area(rolecenter)
        {
            group("My Activities")
            {
                part("Students"; "School Dashboard") { }
            }


        }
    }
    actions
    {
        area(processing)
        {
            group("School Management")
            {
                group("Setups")
                {
                    action("General Setup")
                    {
                        Caption = 'School Setup';
                        RunObject = page "General Setup";
                    }
                    action("Units SEtup")
                    {
                        Caption = 'School Units Setup';
                        RunObject = page "Unit Setup";
                    }
                    action("Program Setup")
                    {
                        Caption = 'Program Setup';
                        RunObject = page "Program Setup";
                    }
                    action("Fee Setup")
                    {
                        RunObject = page "Fee Codes";
                    }
                    group("Payment Processes")
                    {
                        action("New Payment Vouchers")
                        {
                            RunObject = page "Payment Vouchers";
                        }
                    }
                }
                group(Processes)
                {
                    action("Student Admissions")
                    {
                        RunObject = page "Student Admissions";
                        RunPageView = where(Processed = const(false));
                    }
                    action("Student List")
                    {
                        RunObject = page Students;
                    }
                }
                group("Fees Management")
                {

                    action("Fee Structure Setup")
                    {
                        RunObject = page "Fee Structures";
                    }
                    action("Individual Fees - New")
                    {
                        RunObject = page "Individual Fee List";
                        RunPageView = where(Processed = const(false));
                    }
                    action("Individual Fees - Posted")
                    {
                        RunObject = page "Individual Fee List";
                        RunPageView = where(Processed = const(true));
                    }
                    group("Receipt Management")
                    {
                        action("New Receipts")
                        {
                            RunObject = page "Cash Receipts";
                        }
                    }
                }
                group("Payments Management")
                {
                    action("New Payment Voucher")
                    {
                        RunObject = page "Payment Vouchers";
                        RunPageView = where(Posted = const(false));
                    }
                    action("Posted Payment Voucher")
                    {
                        RunObject = page "Payment Vouchers";
                        RunPageView = where(Posted = const(true));
                    }
                }
                group("Reports & Analysis")
                {
                    action("Student Balances")
                    {
                        ApplicationArea = all;
                        RunObject = report "Student List";
                    }
                    action("Cash Book")
                    {
                        ApplicationArea = all;
                        RunObject = report "Cash Book";
                    }
                }
            }
        }
    }

}
