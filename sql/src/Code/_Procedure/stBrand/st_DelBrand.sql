DELIMITER $$
DROP PROCEDURE IF EXISTS st_DelBrand;
CREATE PROCEDURE st_DelBrand(
    $token        VARCHAR(100)
    , $bID        int
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'st_DelBrand');
  ELSE
    if ($bID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    --
    delete from stBrand
    where bID = $bID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
