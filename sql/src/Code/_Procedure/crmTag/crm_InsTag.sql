DELIMITER $$
DROP PROCEDURE IF EXISTS crm_InsTag;
CREATE PROCEDURE crm_InsTag(
    $token        VARCHAR(100)
    , $tagID      INT
    , $tagName    VARCHAR(50)
    , $tagDesc    VARCHAR(200)
    , $isActive   BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_InsTag');
  ELSE
    set $tagName = NULLIF(TRIM($tagName),'');
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
    insert crmTag (
      tagID
      , tagName
      , tagDesc
      , isActive
      , Aid
      , HIID
    )
    values (
      $tagID
      , $tagName
      , $tagDesc
      , $isActive
      , $Aid
      , fn_GetStamp()
    );
  END IF;
END $$
DELIMITER ;
--
