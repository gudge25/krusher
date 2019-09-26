DELIMITER $$
DROP PROCEDURE IF EXISTS us_UpdEnum;
CREATE PROCEDURE us_UpdEnum(
    $HIID             BIGINT
    , $token            VARCHAR(100)
    , $tvID             INT(11)
    , $tyID             INT(11)
    , $Name             VARCHAR(100)
    , $isActive         BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'us_UpdEnum');
  ELSE
   if not exists (
      select 1
      from usEnumValue
      where HIID = $HIID
        and tvID = $tvID
        and tyID = $tyID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    UPDATE usEnumValue SET
      tyID        = $tyID
      , Aid       = Aid
      , `Name`    = $Name
      , isActive  = $isActive
      , HIID      = fn_GetStamp()
    WHERE tvID = $tvID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
