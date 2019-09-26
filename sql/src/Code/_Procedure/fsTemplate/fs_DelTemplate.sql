DELIMITER $$
DROP PROCEDURE IF EXISTS fs_DelTemplate;
CREATE PROCEDURE fs_DelTemplate(
    $token            VARCHAR(100)
    , $ftID           int
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fs_DelTemplate');
  ELSE
    delete c
    from fsTemplateItemCol c
      inner join fsTemplateItem i on i.ftiID = c.ftiID
    where i.ftID = $ftID AND i.Aid = $Aid;
    --
    delete from fsTemplateItem
    where ftID = $ftID AND Aid = $Aid;
    --
    delete from fsTemplate
    where ftID = $ftID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
