SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_queue_members'
           AND column_name = 'Aid'
    ) > 0,
    "SELECT '+381_10'",
    "ALTER TABLE `ast_queue_members`
	    ALTER `uniqueid` DROP DEFAULT;"
));

PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_queue_members'
           AND column_name = 'Aid'
    ) > 0,
    "SELECT '+381_22'",
    "ALTER TABLE `ast_queue_members`
        CHANGE COLUMN `uniqueid` `quemID` INT(10) UNSIGNED NOT NULL FIRST,
        ADD COLUMN `Aid` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `quemID`,
        ADD COLUMN `emID` INT(10) UNSIGNED NOT NULL AFTER `Aid`,
        ADD COLUMN `queID` INT(10) UNSIGNED NOT NULL AFTER `emID`,
        ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'1' AFTER `paused`,
        ADD INDEX `Aid` (`Aid`),
        ADD INDEX `emID` (`emID`),
        ADD INDEX `queID` (`queID`);"
));


PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE  TABLE_SCHEMA = 'krusher'
            AND table_name = 'ast_queues'
            AND column_name = 'Aid'
    ) > 0,
    "SELECT '+381_46'",
    "ALTER TABLE `ast_queues`
        ADD COLUMN `queID` INT NOT NULL AUTO_INCREMENT COMMENT 'ID очереди' FIRST,
        ADD COLUMN `Aid` INT NOT NULL COMMENT 'ID клиента' AFTER `queID`,
        ADD COLUMN `isActive` BIT NOT NULL DEFAULT b'1' COMMENT 'Признак активна запись или нет' AFTER `Aid`,
        DROP PRIMARY KEY,
        ADD PRIMARY KEY (`queID`),
        ADD INDEX `Aid` (`Aid`),
        ADD INDEX `isActive` (`isActive`),
        ADD INDEX `name` (`name`);"
));

PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_queues'
           AND column_name = 'queID'
    ) > 0,
    "SELECT '+381_67'",
    "ALTER TABLE `ast_queues`
	    ALTER `queID` DROP DEFAULT;"
));

PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

ALTER TABLE `ast_queues`
	CHANGE COLUMN `queID` `queID` INT(11) NOT NULL COMMENT 'ID очереди' FIRST;
