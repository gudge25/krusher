DELIMITER $$
DROP PROCEDURE IF EXISTS ast_UpdRouteOutgoingItems;
CREATE PROCEDURE ast_UpdRouteOutgoingItems(
    $HIID             BIGINT
    , $token          VARCHAR(100)
    , $roiID          INT(11)
    , $roID           INT(11)
    , $pattern        VARCHAR(50)
    , $callerID       VARCHAR(50)
    , $prepend        VARCHAR(50)
    , $prefix         VARCHAR(50)
    , $priority       INT(11)
    , $isActive       BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_InsRouteOutgoingItems');
  ELSE
    if not exists (
      select 1
      from ast_route_outgoing_items
      where HIID = $HIID
        and roiID = $roiID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    UPDATE ast_route_outgoing_items SET
      pattern               = $pattern
      , isActive            = $isActive
      , roID                = $roID
      , HIID                = fn_GetStamp()
      , callerID            = $callerID
      , priority            = $priority
      , prepend             = $prepend
      , prefix              = $prefix
    WHERE roiID = $roiID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
