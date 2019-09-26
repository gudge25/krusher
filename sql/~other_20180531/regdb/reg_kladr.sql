CREATE TABLE IF NOT EXISTS reg_kladr (
   rkID     int           NOT NULL auto_increment
  ,rkName   varchar(100)  NOT NULL
  ,rkSocr   varchar(20)   NOT NULL
  ,rkCode   varchar(13)   NOT NULL
  ,rkIndex  int               NULL
  ,rkGninmb varchar(4)        NULL
  ,rkUno    varchar(4)        NULL
  ,rkOcatd  bigint            NULL  
  ,rkStatus varchar(10)       NULL
  ,PRIMARY KEY (rkID)
  ,KEY IX_RegKladr_rkName (rkname)
  ,KEY IX_RegKladr_rkCode (rkCode)
  ,key IX_RegKladr_rkOcard(rkOcatd)
) ENGINE=MyISAM;