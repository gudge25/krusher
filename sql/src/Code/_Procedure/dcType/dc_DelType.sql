DROP PROCEDURE IF EXISTS dc_DelType;
DELIMITER $$
CREATE PROCEDURE dc_DelType(
    $token        VARCHAR(100)
    , $dctID      int
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'dc_DelType');
  ELSE
    if ($dctID is NULL) then
      call RAISE(77021,NULL);
    end if;
    --
    delete from dcType
    where dctID = $dctID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
