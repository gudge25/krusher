DELIMITER $$
DROP PROCEDURE IF EXISTS reg_InsCountry;
CREATE PROCEDURE reg_InsCountry (
   $token            VARCHAR(100)
    , $cID            INT(11)
    , $cName          VARCHAR(250)
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'reg_InsCountry');
  ELSE
    set $cName = NULLIF(TRIM($cName),'');
    --
    if ($cID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    if ($cName is NULL) then
      -- Параметр "Название" должен иметь значение
      call RAISE(77022,NULL);
    end if;
    --
    insert INTO reg_countries (
      country_id
      , title_ru
      , Aid
      , HIID
    )
    values (
      $cID
      , $cName
      , $Aid
      , fn_GetStamp()
    );
  END IF;
END $$
DELIMITER ;
--
