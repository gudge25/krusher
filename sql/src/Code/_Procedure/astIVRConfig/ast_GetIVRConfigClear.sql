DELIMITER $$
DROP PROCEDURE IF EXISTS ast_GetIVRConfigClear;
CREATE PROCEDURE ast_GetIVRConfigClear(
    $Aid                          INT(11)
    , $id_ivr_config              INT(11)
    , $ivr_name                   VARCHAR(255)
    , $ivr_description            VARCHAR(1000)
    , $record_id                  VARCHAR(250)
    , $enable_direct_dial         BIT
    , $timeout                    INT(11)
    , $alert_info                 VARCHAR(50)
    , $volume                     INT(11)
    , $invalid_retries            INT(11)
    , $retry_record_id            VARCHAR(250)
    , $append_record_to_invalid   BIT
    , $return_on_invalid          BIT
    , $invalid_record_id          VARCHAR(250)
    , $invalid_destination        INT(11)
    , $invalid_destdata           INT(11)
    , $invalid_destdata2          VARCHAR(100)
    , $timeout_retries            INT(11)
    , $timeout_retry_record_id    VARCHAR(250)
    , $append_record_on_timeout   BIT
    , $return_on_timeout          BIT
    , $timeout_record_id          VARCHAR(250)
    , $timeout_destination        INT(11)
    , $timeout_destdata           INT(11)
    , $timeout_destdata2          VARCHAR(100)
    , $return_to_ivr_after_vm     BIT
    , $ttsID                      VARCHAR(250)
    , $isActive                   BIT
    , $sorting                    VARCHAR(5)
    , $field                      VARCHAR(50)
    , $offset                     INT(11)
    , $limit                      INT(11)
)
BEGIN
  DECLARE $sqlWhereCode   VARCHAR(100);
  DECLARE $sqlWhere       VARCHAR(5000);
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
    SET $field_ = '`Created`';
  ELSE
    SET $field_ = $field;
  END IF;
  --
  SET $sql = '
          SELECT
            id_ivr_config
            , Aid
            , ivr_name
            , ivr_description
            , record_id
            , enable_direct_dial
            , timeout
            , alert_info
            , volume
            , invalid_retries
            , retry_record_id
            , append_record_to_invalid
            , return_on_invalid
            , invalid_record_id
            , invalid_destination
            , invalid_destdata
            , invalid_destdata2
            , timeout_retries
            , timeout_retry_record_id
            , append_record_on_timeout
            , return_on_timeout
            , timeout_record_id
            , timeout_destination
            , timeout_destdata
            , timeout_destdata2
            , return_to_ivr_after_vm
            , ttsID
            , isActive
          FROM ast_ivr_config ';
  --
  IF $id_ivr_config is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'id_ivr_config = ', $id_ivr_config);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $ivr_name is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'ivr_name = ', QUOTE($ivr_name));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $ivr_description is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'ivr_description = ', QUOTE($ivr_description));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $record_id is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'record_id = ', $record_id);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $enable_direct_dial is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'enable_direct_dial = ', QUOTE($enable_direct_dial));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $timeout is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'timeout = ', $timeout);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $alert_info is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'alert_info = ', QUOTE($alert_info));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $volume is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'volume = ', $volume);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $invalid_retries is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'invalid_retries = ', $invalid_retries);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $retry_record_id is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'retry_record_id = ', $retry_record_id);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $append_record_to_invalid is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'append_record_to_invalid = ', QUOTE($append_record_to_invalid));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $return_on_invalid is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'return_on_invalid = ', QUOTE($return_on_invalid));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $invalid_record_id is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'invalid_record_id = ', $invalid_record_id);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $invalid_destination is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'invalid_destination = ', $invalid_destination);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $invalid_destdata is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'invalid_destdata = ', $invalid_destdata);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $invalid_destdata2 is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'invalid_destdata2 = ', QUOTE($invalid_destdata2));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $timeout_retries is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'timeout_retries = ', $timeout_retries);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $timeout_retry_record_id is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'timeout_retry_record_id = ', $timeout_retry_record_id);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $append_record_on_timeout is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'append_record_on_timeout = ', QUOTE($append_record_on_timeout));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $return_on_timeout is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'return_on_timeout = ', QUOTE($return_on_timeout));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $timeout_record_id is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'timeout_record_id = ', $timeout_record_id);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $timeout_destination is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'timeout_destination = ', $timeout_destination);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $timeout_destdata is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'timeout_destdata = ', $timeout_destdata);
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $timeout_destdata2 is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'timeout_destdata2 = ', QUOTE($timeout_destdata2));
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $ttsID is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'ttsID IN (', $ttsID, ')');
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $isActive is NOT NULL THEN
    IF ($isActive = TRUE) THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isActive = 1');
    ELSE
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'isActive = 0');
    END IF;
    SET $sqlWhereCode = ' AND ';
  END IF;
  IF $return_to_ivr_after_vm is NOT NULL THEN
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), $sqlWhereCode, 'return_to_ivr_after_vm = ', QUOTE($return_to_ivr_after_vm));
    SET $sqlWhereCode = ' AND ';
  END IF;
  --
  SET @s = CONCAT($sql, CHAR(10), $sqlWhere, CHAR(10), $sqlWhereCode, 'Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE) ORDER BY ', $field_, ' ', $sorting_, CHAR(10), 'LIMIT ', $offset, ', ', $limit);
  PREPARE stmt FROM @s;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
  --
END $$
DELIMITER ;
--
