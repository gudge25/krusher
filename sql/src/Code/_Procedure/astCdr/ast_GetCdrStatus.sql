DROP PROCEDURE IF EXISTS ast_GetCdrStatus;
DELIMITER $$
CREATE PROCEDURE ast_GetCdrStatus(
    $token              VARCHAR(100)
    , $GUID             VARCHAR(36)
)
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_GetCdrStatus');
  ELSE
    SELECT
      GUID
      , calldate
      , dst
      , disposition
    FROM ast_cdr
    WHERE Aid = $Aid
      AND GUID = $GUID
    LIMIT 1;
  END IF;
END $$
DELIMITER ;
--
