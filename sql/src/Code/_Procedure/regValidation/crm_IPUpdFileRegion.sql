DELIMITER $$
DROP PROCEDURE IF EXISTS crm_IPUpdFileRegion;
CREATE PROCEDURE crm_IPUpdFileRegion(
    $ffID INT
) DETERMINISTIC MODIFIES SQL DATA
COMMENT 'Обновляет регион клиента'
BEGIN
  UPDATE crmContact cc SET cc.gmt = if(cc.ccType = 36, reg_GetGmtInfo(0, cc.ccName), NULL),
								 cc.MCC = if(cc.ccType = 36, reg_GetMCCInfo(0, cc.ccName), NULL),
								 cc.MNC = if(cc.ccType = 36, reg_GetMNCInfo(0, cc.ccName), NULL),
								 cc.id_country = if(cc.ccType = 36, reg_GetCountryInfo(0, cc.ccName), NULL),
								 cc.id_region = if(cc.ccType = 36, reg_GetRegionInfo(0, cc.ccName), NULL),
								 cc.id_area = if(cc.ccType = 36, reg_GetAreaInfo(0, cc.ccName), NULL),
								 cc.id_city = if(cc.ccType = 36, reg_GetCityInfo(0, cc.ccName), NULL),
								 cc.id_mobileProvider = if(cc.ccType = 36, reg_GetOperatorInfo(0, cc.ccName), NULL)
	WHERE cc.ffID = $ffID AND cc.ccName REGEXP '^[0-9]+$';
--
END $$
DELIMITER ;
--
