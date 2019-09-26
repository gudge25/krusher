DELIMITER $$
DROP PROCEDURE IF EXISTS st_InsCategory;
CREATE PROCEDURE st_InsCategory (
    $token          VARCHAR(100)
    , $pctID        int
    , $pctName      varchar(50)
    , $ParentID     int
    , $isActive     bit
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'st_InsCategory');
  ELSE
    set $pctName = NULLIF(TRIM($pctName),'');
    --
    if ($pctID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    if ($pctName is NULL) then
      -- Параметр "Название" должен иметь значение
      call RAISE(77022,NULL);
    end if;
    --
    insert stCategory (
       pctID
      ,pctName
      ,ParentID
      , Aid
      , isActive
      , HIID
    )
    values (
       $pctID
      ,$pctName
      ,$ParentID
      , $Aid
      , $isActive
      , fn_GetStamp()
    );
  END IF;
END $$
DELIMITER ;
--
