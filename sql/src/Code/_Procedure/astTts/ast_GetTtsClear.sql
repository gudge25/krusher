DELIMITER $$
DROP PROCEDURE IF EXISTS ast_GetTtsClear;
CREATE PROCEDURE ast_GetTtsClear(
    $Aid                  INT(11)
    , $ttsID              VARCHAR(250)
    , $ttsName            VARCHAR(50)
    , $engID              INT(11)
    , $isActive           BIT
    , $sorting            VARCHAR(5)
    , $field              VARCHAR(50)
    , $offset             INT(11)
    , $limit              INT(11)
)
BEGIN
  DECLARE $sqlWhereCode   VARCHAR(100);
  DECLARE $sqlWhere       VARCHAR(5000);
  DECLARE $sqlCount       VARCHAR(500);  
  DECLARE $sql            VARCHAR(5000);
  DECLARE $sorting_       VARCHAR(5);
  DECLARE $field_         VARCHAR(50);
  --
  SET $offset = IFNULL($offset, 0);
  SET $limit  = IFNULL($limit, 100);
  SET $limit = if($limit > 10000, 10000, $limit);
  SET $sqlWhereCode = 'WHERE ';
  SET $sqlWhere = '';
  --
  IF($sorting IS NULL) THEN
    SET $sorting_ = 'DESC';
  ELSE
    SET $sorting_ = $sorting;
  END IF;
  IF($field IS NULL) THEN
    SET $field_ = 'Created';
  ELSE
    SET $field_ = $field;
  END IF;
  --
  SET $sqlCount = 'SELECT count(*) Qty FROM ast_tts';
  --
  SET $sql = '
          SELECT
            t.HIID
            , t.ttsID
            , t.ttsName
            , t.ttsText
            , t.ttsFields
            , t.engID
            , IF(t.engID IS NOT NULL, (SELECT `Name` FROM usEnumValue WHERE tvID = t.engID LIMIT 1), NULL) engName
            , t.recIDBefore
            , t.recIDAfter
            , t.yandexApikey
            , t.yandexEmotion
            , t.yandexEmotions
            , t.yandexFast
            , t.yandexGenders
            , t.yandexLang
            , t.yandexSpeaker
            , t.yandexSpeakers
            , t.yandexSpeed
            , t.isActive
            , t.Created
            , t.Changed
            , t.settings
          FROM ast_tts t';
  --
  IF $ttsID is NOT NULL AND LENGTH(TRIM($ttsID))>0 THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  't.ttsID IN (', $ttsID, ')');
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $engID is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  't.engID = ', $engID);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $ttsName is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  't.ttsName = ', QUOTE($ttsName));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $IsActive is NOT NULL THEN
    IF $IsActive = TRUE THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 't.IsActive = 1');
    ELSE
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 't.IsActive = 0');
    END IF;
    SET $sqlWhereCode = ' AND ';
  END IF;
  --
  SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), $sqlWhereCode, 't.Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE) ORDER BY t.', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ',', $limit);
  /*SELECT @s;*/
  PREPARE stmt FROM @s;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
  --
  /*SET @s = CONCAT($sqlCount, CHAR(10), $sqlWhere);
  PREPARE stmt FROM @s;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;*/
END $$
DELIMITER ;
--
