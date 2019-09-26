DELIMITER $$
DROP PROCEDURE IF EXISTS fs_InsBase;
CREATE PROCEDURE fs_InsBase (
    $token            VARCHAR(100)
    , $dbID           int
    , $dbName         varchar(50)
    , $dbPrefix       varchar(10)
    , $activeTo       time
    , $isActive       bit
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fs_InsBase');
  ELSE
    set $dbName = NULLIF(TRIM($dbName),'');
    --
    if ($dbID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    end if;
    if ($dbName is NULL) then
      -- Параметр "Название" должен иметь значение
      call RAISE(77022, NULL);
    end if;
    --
    insert fsBase (
       dbID
      ,dbName
      ,dbPrefix
      ,isActive
      ,activeTo
      ,Aid
      , HIID
    )
    values (
       $dbID
      ,$dbName
      ,$dbPrefix
      ,IFNULL($isActive,0)
      ,$activeTo
      ,$Aid
       , fn_GetStamp()
    );
  END IF;
END $$
DELIMITER ;
--
