DELIMITER $$
DROP PROCEDURE IF EXISTS ast_UpdPools;
CREATE PROCEDURE ast_UpdPools(
    $token                          VARCHAR(100)
    , $HIID                         BIGINT
    , $poolID                       INT(11)
    , $poolName                     VARCHAR(50)
    , $priority                     INT(11)
    , $coID                         INT(11)
    , $isActive                     BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_UpdPools');
  ELSE
    if not exists (
      select 1
      from ast_pools
      where HIID = $HIID
        and poolID = $poolID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    UPDATE ast_pools SET
      poolName                        = $poolName
      , priority                      = $priority
      , isActive                      = $isActive
      , coID                          = $coID
      , HIID                          = fn_GetStamp()
    WHERE poolID = $poolID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
