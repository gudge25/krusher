CREATE TABLE IF NOT EXISTS reg_area (
   raID        int          NOT NULL
  ,raName      varchar(100) NOT NULL  
  ,rcID        int          NOT NULL
  ,GMT         tinyint      NOT NULL
  ,rdID        int              NULL
  ,rkName      varchar(100)     NULL
  ,rkSocr      varchar(10)      NULL
  ,rkCode      varchar(2)       NULL
  ,CONSTRAINT PK_regArea PRIMARY KEY (raID)
  ,CONSTRAINT regArea_regCountry FOREIGN KEY (rcID) REFERENCES reg_country (rcID)
  ,INDEX regArea_rcID (rcID)
)ENGINE = InnoDB;