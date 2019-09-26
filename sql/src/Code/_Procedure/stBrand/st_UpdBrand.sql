DELIMITER $$
DROP PROCEDURE IF EXISTS st_UpdBrand;
CREATE PROCEDURE st_UpdBrand (
    $token          VARCHAR(100)
    , $HIID         bigint
    , $bID          int
    , $bName        varchar(50)
    , $isActive     bit
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  declare $emID int;
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'st_UpdBrand');
  ELSE
    SET $emID = fn_GetEmployID($token);
    set $bName = NULLIF(TRIM($bName),'');
    --
    if ($bID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    if ($bName is NULL) then
      -- Параметр "Название" должен иметь значение
      call RAISE(77022,NULL);
    end if;
    --
    if not exists (
      select 1
      from stBrand
      where HIID = $HIID
        and bID = $bID AND Aid = $Aid) then
      -- Запись была изменена или удалена другим пользователем. Обновите данные без сохраненис и выполните действис еще раз
      call RAISE(77003,NULL);
    end if;
    --
    update stBrand set
       HIID       = fn_GetStamp()
      ,bName      = $bName
      ,isActive   = IFNULL($isActive,0)
      ,ChangedBy   = $emID
      , isActive  = $isActive
    where bID = $bID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
