DELIMITER $$
DROP PROCEDURE IF EXISTS st_InsBrand;
CREATE PROCEDURE st_InsBrand (
    $token          VARCHAR(100)
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
    call RAISE(77068, 'st_InsBrand');
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
    insert stBrand (
       HIID
      ,bID
      ,bName
      ,isActive
      ,CreatedBy
      , Aid
    )
    values (
       fn_GetStamp()
      ,$bID
      ,$bName
      ,IFNULL($isActive, 0)
      ,$emID
      , $Aid
    );
  END IF;
END $$
DELIMITER ;
--
