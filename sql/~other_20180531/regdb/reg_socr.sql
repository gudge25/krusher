CREATE TABLE IF NOT EXISTS reg_socr (
   rsID     int           NOT NULL auto_increment
  ,rsLevel  smallint      NOT NULL
  ,rsSocr   varchar(10)   NOT NULL
  ,rsName   varchar(50)   NOT NULL
  ,rsCode   int               NULL
  ,PRIMARY KEY (rsID)
  ,KEY IX_RegSocr_rsName (rsName)
  ,KEY IX_RegSoct_rsSocr (rsSocr)
) ENGINE=MyISAM;
