DELIMITER $$
DROP PROCEDURE IF EXISTS ast_GetEmployAidClear;
CREATE PROCEDURE ast_GetEmployAidClear()
BEGIN
    SELECT id_client Aid
          , purchaseDate  TariffDate
          , count_of_calls TariffLimit
    FROM emClient
    WHERE isActive = TRUE;
END $$
DELIMITER ;
--
