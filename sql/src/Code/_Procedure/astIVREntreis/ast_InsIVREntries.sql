DELIMITER $$
DROP PROCEDURE IF EXISTS ast_InsIVREntries;
CREATE PROCEDURE ast_InsIVREntries(
  $token              VARCHAR(100)
  , $entry_id         INT(11)
  , $id_ivr_config    INT(11)
  , $extension        VARCHAR(20)
  , $destination      INT(11)
  , $destdata         INT(11)
  , $destdata2        VARCHAR(100)
  , $return           BIT
  , $isActive         BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid          INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_InsIVREntries');
  ELSE
    INSERT INTO ast_ivr_entries (
      entry_id
      , Aid
      , id_ivr_config
      , extension
      , destination
      , destdata
      , destdata2
      , `return`
      , isActive
      , HIID
    )
    VALUES (
      $entry_id
      , $Aid
      , $id_ivr_config
      , $extension
      , $destination
      , $destdata
      , $destdata2
      , IF($return IS NULL, 0, $return)
      , $isActive
      , fn_GetStamp()
    );
    --
    #SELECT LAST_INSERT_ID() entry_id;
  END IF;
END $$
DELIMITER ;
--
