DELIMITER $$
DROP PROCEDURE IF EXISTS ast_InsRecall;
CREATE PROCEDURE ast_InsRecall(
    $token                          VARCHAR(100)
    , $rcID                         INT(11)
    , $rcName                       VARCHAR(255)
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
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_InsRecall');
  ELSE
    INSERT INTO ast_recall (
      rcID
      , rcName
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
      , isResponsible
      , roID
      , statusMessage
      , type
    )
    VALUES (
      $rcID
      , $rcName
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
      , $isResponsible
      , $roID
      , $statusMessage
      , $type
    );
  END IF;
END $$
DELIMITER ;
--
