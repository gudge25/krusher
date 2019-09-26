DELIMITER $$
DROP PROCEDURE IF EXISTS ast_UpdCallback;
CREATE PROCEDURE ast_UpdCallback(
    $token                          VARCHAR(100)
    , $HIID                         BIGINT
    , $cbID                         INT(11)
    , $cbName                       VARCHAR(50)
    , $timeout                      INT(11)
    , $isFirstClient                BIT
    , $destination                  INT(11)
    , $destdata                     INT(11)
    , $destdata2                    VARCHAR(100)
    , $isActive                     BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_UpdCallback');
  ELSE
    if not exists (
      select 1
      from ast_callback
      where HIID = $HIID
        and cbID = $cbID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    UPDATE ast_callback SET
      cbName                          = $cbName
      , timeout                       = $timeout
      , isFirstClient                 = $isFirstClient
      , destination                   = $destination
      , destdata                      = $destdata
      , destdata2                     = $destdata2
      , isActive                      = $isActive
      , HIID                          = fn_GetStamp()
    WHERE cbID = $cbID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
