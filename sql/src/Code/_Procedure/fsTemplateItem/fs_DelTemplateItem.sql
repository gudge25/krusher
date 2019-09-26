DELIMITER $$
DROP PROCEDURE IF EXISTS fs_DelTemplateItem;
CREATE PROCEDURE fs_DelTemplateItem(
    $token            VARCHAR(100)
    , $ftiID          int
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fs_DelTemplateItem');
  ELSE
    delete from fsTemplateItemCol
    where ftiID = $ftiID AND Aid = $Aid;
    --
    delete from fsTemplateItem
    where ftiID = $ftiID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
