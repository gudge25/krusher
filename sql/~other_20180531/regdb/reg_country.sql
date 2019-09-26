CREATE TABLE IF NOT EXISTS reg_country (
   rcID       int         NOT NULL
  ,rcName     varchar(80) NOT NULL
  ,rcCode     varchar(10) NOT NULL
  ,rcShort    char(2)     NOT NULL
  ,LenNumber  int             NULL
  ,rcNameEng  varchar(50)     NULL  
  ,isCIS	  bit		  NOT NULL DEFAULT(0)
  ,CONSTRAINT regCountry_rcID PRIMARY KEY (rcID)
)ENGINE = InnoDB;