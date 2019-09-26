DROP PROCEDURE IF EXISTS fs_GetFileDetail;
DELIMITER $$
CREATE PROCEDURE fs_GetFileDetail(
    $token            VARCHAR(100)
    , $ffID           int
    , $langID         INT
    , $isActive       bit
)
BEGIN
  DECLARE $Aid            INT;
  DECLARE $sql            VARCHAR(5000);
  DECLARE $language       VARCHAR(2);
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fs_GetFileDetail');
  ELSE
    IF ($ffID IS NULL) THEN
      call RAISE(77021, NULL);
    END IF;
    --
    SET $language = fn_GetLanguage($Aid, $langID);
    --
    SET $sql = CONCAT('SELECT
        cc.id_country                                       cID
        , IF(cc.id_country IS NOT NULL, (SELECT title_', $language, ' FROM reg_countries WHERE country_id = cc.id_country), NULL)  cName
		    , cc.id_region                                      rgID
		    , IF(cc.id_region IS NOT NULL, (SELECT title_', $language, ' FROM reg_regions WHERE country_id = cc.id_country AND region_id=cc.id_region), NULL)  rgName
        , count(*)                                          `Count`
        , IF(cc.id_mobileProvider IS NOT NULL, true, false) isMobile
    FROM crmClient cl
    INNER JOIN crmContact cc ON cl.clID = cc.clID
    WHERE cl.ffID = ', $ffID, ' AND cc.id_country IS NOT NULL
      AND cl.Aid = ', $Aid);
    IF($isActive IS NOT NULL) THEN
      IF($isActive = TRUE) THEN
        SET $sql = CONCAT($sql, ' AND cl.isActive = 1');
      ELSE
        SET $sql = CONCAT($sql, ' AND cl.isActive = 0');
      END IF;
    END IF;
    SET $sql = CONCAT($sql, ' GROUP BY cc.id_country, cc.id_region ORDER BY cName;');
    SET @s = $sql;
    /*SELECT @s;*/
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET $sql = CONCAT('SELECT
        cc.id_country                                       cID
        , IF(cc.id_country IS NOT NULL, (SELECT title_', $language, ' FROM reg_countries WHERE country_id = cc.id_country), NULL)  cName
		    , cc.id_region                                      rgID
		    , IF(cc.id_region IS NOT NULL, (SELECT title_', $language, ' FROM reg_regions WHERE country_id = cc.id_country AND region_id=cc.id_region), NULL)  rgName
        , count(*)                                          `Count`
        , IF(cc.id_mobileProvider IS NOT NULL, true, false) isMobile
    FROM crmClient cl
    INNER JOIN crmContact cc ON cl.clID = cc.clID
    WHERE cl.ffID = ', $ffID, '	AND cc.id_country IS NOT NULL
      AND cl.Aid = ', $Aid);
    IF($isActive IS NOT NULL) THEN
      IF($isActive = TRUE) THEN
        SET $sql = CONCAT($sql, ' AND cl.isActive = 1');
      ELSE
        SET $sql = CONCAT($sql, ' AND cl.isActive = 0');
      END IF;
    END IF;
    SET $sql = CONCAT($sql, ' AND cc.id_mobileProvider IS NOT NULL GROUP BY cc.id_country, cc.id_region ORDER BY cName;');
    SET @s = $sql;
    /*SELECT @s;*/
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
	  --
  END IF;
END $$
DELIMITER ;
--
