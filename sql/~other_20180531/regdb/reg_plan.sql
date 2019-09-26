CREATE TABLE IF NOT EXISTS reg_plan (
   rpID        int          NOT NULL auto_increment
  ,CodeDef     smallint     NOT NULL
  ,RangeFrom   int          NOT NULL
  ,RangeTo     int          NOT NULL
  ,Capacity    int              NULL
  ,Operator    varchar(512) NOT NULL
  ,Region      varchar(100) NOT NULL
  ,rkName      varchar(100)     NULL
  ,rkSocr      varchar(10)      NULL
  ,rkCode      varchar(13)      NULL
  ,raID        int              NULL
  ,GMT         tinyint          NULL
  ,CONSTRAINT regPlan_rpID PRIMARY KEY (rpID)
  ,INDEX regPlan_CodeDef (CodeDef, RangeFrom, RangeTo)
  ,INDEX regPlan_raID (raID)
)ENGINE = MyISAM;