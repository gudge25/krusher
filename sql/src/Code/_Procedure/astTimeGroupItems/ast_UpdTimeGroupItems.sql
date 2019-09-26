DELIMITER $$
DROP PROCEDURE IF EXISTS ast_UpdTimeGroupItems;
CREATE PROCEDURE ast_UpdTimeGroupItems(
    $token                          VARCHAR(100)
    , $HIID                         BIGINT
    , $tgiID                        INT(11)
    , $tgID                         INT(11)
    , $TimeStart                    TIME
    , $TimeFinish                   TIME
    , $DayNumStart                  INT(11)
    , $DayNumFinish                 INT(11)
    , $DayStart                     VARCHAR(10)
    , $DayFinish                    VARCHAR(10)
    , $MonthStart                   VARCHAR(10)
    , $MonthFinish                  VARCHAR(10)
    , $isActive                     BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_UpdTimeGroupItems');
  ELSE
    if not exists (
      select 1
      from ast_time_group_items
      where HIID = $HIID
        and tgiID = $tgiID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    UPDATE ast_time_group_items SET
        TimeStart         = $TimeStart
        , TimeFinish      = $TimeFinish
        , DayStart        = $DayStart
        , DayFinish       = $DayFinish
        , DayNumStart     = $DayNumStart
        , DayNumFinish    = $DayNumFinish
        , MonthStart      = $MonthStart
        , MonthFinish     = $MonthFinish
        , tgID            = tgID
        , isActive        = $isActive
        , HIID            = fn_GetStamp()
    WHERE tgiID = $tgiID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
