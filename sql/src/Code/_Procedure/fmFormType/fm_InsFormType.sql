DROP PROCEDURE IF EXISTS fm_InsFormType;
DELIMITER $$
CREATE PROCEDURE fm_InsFormType(
    $token          VARCHAR(100)
    , $tpID         int
    , $tpName       varchar(50)
    , $ffID         int
    , $isActive     bit
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fm_InsFormType');
  ELSE
    if ($tpID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    --
    insert fmFormType (
       HIID
      ,tpID
      ,tpName
      ,isActive
      ,ffID
      , Aid
    )
    values (
       fn_GetStamp()
      ,$tpID
      ,$tpName
      ,IFNULL($isActive,0)
      ,$ffID
      , $Aid
    );
  END IF;
END $$
DELIMITER ;
--
