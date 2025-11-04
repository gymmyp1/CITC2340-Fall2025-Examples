-- General trigger syntax

CREATE [OR REPLACE] TRIGGER trigger_name
{BEFORE | AFTER | INSTEAD OF | FOR} trigger_event
ON table_name
[FOR EACH ROW]
[WHEN (condition)]
BEGIN    
    trigger_body
END trigger_name;
