DROP PROCEDURE IF EXISTS crm_GetClientByPhone;
DELIMITER $$
CREATE PROCEDURE crm_GetClientByPhone(
    $token          VARCHAR(100)
    , $Aid          INT(11)
    , $ccName       VARCHAR(50)
)
BEGIN
  DECLARE $Aid2            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid2 = fn_GetAccountID($token);
  IF ($Aid2 = -999) THEN
    call RAISE(77068, 'crm_GetClientByPhone');
  ELSEIF($Aid2 = 0) THEN
      SELECT
        REPLACE(cl.clName, ',', '.')     clName
        /*cl.clID         clID
        , cl.clName     clName
        , cl.Created    Created*/
      FROM crmClient cl
      WHERE cl.isActive = 1
        AND cl.isActual = 0
        AND cl.ffID > 0
        AND cl.Aid = $Aid
        AND cl.clID IN (SELECT clID FROM crmContact WHERE ccName = $ccName AND ccType = 36 AND Aid = $Aid);

    /*SELECT
      cl.clID         clID
      , cl.clName     clName
      , cl.ParentID   ParentID
      , p.clName      ParentName
      , f.ffID        ffID
      , f.ffName      ffName
      , cl.Created    Created
    FROM crmClient cl
      LEFT OUTER JOIN crmClient p ON p.clID = cl.ParentID
      LEFT JOIN fsFile f ON cl.ffID = f.ffID
    WHERE cl.isActive = 1
      AND cl.isActual = 0
      AND f.ffID > 0
      AND cl.Aid = $Aid
      AND exists (
        SELECT 1
        FROM crmContact
        WHERE clID = cl.clID
          AND ccName = $ccName
          AND ccType = 36
          AND Aid = $Aid)
      AND exists (
        SELECT 1
        FROM fsFile
        WHERE ffID = cl.ffID
          AND isActive = 1
          AND Aid = $Aid);*/
  END IF;
END $$
DELIMITER ;
--
