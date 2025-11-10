-- General trigger syntax

CREATE [OR REPLACE] TRIGGER trigger_name
{BEFORE | AFTER | INSTEAD OF } trigger_event --indicates timing of when trigger fires. trigger_event is what What causes trigger to fire
ON table_name
[FOR EACH ROW]
[WHEN (condition)] -- only applies to row-level triggers. tells oracle to only fire this trigger’s body for rows where this condition is true.
BEGIN    
    trigger_body
END trigger_name;
