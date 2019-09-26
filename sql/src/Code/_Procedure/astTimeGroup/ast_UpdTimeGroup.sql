DELIMITER $$
DROP PROCEDURE IF EXISTS ast_UpdTimeGroup;
CREATE PROCEDURE ast_UpdTimeGroup(
    $token                          VARCHAR(100)
    , $HIID                         BIGINT
    , $tgID                         INT(11)
    , $tgName                       VARCHAR(255)
    , $destination                  INT(11)
    , $destdata                     INT(11)
    , $destdata2                    VARCHAR(100)
    , $invalid_destination          INT(11)
    , $invalid_destdata             INT(11)
    , $invalid_destdata2            VARCHAR(100)
    , $isActive                     BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_UpdTimeGroup');
  ELSE
    if not exists (
      select 1
      from ast_time_group
      where HIID = $HIID
        and tgID = $tgID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    UPDATE ast_time_group SET
        tgName                = $tgName
        , isActive            = $isActive
        , HIID                = fn_GetStamp()
        , destination         = $destination
        , destdata            = $destdata
        , destdata2           = $destdata2
        , invalid_destination = $invalid_destination
        , invalid_destdata    = $invalid_destdata
        , invalid_destdata2   = $invalid_destdata2
    WHERE tgID = $tgID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
