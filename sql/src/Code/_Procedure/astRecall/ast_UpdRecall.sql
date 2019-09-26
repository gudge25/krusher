DELIMITER $$
DROP PROCEDURE IF EXISTS ast_UpdRecall;
CREATE PROCEDURE ast_UpdRecall(
    $HIID                           BIGINT
    , $token                        VARCHAR(100)
    , $rcID                         INT(11)
    , $rcNameo                      VARCHAR(255)
    , $callerID                     VARCHAR(50)
    , $TimeBegin                    TIME
    , $TimeEnd                      TIME
    , $DaysCall                     VARCHAR(500)
    , $RecallCount                  INT(11)
    , $RecallAfterMin               INT(11)
    , $RecallCountPerDay            INT(11)
    , $RecallDaysCount              INT(11)
    , $RecallAfterPeriod            INT(11)
    , $AutoDial                     VARCHAR(100)
    , $IsCallToOtherClientNumbers   BIT
    , $IsCheckCallFromOther         BIT
    , $AllowPrefix                  TEXT
    , $destination                  INT(11)
    , $destdata                     INT(11)
    , $destdata2                    VARCHAR(100)
    , $target                       TEXT
    , $roID                         VARCHAR(250)
    , $isFirstClient                BIT
    , $isResponsible                BIT
    , $statusMessage                TEXT
    , $type                         VARCHAR(250)
    , $isActive                     BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_UpdRecall');
  ELSE
    if not exists (
      select 1
      from ast_recall
      WHERE HIID = $HIID
        AND rcID = $rcID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    UPDATE ast_recall SET
        rcName                          = $rcNameo
        , TimeBegin                     = $TimeBegin
        , TimeEnd                       = $TimeEnd
        , callerID                      = $callerID
        , DaysCall                      = $DaysCall
        , isActive                      = $isActive
        , RecallCount                   = $RecallCount
        , RecallAfterPeriod             = $RecallAfterPeriod
        , AutoDial                      = $AutoDial
        , RecallAfterMin                = $RecallAfterMin
        , RecallCountPerDay             = $RecallCountPerDay
        , RecallDaysCount               = $RecallDaysCount
        , IsCallToOtherClientNumbers    = $IsCallToOtherClientNumbers
        , IsCheckCallFromOther          = $IsCheckCallFromOther
        , AllowPrefix                   = $AllowPrefix
        , destination                   = $destination
        , destdata                      = $destdata
        , destdata2                     = $destdata2
        , target                        = $target
        , HIID                          = fn_GetStamp()
        , isFirstClient                 = $isFirstClient
        , isResponsible                 = $isResponsible
        , roID                          = $roID
        , statusMessage                 = $statusMessage
        , type                          = $type
    WHERE rcID = $rcID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
