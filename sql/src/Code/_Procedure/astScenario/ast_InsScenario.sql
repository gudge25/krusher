DELIMITER $$
DROP PROCEDURE IF EXISTS ast_InsScenario;
CREATE PROCEDURE ast_InsScenario(
    $token                          VARCHAR(100)
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
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_InsScenario');
  ELSE
    INSERT INTO ast_scenario (
      id_scenario
      , name_scenario
      , Aid
      , callerID
      , TimeBegin
      , TimeEnd
      , DaysCall
      , RecallCount
      , RecallAfterMin
      , RecallCountPerDay
      , RecallDaysCount
      , RecallAfterPeriod
      , AutoDial
      , IsRecallForSuccess
      , IsCallToOtherClientNumbers
      , IsCheckCallFromOther
      , AllowPrefix
      , destination
      , destdata
      , destdata2
      , target
      , isActive
      , HIID
      , isFirstClient
      , roID
      , limitChecker
      , limitStatuses
    )
    VALUES (
      $id_scenario
      , $name_scenario
      , $Aid
      , $callerID
      , $TimeBegin
      , $TimeEnd
      , $DaysCall
      , $RecallCount
      , $RecallAfterMin
      , $RecallCountPerDay
      , $RecallDaysCount
      , $RecallAfterPeriod
      , $AutoDial
      , $IsRecallForSuccess
      , $IsCallToOtherClientNumbers
      , $IsCheckCallFromOther
      , $AllowPrefix
      , $destination
      , $destdata
      , $destdata2
      , $target
      , $isActive
      , fn_GetStamp()
      , $isFirstClient
      , $roID
      , $limitChecker
      , $limitStatuses
    );
  END IF;
END $$
DELIMITER ;
--
