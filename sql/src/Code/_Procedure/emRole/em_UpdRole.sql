DELIMITER $$
DROP PROCEDURE IF EXISTS em_UpdRole;
CREATE PROCEDURE em_UpdRole (
    $token          VARCHAR(100)
    , $HIID         BIGINT
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
    call RAISE(77068, 'em_UpdRole');
  ELSE
    SET $roleName = NULLIF(TRIM($roleName), '');
    --
    IF ($roleID is NULL) THEN
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    END IF;
    IF ($roleName is NULL) THEN
      -- Параметр "Название" должен иметь значение
      call RAISE(77022, NULL);
    END IF;
    --
    IF NOT EXISTS (
      SELECT 1
      FROM emRole
      WHERE HIID = $HIID
        AND roleID = $roleID  AND Aid = $Aid) THEN
      -- Запись была изменена или удалена другим пользователем. Обновите данные без сохранения и выполните действия еще раз
      call RAISE(77003, NULL);
    END IF;
    --
    UPDATE emRole SET
        HIID          = fn_GetStamp()
        , roleName    = $roleName
        , isActive    = IFNULL($isActive, 0)
        , Permission  = $Permission
    WHERE roleID = $roleID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
