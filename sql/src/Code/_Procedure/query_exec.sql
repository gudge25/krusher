DROP PROCEDURE IF EXISTS query_exec;
DELIMITER $$
CREATE PROCEDURE query_exec(
    $query           VARCHAR(5000)
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  SET @s = $query;

  PREPARE stmt FROM @s;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
END $$
DELIMITER ;
--
