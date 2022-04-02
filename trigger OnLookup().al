        SomePage.SetTableView(aRecord);
        SomePage.LookupMode := true;
        success := SomePage.RunModal();
        SomePage.SetSelectionFilter(aRecord);

        case success of
            action::OK, action::LookupOK:  
                 if aRecord.FindSet() then
                    repeat
                    until aRecord.next()=0 ;
        end;
