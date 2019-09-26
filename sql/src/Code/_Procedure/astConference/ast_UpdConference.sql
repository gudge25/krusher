DELIMITER $$
DROP PROCEDURE IF EXISTS ast_UpdConference;
CREATE PROCEDURE ast_UpdConference(
    $HIID                           BIGINT
    , $token                        VARCHAR(100)
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
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_UpdConference');
  ELSE
    if not exists (
      select 1
      from ast_conference
      where HIID = $HIID
        and cfID = $cfID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    UPDATE ast_conference SET
        cfID                            = $cfID
        , cfName                     = $cfName
        , cfDesc                       = $cfDesc
        , userPin                      = $userPin
        , adminPin                      = $adminPin
        , isActive                      = $isActive
        , langID                   = $langID
        , record_id             = $record_id
        , leaderWait                      = $leaderWait
        , leaderLeave                = $leaderLeave
        , talkerOptimization             = $talkerOptimization
        , talkerDetection               = $talkerDetection
        , quiteMode            = $quiteMode
        , userCount    = $userCount
        , userJoinLeave          = $userJoinLeave
        , moh                   = $moh
        , mohClass                   = $mohClass
        , allowMenu                      = $allowMenu
        , recordConference                     = $recordConference
        , maxParticipants                        = $maxParticipants
        , HIID                          = fn_GetStamp()
        , muteOnJoin                 = $muteOnJoin
    WHERE cfID = $cfID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
