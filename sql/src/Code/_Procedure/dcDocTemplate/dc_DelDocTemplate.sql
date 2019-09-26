DROP PROCEDURE IF EXISTS dc_DelDocTemplate;
DELIMITER $$
CREATE PROCEDURE dc_DelDocTemplate(
    $token        VARCHAR(100)
    , $dtID       int
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'dc_DelDocTemplate');
  ELSE
    if ($dtID is NULL) then
      call RAISE(77021,NULL);
    end if;
    --
    delete from dcDocTemplate
    where dtID = $dtID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
