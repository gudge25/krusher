DELIMITER $$
DROP PROCEDURE IF EXISTS em_InsRole;
CREATE PROCEDURE em_InsRole (
    $token          VARCHAR(100)
    , $roleID       INT
    , $roleName     VARCHAR(50)
    , $Permission   INT
    , $isActive     BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'em_InsRole');
  ELSE
    SET $roleName = NULLIF(TRIM($roleName), '');
    --
    IF ($roleID is NULL) THEN
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    END IF;
    IF ($roleName is NULL) THEN
      -- Параметр "Название" должен иметь значение
      call RAISE(77022, NULL);
    END IF;
    IF($Permission is NULL) THEN
      -- Параметр "Права доступа" должен иметь значение
      call RAISE(77027, NULL);
    END IF;
    --
    INSERT INTO emRole (
      HIID
      , roleID
      , roleName
      , isActive
      , Permission
      , Aid
    )
    VALUES (
      fn_GetStamp()
      ,$roleID
      ,$roleName
      ,IFNULL($isActive, 0)
      ,$Permission
      , $Aid
    );
  END IF;
END $$
DELIMITER ;
--
