DELIMITER $$
DROP PROCEDURE IF EXISTS reg_UpdValidation;
CREATE PROCEDURE reg_UpdValidation(
    $HIID             BIGINT
    , $token          VARCHAR(100)
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
    call RAISE(77068, 'reg_UpdValidation');
  ELSE
    if (($vID is NULL) OR ($prefix is NULL) OR ($prefixBegin is NULL) OR ($prefixEnd is NULL) OR ($MCC is NULL) OR ($MNC is NULL) OR ($cID is NULL))then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    end if;
    --
     if not exists (
      select 1
      from reg_validation
      where HIID = $HIID
        and id_validation = $vID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    update reg_validation set
      prefix                = $prefix
      , prefixBegin         = $prefixBegin
      , prefixEnd           = $prefixEnd
      , gmt                 = $gmt
      , MCC                 = $MCC
      , MNC                 = $MNC
      , id_country          = $cID
      , id_region           = $rgID
      , id_area             = $arID
      , id_city             = $lID
      , id_mobileProvider   = $oID
      , isActive            = $isActive
    where id_validation = $vID AND Aid = $Aid;
  END IF;
END $$
DElIMITER ;
--
