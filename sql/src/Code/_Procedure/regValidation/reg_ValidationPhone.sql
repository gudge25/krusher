DROP PROCEDURE IF EXISTS reg_ValidationPhone;
DELIMITER $$
CREATE PROCEDURE reg_ValidationPhone(
    $token        VARCHAR(100)
    , $ccName     VARCHAR(250)
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'reg_ValidationPhone');
  ELSE
    SET $ccName = TRIM($ccName);
    --
    if NULLIF($ccName, '') is NULL then
      -- 'Параметр "Контакт" должен иметь значение';
      call raise(77010, NULL);
    end if;
    --
    SELECT * FROM (SELECT reg_GetMCCInfo($Aid, $ccName)     MCC
                , reg_GetMNCInfo($Aid, $ccName)     MNC
                , reg_GetCountryInfo($Aid, $ccName) Country
                , reg_GetRegionInfo($Aid, $ccName)  Region
                , reg_GetAreaInfo($Aid, $ccName)    Area
                , reg_GetCityInfo($Aid, $ccName)    City
                , reg_GetOperatorInfo($Aid, $ccName)Operator
                , reg_GetGmtInfo($Aid, $ccName)      GMT
              ) m;
  END IF;
END $$
DELIMITER ;
--
