DELIMITER $$
DROP PROCEDURE IF EXISTS ast_UpdIVRConfig;
CREATE PROCEDURE ast_UpdIVRConfig(
    $HIID                         BIGINT
    , $token                      VARCHAR(100)
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
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid          INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_UpdIVRConfig');
  ELSE
     if not exists (
      select 1
      from ast_ivr_config
      where HIID = $HIID
        and id_ivr_config = $id_ivr_config
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действис еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    UPDATE ast_ivr_config SET
      ivr_name                    = $ivr_name
      , ivr_description           = $ivr_description
      , record_id                 = $record_id
      , enable_direct_dial        = $enable_direct_dial
      , timeout                   = $timeout
      , alert_info                = $alert_info
      , volume                    = $volume
      , invalid_retries           = $invalid_retries
      , retry_record_id           = $retry_record_id
      , append_record_to_invalid  = $append_record_to_invalid
      , return_on_invalid         = $return_on_invalid
      , invalid_record_id         = $invalid_record_id
      , invalid_destination       = $invalid_destination
      , invalid_destdata          = $invalid_destdata
      , invalid_destdata2         = $invalid_destdata2
      , timeout_retries           = $timeout_retries
      , timeout_retry_record_id   = $timeout_retry_record_id
      , append_record_on_timeout  = $append_record_on_timeout
      , return_on_timeout         = $return_on_timeout
      , timeout_record_id         = $timeout_record_id
      , timeout_destination       = $timeout_destination
      , timeout_destdata          = $timeout_destdata
      , timeout_destdata2         = $timeout_destdata2
      , return_to_ivr_after_vm    = $return_to_ivr_after_vm
      , isActive                  = $isActive
      , ttsID                     = IF($ttsID IS NULL OR LENGTH(TRIM($ttsID))=0, NULL, $ttsID)
      , HIID                      = fn_GetStamp()
    WHERE id_ivr_config = $id_ivr_config AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
