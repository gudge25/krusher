DROP PROCEDURE IF EXISTS crm_GetClientByContact;
DELIMITER $$
CREATE PROCEDURE crm_GetClientByContact(
    $token          VARCHAR(100)
    , $ccName       VARCHAR(50)
)
BEGIN
  DECLARE $Aid            INT;
  DECLARE $cName          BIGINT;
  DECLARE $cNameCheck     VARCHAR(20);
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_GetClientByContact');
  ELSE
    SET $cNameCheck = fn_GetNumberByString($ccName);
    IF($ccName REGEXP '^[0-9]')>0 THEN
      SET $cName = CAST($ccName AS UNSIGNED);
      --
      SELECT
        cl.clID         clID
        , REPLACE(cl.clName, ',', '.')     clName
        , cl.ParentID   ParentID
        , IF(cl.ParentID IS NOT NULL AND cl.ParentID !=0, (SELECT clName FROM crmClient WHERE clID = cl.ParentID AND Aid = $Aid), "")    ParentName
        , cl.ffID        ffID
        , (SELECT ffName FROM fsFile WHERE ffID = cl.ffID AND isActive = TRUE LIMIT 1)      ffName
        , cl.Comment        Comment
        , cl.Created    Created
      FROM crmClient cl
      WHERE cl.isActive = 1
        AND cl.isActual = 0
        AND cl.ffID IN (SELECT ffID FROM fsFile WHERE ffID = cl.ffID AND isActive = 1 AND Aid = $Aid)
        AND cl.Aid = $Aid
        AND cl.clID IN (SELECT clID FROM crmContact WHERE clID = cl.clID AND ccName = $cName AND ccType = 36 AND Aid = $Aid AND isActive = TRUE);
    ELSE
      SELECT
        cl.clID         clID
        , REPLACE(cl.clName, ',', '.')     clName
        , cl.ParentID   ParentID
        , IF(cl.ParentID IS NOT NULL AND cl.ParentID !=0, (SELECT clName FROM crmClient WHERE clID = cl.ParentID AND Aid = $Aid), "")    ParentName
        , cl.ffID        ffID
        , (SELECT ffName FROM fsFile WHERE ffID = cl.ffID AND isActive = TRUE LIMIT 1)      ffName
        , cl.Comment        Comment
        , cl.Created    Created
      FROM crmClient cl
      WHERE cl.isActive = 1
        AND cl.isActual = 0
        AND cl.ffID IN (SELECT ffID FROM fsFile WHERE ffID = cl.ffID AND isActive = 1 AND Aid = $Aid)
        AND cl.Aid = $Aid
        AND cl.clID IN (SELECT clID FROM crmContact WHERE clID = cl.clID AND ccName = $ccName AND ccType != 36 AND Aid = $Aid AND isActive = TRUE);
    END IF;
  END IF;
END $$
DELIMITER ;
--
