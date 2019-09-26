CREATE TABLE IF NOT EXISTS reg_gmt (
   gmtID      int         NOT NULL
  ,gmtName    int         NOT NULL
  ,gmtComment varchar(200)    NULL
  ,CONSTRAINT regGmt_gmtID PRIMARY KEY (gmtID)
)ENGINE = InnoDB;