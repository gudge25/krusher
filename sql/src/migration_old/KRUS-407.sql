SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_autodial_process'
           AND column_name = 'isActive'
    ) > 0,
    "SELECT '+407_7'",
    "ALTER TABLE `ast_autodial_process`
        ADD COLUMN `isActive` BIT NULL DEFAULT b'1' COMMENT 'Признак активности записи' AFTER `description`,
        ADD COLUMN `Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
        ADD COLUMN `Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения записи' AFTER `Created`,
        ADD INDEX `isActive` (`isActive`),
        ADD INDEX `Created` (`Created`),
        ADD INDEX `Changed` (`Changed`),
        ADD INDEX `Aid` (`Aid`);"
));

PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_route_incoming'
           AND column_name = 'Created'
    ) > 0,
    "SELECT '+407_30'",
    "ALTER TABLE `ast_route_incoming`
        ADD COLUMN `Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `DestData`,
        ADD COLUMN `Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения записи' AFTER `Created`,
        ADD INDEX `Created` (`Created`),
        ADD INDEX `Changed` (`Changed`);"
));

PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'ast_scenario'
           AND column_name = 'Created'
    ) > 0,
    "SELECT '+407_49'",
    "ALTER TABLE `ast_scenario`
        ENGINE=MyISAM,
        ADD COLUMN `Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `isActive`,
        ADD COLUMN `Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения записи' AFTER `Created`,
        ADD INDEX `Created` (`Created`),
        ADD INDEX `Changed` (`Changed`);"
));

PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;




