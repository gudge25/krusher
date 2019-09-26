DROP PROCEDURE IF EXISTS dc_UpdType;
DELIMITER $$
CREATE PROCEDURE dc_UpdType(
    $token              VARCHAR(100)
    , $HIID             BIGINT
    , $dctID            int
    , $dctName          varchar(100)
    , $isActive         bit
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'dc_UpdType');
  ELSE
    if not exists (
      select 1
      from dcType
      where HIID = $HIID
        and dctID = $dctID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    update dcType set
      dctName       = $dctName
      , isActive    = $isActive
      , HIID        = fn_GetStamp()
    where dctID = $dctID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
