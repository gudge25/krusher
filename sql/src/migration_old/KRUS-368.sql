SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE table_name = 'crmClient'
           AND column_name = 'responsibleID'
    ) > 0,
    "SELECT '+368_7'",
    "ALTER TABLE `crmClient`
	      ADD COLUMN `responsibleID` INT(11) NULL DEFAULT NULL AFTER `Position`;"
));

PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

DROP TABLE IF EXISTS `crmResponsible`;

/*ALTER TABLE `crmClient`
	CHANGE COLUMN `CreatedAt` `Created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `CompanyID`,
	CHANGE COLUMN `EditedAt` `EditedAt` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER `CreatedBy`;
*/