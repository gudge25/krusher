DELIMITER $$
DROP PROCEDURE IF EXISTS ast_DelIVREntries;
CREATE PROCEDURE ast_DelIVREntries(
    $token             VARCHAR(100)
    , $entry_id        INT
)
BEGIN
  DECLARE $Aid          INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_DelIVREntries');
  ELSE
    DELETE FROM ast_ivr_entries
    WHERE entry_id = $entry_id AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
