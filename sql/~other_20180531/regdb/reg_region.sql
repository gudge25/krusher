CREATE TABLE IF NOT EXISTS reg_region (
   regID        int         NOT NULL
  ,regName      varchar(50) NOT NULL
  ,Prefix       varchar(10) NOT NULL
  ,gmtID        int             NULL
  ,ropID        int             NULL
  ,RangeStart   int             NULL
  ,RangeEnd     int             NULL
  ,CONSTRAINT regRegion_regID PRIMARY KEY (regID)
  ,CONSTRAINT FK_regRegion_regGmt FOREIGN KEY (gmtID) REFERENCES reg_gmt (gmtID)
  ,CONSTRAINT FK_regRegion_regOperator FOREIGN KEY (ropID) REFERENCES reg_operator (ropID)
)ENGINE = InnoDB;