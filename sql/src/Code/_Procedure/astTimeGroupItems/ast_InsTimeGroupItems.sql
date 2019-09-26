DELIMITER $$
DROP PROCEDURE IF EXISTS ast_InsTimeGroupItems;
CREATE PROCEDURE ast_InsTimeGroupItems(
    $token                          VARCHAR(100)
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
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_InsTimeGroupItems');
  ELSE
    INSERT INTO ast_time_group_items (
      HIID
      , tgiID
      , tgID
      , Aid
      , TimeStart
      , TimeFinish
      , DayStart
      , DayFinish
      , DayNumStart
      , DayNumFinish
      , MonthStart
      , MonthFinish
      , isActive
    )
    VALUES (
      fn_GetStamp()
      , $tgiID
      , $tgID
      , $Aid
      , $TimeStart
      , $TimeFinish
      , $DayStart
      , $DayFinish
      , $DayNumStart
      , $DayNumFinish
      , $MonthStart
      , $MonthFinish
      , $isActive
    );
  END IF;
END $$
DELIMITER ;
--
