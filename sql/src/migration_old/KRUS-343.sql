SET @s = (SELECT IF(
    (SELECT COUNT(1)
     FROM INFORMATION_SCHEMA.COLUMNS
     WHERE table_name = 'ast_cdr'
           AND column_name = 'Aid'
    ) > 0,
    "SELECT '+343_7'",
    "ALTER TABLE `ast_cdr`
      ADD COLUMN `Aid` INT(10) UNSIGNED NOT NULL AFTER `id`,
      ADD INDEX `Aid` (`Aid`);"
));

PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;