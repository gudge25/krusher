DELIMITER $$
DROP PROCEDURE IF EXISTS em_InsEmployEx;
CREATE PROCEDURE em_InsEmployEx(
    $token          VARCHAR(100)
    , $emID         int
    , $Settings     varchar(8000)
    , $isActive     BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'em_InsEmployEx');
  ELSE
    if $emID is NULL then
      -- Параметр "ID сотрудника" должен иметь значение
      call RAISE(77007,NULL);
    end if;
    set $Settings = NULLIF(TRIM($Settings), '');
    --
    insert emEmployEx (
       emID
      ,Settings
      , isActive
      , Aid
      , HIID
    )
    values (
       $emID
      ,$Settings
      , $isActive
      , $Aid
      , fn_GetStamp()
    );
  END IF;
END $$
DELIMITER ;
--
