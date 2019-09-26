DELIMITER $$
DROP PROCEDURE IF EXISTS crm_IPInsClientEx;
CREATE PROCEDURE crm_IPInsClientEx(
    $Aid            INT
    , $clID         INT
    , $emID         INT
    , $CallDate     DATETIME
    , $isNotice     BIT
    , $isRobocall   BIT
    , $isCallback   BIT
    , $isDial       BIT
    , $curID        INT
    , $langID       INT
    , $sum          DECIMAL(14,2)
    , $ttsText      LONGTEXT
    , $isActive     BIT
) DETERMINISTIC MODIFIES SQL DATA
COMMENT 'Добавляет расширеную шапку клиента'
BEGIN
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_IPInsClientEx');
  ELSE
    if $clID is NULL then
      -- Параметр "ID клинта" должен иметь значение;
      call RAISE(77004, NULL);
    end if;
    --
    INSERT INTO crmClientEx (
      clID
      , CallDate
      , ChangedBy
      , isNotice
      , isRobocall
      , isCallback
      , isDial
      , isActive
      , Aid
      , curID
      , langID
      , `sum`
      , ttsText
      , HIID
      , ffID
    )
    VALUES (
      $clID
      , $CallDate
      , $emID
      , $isNotice
      , $isRobocall
      , $isCallback
      , $isDial
      , $isActive
      , $Aid
      , $curID
      , $langID
      , $sum
      , $ttsText
      , fn_GetStamp()
      , (SELECT ffID FROM crmClient WHERE clID = $clID AND Aid = $Aid LIMIT 1)
    );
  END IF;
END $$
DELIMITER ;
--
