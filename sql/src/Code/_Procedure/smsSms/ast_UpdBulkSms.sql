DROP PROCEDURE IF EXISTS ast_UpdBulkSms;
DELIMITER $$
CREATE PROCEDURE ast_UpdBulkSms(
    $token        VARCHAR(100)
    , $HIID           BIGINT
    , $bulkID       INT
    , $originator   VARCHAR(15)
    , $ffID         INT
    , $text_sms     TEXT
    , $timeBegin    DATETIME
    , $emID         INT
    , $status       INT
    , $isActive     BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid         INT;
  DECLARE $sql              VARCHAR(1000);
  DECLARE $sql1             VARCHAR(1000);
  DECLARE $sql2             VARCHAR(1000);
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid < 1) THEN
    call RAISE(77068, 'ast_UpdBulkSms');
  ELSE
    IF $text_sms IS NULL OR LENGTH(TRIM($text_sms)) = 0 THEN
        call RAISE(77076, 'text_sms');
    END IF;
    IF $ffID IS NULL OR LENGTH(TRIM($ffID)) = 0 THEN
        call RAISE(77076, 'ffID');
    END IF;
    if not exists (
            select 1
            from cc_SmsBulk
            WHERE HIID = $HIID
              AND bulkID = $bulkID
              AND Aid = $Aid) then
        -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
        call RAISE(77003, NULL);
    end if;
    --
    UPDATE cc_SmsBulk SET
        HIID = fn_GetStamp()
          , originator = $originator
          , ffID = $ffID
          , text_sms = $text_sms
          , timeBegin = $timeBegin
          , emID = emID
          , status = $status
          , isActive = $isActive
        WHERE bulkID = $bulkID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
