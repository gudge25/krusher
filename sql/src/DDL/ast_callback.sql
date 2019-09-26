CREATE TABLE IF NOT EXISTS `ast_callback` (
  `HIID` BIGINT NULL DEFAULT '0',
  `cbID` INT NULL AUTO_INCREMENT,
  `Aid` INT(11) NOT NULL DEFAULT '0',
  `cbName` VARCHAR(50) NULL DEFAULT NULL,
  `timeout` INT NULL DEFAULT '0',
  `isFirstClient` BIT NULL DEFAULT b'1',
  `destination` INT NULL DEFAULT NULL,
  `destdata` INT NULL DEFAULT NULL,
  `destdata2` VARCHAR(100) NULL DEFAULT NULL,
  `isActive` BIT NULL DEFAULT b'1',
  `Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `HIID` (`HIID`),
  INDEX `cbID` (`cbID`),
  INDEX `cbName` (`cbName`),
  INDEX `timeout` (`timeout`),
  INDEX `isFirstClient` (`isFirstClient`),
  INDEX `destination` (`destination`),
  INDEX `destdata` (`destdata`),
  INDEX `destdata2` (`destdata2`),
  INDEX `isActive` (`isActive`),
  INDEX `Created` (`Created`),
  INDEX `Aid` (`Aid`)
)
  COLLATE='utf8_general_ci'
  ENGINE=MyISAM
;
--
