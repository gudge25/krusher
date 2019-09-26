DELIMITER $$
DROP PROCEDURE IF EXISTS reg_InsOperator;
CREATE PROCEDURE reg_InsOperator(
    $token            VARCHAR(100)
    , $oID            INT(11)
    , $oName          VARCHAR(250)
    , $MCC            INT(11)
    , $MNC            INT(11)
    , $isActive       bit
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'reg_InsOperator');
  ELSE
    set $oName = NULLIF(TRIM($oName), '');
    --
    if (($oID is NULL) OR ($MCC is NULL) OR ($MNC is NULL)) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    end if;
    if ($oName is NULL) then
      -- Параметр "Название" должен иметь значение
      call RAISE(77022, NULL);
    end if;
    --
    insert INTO reg_operator (
      id_operator
      , Aid
      , MCC
      , MNC
      , title
      , priority
      , mnp_status
      , isActive
      , HIID
    )
    values (
      $oID
      , $Aid
      , $MCC
      , $MNC
      , $oName
      , 100
      , 0
      , $isActive
      , fn_GetStamp()
    );
  END IF;
END $$
DELIMITER ;
--
