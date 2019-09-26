DROP PROCEDURE IF EXISTS us_InsMeasure;
DELIMITER $$
CREATE PROCEDURE us_InsMeasure (
    $token            VARCHAR(100)
    , $msID           int
    , $msName         varchar(200)
    , $isActive       BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'us_InsMeasure');
  ELSE
    if ($msID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    --
    set $msName = NULLIF(TRIM($msName),'');
    --
    if ($msName is NULL) then
      -- Параметр "Название" должен иметь значение
      call RAISE(77022,NULL);
    end if;
    --
    insert usMeasure (
       HIID
      ,msID
      ,msName
      , isActive
      , Aid
    )
    values (
       fn_GetStamp()
      ,$msID
      ,$msName
      , $isActive
      , $Aid
    );
  END IF;
END $$
DELIMITER ;
--
