DELIMITER $$
DROP PROCEDURE IF EXISTS crm_InsClientEx;
CREATE PROCEDURE crm_InsClientEx(
    $token          VARCHAR(100)
    , $clID         INT
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
  DECLARE $Aid            INT;
  DECLARE $emID           INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  SET $emID = fn_GetEmployID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_InsClientEx');
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
      , isCallDate
    )
    VALUES (
     $clID
	  , IF($CallDate IS NULL, NULL, $CallDate)
      , IF($emID IS NULL, NULL, $emID)
      , IF($isNotice IS NULL, 0, $isNotice)
      , IF($isRobocall IS NULL, 0, $isRobocall)
      , IF($isCallback IS NULL, 0, $isCallback)
      , IF($isDial IS NULL, 0, $isDial)
      , IF($isActive IS NULL, 1, $isActive)
      , IF($Aid IS NULL, NULL, $Aid)
      , IF($curID IS NULL, NULL, $curID)
      , IF($langID IS NULL, NULL, $langID)
      , IF($sum IS NULL, NULL, $sum)
      , IF($ttsText IS NULL, NULL, $ttsText)
      , fn_GetStamp()
      , (SELECT ffID FROM crmClient WHERE clID = $clID  AND Aid = $Aid LIMIT 1)
      , IF($CallDate IS NOT NULL AND LENGTH($CallDate)>0, TRUE, FALSE)
    );
  END IF;
END $$
DELIMITER ;
--
