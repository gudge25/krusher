DELIMITER $$
DROP PROCEDURE IF EXISTS ast_UpdRouteIncoming;
CREATE PROCEDURE ast_UpdRouteIncoming(
    $token                VARCHAR(100)
    , $HIID               BIGINT
    , $rtID               INT(11)
    , $trID               INT(11)
    , $DID                VARCHAR(50)
    , $callerID           VARCHAR(50)
    , $exten              VARCHAR(500)
    , $context            VARCHAR(100)
    , $destination        INT(11)
    , $destdata           INT(11)
    , $destdata2          VARCHAR(100)
    , $stick_destination  INT(11)
    , $isCallback         BIT
    , $isFirstClient      BIT
    , $isActive           BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_UpdRouteIncoming');
  ELSE
    --
    if not exists (
      select 1
      from ast_route_incoming
      where HIID = $HIID
        and rtID = $rtID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    UPDATE ast_route_incoming SET
      trID                  = $trID
      , DID                 = $DID
      , callerID            = $callerID
      , exten               = $exten
      , isActive            = $isActive
      , `context`           = $context
      , destination         = $destination
      , destdata            = $destdata
      , destdata2           = $destdata2
      , HIID                = fn_GetStamp()
      , isCallback          = IF($isCallback = TRUE, 1, 0)
      , isFirstClient       = IF($isFirstClient = TRUE, 1, 0)
      , stick_destination   = $stick_destination
    WHERE rtID = $rtID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
