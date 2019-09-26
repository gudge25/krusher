DELIMITER $$
DROP PROCEDURE IF EXISTS ast_InsFRecord;
CREATE PROCEDURE ast_InsFRecord(
    $record_name    VARCHAR(255)
    , $record_source  VARCHAR(1000)
    , $Aid            INT
    , $isActive       BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_InsFRecord');
  ELSE
    INSERT INTO ast_record
    (
      Aid
      , record_name
      , record_source
      , isActive
      , HIID
    )
    VALUES
    (
      $Aid
      , $record_name
      , $record_source
      , $isActive
      , fn_GetStamp()
    );
    --
    SELECT LAST_INSERT_ID() record_id;
  END IF;
END $$
DELIMITER ;
--
