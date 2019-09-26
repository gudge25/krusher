DELIMITER $$
DROP PROCEDURE IF EXISTS us_GetAllCurrency;
CREATE PROCEDURE us_GetAllCurrency()
BEGIN
  select
     crID
    ,crName
    ,crFullName
  from usCurrency;
END $$
DELIMITER ;
--
