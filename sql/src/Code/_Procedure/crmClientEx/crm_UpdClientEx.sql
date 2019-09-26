DELIMITER $$
DROP PROCEDURE IF EXISTS crm_UpdClientEx;
CREATE PROCEDURE crm_UpdClientEx(
    $token          VARCHAR(100)
    , $HIID         BIGINT
    , $clID         INT
    , $CallDate     DATETIME
    , $isNotice     BIT
    , $isRobocall   BIT
    , $isCallback   BIT
    , $isDial       BIT
    , $curID        INT
    , $langID       INT
    , $sum          DECIMAL(14,2)
    , $ttsText      LONGTEXT
    , $isActive     BIT
) DETERMINISTIC MODIFIES SQL DATA
COMMENT 'Обновляет расширеную шапку клиента'
BEGIN
  DECLARE $Aid              INT;
  DECLARE $emID             INT;
  DECLARE $CallDate2        DATETIME;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);

  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_UpdClientEx');
  ELSE
    if not exists (
      select 1
      from crmClientEx
      where HIID = $HIID
        and clID = $clID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    if $clID is NULL then
      -- Параметр "ID клинта" должен иметь значение;
      call RAISE(77004, NULL);
    end if;
    --
    SET $emID = fn_GetEmployID($token);
    --
    SELECT CallDate
        INTO $CallDate2
    FROM crmClientEx
    WHERE clID = $clID AND Aid = $Aid;
    --
    UPDATE crmClientEx SET
      CallDate      = $CallDate
      , ChangedBy   = $emID
      , isNotice    = $isNotice
      , isRobocall  = $isRobocall
      , isCallback  = $isCallback
      , isDial      = $isDial
      , isActive    = $isActive
      , curID       = $curID
      , langID      = $langID
      , `sum`       = $sum
      , ttsText     = $ttsText
      , HIID        = fn_GetStamp()
      , isCallDate  = IF(($CallDate2 != $CallDate AND $CallDate IS NOT NULL) OR ($CallDate2 IS NULL AND $CallDate IS NOT NULL), 1, 0)
    where clID = $clID AND Aid = $Aid;
  END IF;
END $$
DElIMITER ;
--
