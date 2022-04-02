   actions
    {
        // Add changes to page actions here
        addbefore("Run Tests")
        {
            action(RefreshSomeInowWorkOn)
            {
                ApplicationArea = All;
                Caption = '&Refresh';
                ShortcutKey = 'Ctrl+Shift+E';

                trigger OnAction()
                var
                    TestLines: record "Test Method Line";
                    allobjwcaption: record AllObjWithCaption;
                    altestsuite: record "AL Test Suite";
                begin
                    TestLines.SetRange("Test Suite", rec."Test Suite");
                    TestLines.DeleteAll();

                    altestsuite.get(rec."Test Suite");
                    allobjwcaption.setrange("Object ID", 70432358); // <-- enter your test-codeunit ID here
                    if allobjwcaption.FindSet() then
                        repeat
                            AddTestMethod(allobjwcaption, altestsuite, 0);
                        until allobjwcaption.Next() = 0;
                end;
            }
        }
    }

    local procedure AddTestMethod(AllObjWithCaption: Record AllObjWithCaption; ALTestSuite: Record "AL Test Suite"; NextLineNo: Integer)
    var
        TestMethodLine: Record "Test Method Line";
    begin
        TestMethodLine."Test Suite" := ALTestSuite.Name;
        TestMethodLine."Line No." := NextLineNo;
        TestMethodLine."Test Codeunit" := AllObjWithCaption."Object ID";
        TestMethodLine.Validate("Line Type", TestMethodLine."Line Type"::Codeunit);
        TestMethodLine.Name := AllObjWithCaption."Object Name";
        TestMethodLine.Insert(true);

        CODEUNIT.Run(CODEUNIT::"Test Runner - Get Methods", TestMethodLine);
    end;
