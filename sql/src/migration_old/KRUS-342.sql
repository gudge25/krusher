SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE table_name = 'ccContact'
           AND column_name = 'Created'
    ) > 0,
    "SELECT '+342_7'",
    "ALTER TABLE `ccContact`
      ADD COLUMN `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания записи' AFTER `CallType`,
      ADD COLUMN `IsMissed` BIT NOT NULL DEFAULT b'0' COMMENT 'Признак, что на этот пропущенный звонок еще не перезвонили' AFTER `Created`;"
));

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE table_name = 'ccContact' AND COLUMN_NAME = 'Created' AND COLUMN_KEY!=''
    ) > 0,
    "SELECT '+342_19'",
    "ALTER TABLE `ccContact`
	    ADD INDEX `Created` (`Created`);"
));

PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE table_name = 'ccContact'
           AND column_name = 'id_scenario'
    ) > 0,
    "SELECT '+342_34'",
    "ALTER TABLE `ccContact`
      ADD COLUMN `id_scenario` INT NOT NULL DEFAULT '0' COMMENT 'id сценария' AFTER `IsMissed`,
      ADD COLUMN `IsTarget` BIT NULL DEFAULT NULL COMMENT 'Достигнута ли цели по сценарию автообзвона' AFTER `id_scenario`;"
));

PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE table_name = 'ccContact'
           AND column_name = 'ccStatus'
    ) > 0,
    "SELECT '+342_50'",
    "ALTER TABLE `ccContact`
      ADD COLUMN `ccStatus` INT NULL DEFAULT NULL COMMENT 'Статус звонка' AFTER `IsTarget`,
      ADD COLUMN `emID` INT NULL DEFAULT NULL COMMENT 'ID ответственного' AFTER `ccStatus`;"
));

PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE table_name = 'ccContact'
           AND column_name = 'clID'
    ) > 0,
    "SELECT '+342_66'",
    "ALTER TABLE `ccContact`
      ADD COLUMN `clID` INT(11) NULL COMMENT 'ID клиента' AFTER `emID`,
      ADD COLUMN `ffID` INT(11) NULL COMMENT 'ID базы' AFTER `clID`;"
));

PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE table_name = 'ccContact'
           AND column_name = 'id_autodial'
    ) > 0,
    "SELECT '+342_82'",
    "ALTER TABLE `ccContact`
      ADD COLUMN `id_autodial` INT NOT NULL DEFAULT '0' COMMENT 'id процесса автообзвона' AFTER `IsMissed`,
      CHANGE COLUMN `id_scenario` `id_scenario` INT(11) NOT NULL DEFAULT '0' COMMENT 'id сценария' AFTER `id_autodial`;"
));

PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
