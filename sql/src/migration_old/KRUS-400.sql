SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE table_name = 'usEnumValue'
           AND column_name = 'Aid'
    ) > 0,
    "SELECT '+400_7'",
    "ALTER TABLE `usEnumValue`
      ADD COLUMN `Aid` INT NULL DEFAULT '0' COMMENT 'ID клиента' AFTER `tvID`,
      ADD COLUMN `isActive` BIT NULL DEFAULT b'1' COMMENT 'Статус активности записи' AFTER `Name`,
      DROP INDEX `IX_usEnumValues_tyID`,
      ADD UNIQUE INDEX `tvID_Aid_tyID` (`tvID`, `Aid`, `tyID`);"
));

PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
