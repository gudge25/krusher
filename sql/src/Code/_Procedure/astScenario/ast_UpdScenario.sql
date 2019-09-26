DELIMITER $$
DROP PROCEDURE IF EXISTS ast_UpdScenario;
CREATE PROCEDURE ast_UpdScenario(
    $HIID                           BIGINT
    , $token                        VARCHAR(100)
    , $id_scenario                  INT(11)
    , $name_scenario                VARCHAR(255)
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
    , $IsRecallForSuccess           BIT
    , $IsCallToOtherClientNumbers   BIT
    , $IsCheckCallFromOther         BIT
    , $AllowPrefix                  TEXT
    , $destination                  INT(11)
    , $destdata                     INT(11)
    , $destdata2                    VARCHAR(100)
    , $target                       TEXT
    , $roID                         VARCHAR(250)
    , $isFirstClient                BIT
    , $limitChecker                 INT
    , $limitStatuses                VARCHAR(500)
    , $isActive                     BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_UpdScenario');
  ELSE
    if not exists (
      select 1
      from ast_scenario
      where HIID = $HIID
        and id_scenario = $id_scenario
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    UPDATE ast_scenario SET
        name_scenario                   = $name_scenario
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
        , IsRecallForSuccess            = $IsRecallForSuccess
        , IsCallToOtherClientNumbers    = $IsCallToOtherClientNumbers
        , IsCheckCallFromOther          = $IsCheckCallFromOther
        , AllowPrefix                   = $AllowPrefix
        , destination                   = $destination
        , destdata                      = $destdata
        , destdata2                     = $destdata2
        , target                        = $target
        , HIID                          = fn_GetStamp()
        , isFirstClient                 = $isFirstClient
        , roID                          = $roID
        , limitChecker                  = $limitChecker
        , limitStatuses                 = $limitStatuses
    WHERE id_scenario = $id_scenario AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
