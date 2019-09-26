DELIMITER $$
DROP PROCEDURE IF EXISTS ast_InsConference;
CREATE PROCEDURE ast_InsConference(
    $token                          VARCHAR(100)
    , $cfID                         INT(11)
    , $cfName                       VARCHAR(250)
    , $cfDesc                       VARCHAR(250)
    , $userPin                      INT(11)
    , $adminPin                     INT(11)
    , $langID                       INT(11)
    , $record_id                    INT(11)
    , $leaderWait                   BIT
    , $leaderLeave                  BIT
    , $talkerOptimization           BIT
    , $talkerDetection              BIT
    , $quiteMode                    BIT
    , $userCount                    BIT
    , $userJoinLeave                BIT
    , $moh                          BIT
    , $mohClass                     INT(11)
    , $allowMenu                    BIT
    , $recordConference             BIT
    , $maxParticipants              INT(11)
    , $muteOnJoin                   BIT
    , $isActive                     BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_InsConference');
  ELSE
    INSERT INTO ast_conference (
      cfID
      , cfName
      , Aid
      , cfDesc
      , userPin
      , adminPin
      , langID
      , record_id
      , leaderWait
      , leaderLeave
      , talkerOptimization
      , talkerDetection
      , quiteMode
      , userCount
      , userJoinLeave
      , moh
      , mohClass
      , allowMenu
      , recordConference
      , maxParticipants
      , muteOnJoin
      , isActive
      , HIID
    )
    VALUES (
      $cfID
      , $cfName
      , $Aid
      , $cfDesc
      , $userPin
      , $adminPin
      , $langID
      , $record_id
      , $leaderWait
      , $leaderLeave
      , $talkerOptimization
      , $talkerDetection
      , $quiteMode
      , $userCount
      , $userJoinLeave
      , $moh
      , $mohClass
      , $allowMenu
      , $recordConference
      , $maxParticipants
      , $muteOnJoin
      , $isActive
      , fn_GetStamp()
    );
  END IF;
END $$
DELIMITER ;
--
