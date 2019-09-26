DELIMITER $$
DROP PROCEDURE IF EXISTS reg_UpdOperator;
CREATE PROCEDURE reg_UpdOperator(
    $HIID             BIGINT
    , $token            VARCHAR(100)
    , $oID            INT(11)
    , $oName          VARCHAR(250)
    , $MCC            INT(11)
    , $MNC            INT(11)
    , $isActive       bit
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'reg_UpdOperator');
  ELSE
    set $oName = NULLIF(TRIM($oName),'');
    --
    if (($oID is NULL) OR ($MCC is NULL) OR ($MNC is NULL))  then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    end if;
    if ($oName is NULL) then
      -- Параметр "Название" должен иметь значение
      call RAISE(77022, NULL);
    end if;
    --
     if not exists (
      select 1
      from reg_operator
      where HIID = $HIID
        and id_operator = $oID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    update reg_operator set
       MCC        = $MCC
       , MNC      = $MNC
       , title    = $oName
       , isActive = $isActive
       , HIID        = fn_GetStamp()
    where id_operator = $oID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
