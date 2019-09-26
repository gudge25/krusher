DELIMITER $$
DROP PROCEDURE IF EXISTS reg_InsValidation;
CREATE PROCEDURE reg_InsValidation(
    $token            VARCHAR(100)
    , $vID            INT
    , $prefix         BIGINT
    , $prefixBegin    BIGINT
    , $prefixEnd      BIGINT
    , $MCC            INT
    , $MNC            INT
    , $cID            INT
    , $rgID           INT
    , $arID           INT
    , $lID            INT
    , $oID            INT
    , $gmt            INT
    , $isActive       bit
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'reg_InsValidation');
  ELSE
    if (($vID is NULL) OR ($prefix is NULL) OR ($prefixBegin is NULL) OR ($prefixEnd is NULL) OR ($MCC is NULL) OR ($MNC is NULL) OR ($cID is NULL))then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    end if;
    --
    insert INTO reg_validation (
      id_validation
      , Aid
      , prefix
      , prefixBegin
      , prefixEnd
      , gmt
      , MCC
      , MNC
      , id_country
      , id_region
      , id_area
      , id_city
      , id_mobileProvider
      , isActive
      , HIID
    )
    values (
      $vID
      , $Aid
      , $prefix
      , $prefixBegin
      , $prefixEnd
      , $gmt
      , $MCC
      , $MNC
      , $cID
      , $rgID
      , $arID
      , $lID
      , $oID
      , $isActive
      , fn_GetStamp()
    );
  END IF;
END $$
DELIMITER ;
--
