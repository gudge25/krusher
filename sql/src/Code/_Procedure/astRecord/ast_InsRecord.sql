DELIMITER $$
DROP PROCEDURE IF EXISTS ast_InsRecord;
CREATE PROCEDURE ast_InsRecord(
    $token            VARCHAR(100)
    , $record_name    VARCHAR(255)
    , $record_source  VARCHAR(1000)
    , $isActive       BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE id INT(11);
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_InsRecord');
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
    /*SELECT LAST_INSERT_ID() record_id;*/
  END IF;
END $$
DELIMITER ;
--
