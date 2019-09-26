CREATE TABLE IF NOT EXISTS `ast_events` (
                                            `id` INT(11) NOT NULL AUTO_INCREMENT,
                                            `event` ENUM('Hold','Unhold') NOT NULL,
                                            `ccName` BIGINT(20) UNSIGNED NOT NULL,
                                            `SIP` VARCHAR(10) NOT NULL,
                                            `spentTime` INT(10) UNSIGNED NOT NULL DEFAULT '0',
                                            `timeStart` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                            `timeEnd` DATETIME NULL DEFAULT NULL,
                                            PRIMARY KEY (`id`),
                                            INDEX `event` (`event`),
                                            INDEX `phone` (`ccName`),
                                            INDEX `timeStart` (`timeStart`),
                                            INDEX `timeEnd` (`timeEnd`),
                                            INDEX `SIP` (`SIP`)
)
    COMMENT='Запись инфы о событиях из Астериска'
    COLLATE='utf8_general_ci'
    ENGINE=MyISAM
;
--
