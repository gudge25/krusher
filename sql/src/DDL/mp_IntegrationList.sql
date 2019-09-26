CREATE TABLE IF NOT EXISTS `mp_IntegrationList` (
                                                    `HIID` BIGINT(20) NOT NULL DEFAULT '0',
                                                    `mpID` INT(11) NOT NULL AUTO_INCREMENT,
                                                    `Aid` INT(11) NOT NULL DEFAULT '0',
                                                    `mpName` VARCHAR(50) NULL DEFAULT NULL,
                                                    `mpDescription` VARCHAR(500) NULL DEFAULT NULL,
                                                    `mpLinkProvider` VARCHAR(100) NULL DEFAULT NULL,
                                                    `mpCategory` INT(11) NULL DEFAULT '103901',
                                                    `mpLogo` VARCHAR(250) NULL DEFAULT NULL,
                                                    `mpPrice` DECIMAL(10,2) NULL DEFAULT '0',
                                                    `countInstalls` INT(11) NULL DEFAULT '0',
                                                    `order` INT(11) NULL DEFAULT '0',
                                                    `isActive` BIT(1) NULL DEFAULT b'1',
                                                    `Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
                                                    `Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения записи',
                                                    PRIMARY KEY (`mpID`),
                                                    INDEX `mpName` (`mpName`),
                                                    INDEX `mpLinkProvider` (`mpLinkProvider`),
                                                    INDEX `mpCategory` (`mpCategory`),
                                                    INDEX `mpLogo` (`mpLogo`),
                                                    INDEX `mpPrice` (`mpPrice`),
                                                    INDEX `countInstalls` (`countInstalls`),
                                                    INDEX `Created` (`Created`),
                                                    INDEX `isActive` (`isActive`),
                                                    INDEX `order` (`order`)
)
    COMMENT='Список механизмов интеграции'
    ENGINE=MyISAM
;
--
CREATE TABLE IF NOT EXISTS  `mp_IntegrationInstall` (
                                                        `HIID` BIGINT(20) NOT NULL DEFAULT '0',
                                                        `mpiID` INT(11) NOT NULL,
                                                        `Aid` INT(11) NOT NULL DEFAULT '0',
                                                        `mpID` INT(11) NOT NULL DEFAULT '0',
                                                        `login` VARCHAR(50) NULL DEFAULT NULL,
                                                        `pass` VARCHAR(50) NULL DEFAULT NULL,
                                                        `token` VARCHAR(50) NULL DEFAULT NULL,
                                                        `link` VARCHAR(50) NULL DEFAULT NULL,
                                                        `data1` VARCHAR(250) NULL DEFAULT NULL,
                                                        `data2` VARCHAR(250) NULL DEFAULT NULL,
                                                        `data3` VARCHAR(250) NULL DEFAULT NULL,
                                                        `isActive` BIT(1) NULL DEFAULT b'1',
                                                        `Created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
                                                        `Changed` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время изменения записи',
                                                        PRIMARY KEY (`mpiID`),
                                                        INDEX `Aid` (`Aid`),
                                                        INDEX `mpID` (`mpID`),
                                                        INDEX `login` (`login`),
                                                        INDEX `pass` (`pass`),
                                                        INDEX `token` (`token`),
                                                        INDEX `link` (`link`),
                                                        INDEX `isActive` (`isActive`),
                                                        INDEX `Created` (`Created`),
                                                        INDEX `data1` (`data1`),
                                                        INDEX `data2` (`data2`),
                                                        INDEX `data3` (`data3`)
)
    COMMENT='Установки из маркет плейса'
    ENGINE=MyISAM
;
