DELIMITER $$
DROP PROCEDURE IF EXISTS crm_UpdTag;
CREATE PROCEDURE crm_UpdTag(
    $token        VARCHAR(100)
    , $HIID         BIGINT
    , $tagID      INT
    , $tagName    VARCHAR(50)
    , $tagDesc    VARCHAR(200)
    , $isActive   BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_UpdTag');
  ELSE
    set $tagName = NULLIF(TRIM($tagName), '');
    --
    if ($tagID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    if ($tagName is NULL) then
      -- Параметр "Название" должен иметь значение
      call RAISE(77022,NULL);
    end if;
    --
    if not exists (
      select 1
      from crmTag
      where HIID = $HIID
        and tagID = $tagID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    update crmTag set
      tagName     = $tagName
      , tagDesc   = $tagDesc
      , isActive  = $isActive
      , HIID      = fn_GetStamp()
    where tagID = $tagID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
