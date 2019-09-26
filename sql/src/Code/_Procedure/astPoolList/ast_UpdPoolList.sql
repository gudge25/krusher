DELIMITER $$
DROP PROCEDURE IF EXISTS ast_UpdPoolList;
CREATE PROCEDURE ast_UpdPoolList(
    $token                          VARCHAR(100)
    , $HIID                         BIGINT
    , $plID                         INT(11)
    , $poolID                       INT(11)
    , $trID                         INT(11)
    , $percent                      INT(11)
    , $isActive                     BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_UpdPoolList');
  ELSE
    if not exists (
      select 1
      from ast_pool_list
      where HIID = $HIID
        and plID = $plID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    UPDATE ast_pool_list SET
      poolID        = $poolID
      , trID        = $trID
      , isActive    = $isActive
      , percent     = $percent
      , HIID        = fn_GetStamp()
    WHERE plID = $plID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
