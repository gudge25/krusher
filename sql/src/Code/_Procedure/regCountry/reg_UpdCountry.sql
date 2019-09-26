DELIMITER $$
DROP PROCEDURE IF EXISTS reg_UpdCountry;
CREATE PROCEDURE reg_UpdCountry (
    $token            VARCHAR(100)
    , $HIID             BIGINT
    , $cID            INT(11)
    , $cName          VARCHAR(250)
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  declare $isCalc bool;
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'reg_UpdCountry');
  ELSE
    set $cName = NULLIF(TRIM($cName),'');
    --
    if ($cID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    end if;
    if ($cName is NULL) then
      -- Параметр "Название" должен иметь значение
      call RAISE(77022, NULL);
    end if;
    --
    if not exists (
      select 1
      from reg_countries
      where HIID = $HIID
        and country_id = $cID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    update reg_countries set
       title_ru     = $cName
       , HIID        = fn_GetStamp()
    where country_id = $cID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
