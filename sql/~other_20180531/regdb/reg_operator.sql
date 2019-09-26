CREATE TABLE IF NOT EXISTS reg_operator (
   ropID        int           NOT NULL
  ,ropName      varchar(50)   NOT NULL
  ,ropKeywords  varchar(80)       NULL
  ,ropImage     varchar(100)      NULL  
  ,rcID         int           NOT NULL
  ,CONSTRAINT regOperator_ropID PRIMARY KEY (ropID)
  ,CONSTRAINT FK_regOperator_regCountry FOREIGN KEY (rcID) REFERENCES reg_country (rcID)
)ENGINE = InnoDB;