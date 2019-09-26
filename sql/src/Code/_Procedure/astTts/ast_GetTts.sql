DELIMITER $$
DROP PROCEDURE IF EXISTS ast_GetTts;
CREATE PROCEDURE ast_GetTts(
    $token                VARCHAR(100)
    , $ttsID              INT(11)
    , $ttsName            VARCHAR(50)
    , $engID              INT(11)
    , $ttsFields          VARCHAR(50)
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
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_GetTts');
  ELSE
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
              HIID
              , ttsID
              , ttsName
              , ttsText
              , ttsFields
              , engID
              , recIDBefore
              , recIDAfter
              , yandexApikey
              , yandexEmotion
              , yandexEmotions
              , yandexFast
              , yandexGenders
              , yandexLang
              , yandexSpeaker
              , yandexSpeakers
              , yandexSpeed
              , isActive
              , Created
              , Changed
              , settings
            FROM ast_tts ';
    --
    IF $ttsID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'ttsID = ', $ttsID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $engID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'engID = ', $engID);
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $ttsName is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'ttsName = ', QUOTE($ttsName));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $ttsFields is NOT NULL AND LENGTH(TRIM($ttsFields))>0 THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode,  'ttsFields = ', QUOTE($ttsFields));
      SET $sqlWhereCode = ' AND ';
    END IF;
    IF $IsActive is NOT NULL THEN
      IF $IsActive = TRUE THEN
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'IsActive = 1');
      ELSE
        SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'IsActive = 0');
      END IF;
      SET $sqlWhereCode = ' AND ';
    END IF;
    --
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'Aid = ', $Aid);
    --
    SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), 'ORDER BY ', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ',', $limit);
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    SET @s = CONCAT($sqlCount, CHAR(10), $sqlWhere);
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END IF;
END $$
DELIMITER ;
--
