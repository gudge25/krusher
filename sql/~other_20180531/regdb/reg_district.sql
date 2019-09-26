CREATE TABLE IF NOT EXISTS reg_district (
   rdID   int          NOT NULL
  ,rcID   int          NOT NULL COMMENT 'Страна'
  ,rdName varchar(255) NOT NULL COMMENT 'Наименование округа'
  ,PRIMARY KEY (rdID)
  ,KEY IX_District_rcID (rcID)
)ENGINE=InnoDB COMMENT='Округи';