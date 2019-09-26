DROP PROCEDURE IF EXISTS `sp_split`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_split`(
    $toSplit    text
    , $delim    varchar(12)
    , $target   char(255)
    , $Aid      INT
  )
BEGIN
  # Temp table variables
  SET @tableName = 'tmpSplit';
  SET @fieldName = 'variable';

  # Dropping table
  SET @sql := CONCAT('DROP TABLE IF EXISTS ', @tableName);
  PREPARE stmt FROM @sql;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;

  # Creating table
  SET @sql := CONCAT('CREATE TEMPORARY TABLE ', @tableName, '
                    (', @fieldName, ' VARCHAR(1000)
                    , Aid        int          NOT NULL
                    , INDEX `Aid` (`Aid`)) ENGINE=MEMORY;');
  PREPARE stmt FROM @sql;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;

  # Preparing $toSplit
  SET @vars := $toSplit;
  SET @vars := CONCAT("('", REPLACE(@vars, $delim, CONCAT("', ",$Aid,"),('")), CONCAT("',",$Aid,")"));

  # Inserting values
  SET @sql := CONCAT('INSERT INTO ', @tableName, ' VALUES ', @vars, ';');
  PREPARE stmt FROM @sql;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;

  # Returning record set, or inserting into optional $target
  IF $target IS NULL THEN
    SET @sql := CONCAT('SELECT TRIM(`', @fieldName, '`) AS `', @fieldName, '`, Aid FROM ', @tableName, ' WHERE Aid = ', $Aid);
  ELSE
    SET @sql := CONCAT('INSERT INTO ', $target, ' SELECT NULLIF(TRIM(`', @fieldName, '`),''''), Aid FROM ', @tableName);
  END IF;

  PREPARE stmt FROM @sql;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
END $$
DELIMITER ;
