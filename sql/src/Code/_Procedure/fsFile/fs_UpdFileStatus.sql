DROP PROCEDURE IF EXISTS fs_UpdFileStatus;
DELIMITER $$
CREATE PROCEDURE fs_UpdFileStatus(
    $token            VARCHAR(100)
    , $ffID           int
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid      INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fs_UpdFileStatus');
  ELSE
    if $ffID is NULL then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    end if;
    --
    call crm_IPUpdFileRegion($ffID);
    call crm_IPUpdStatusFile($ffID);
  END IF;
END $$
DELIMITER ;
--
