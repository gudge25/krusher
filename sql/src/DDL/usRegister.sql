DROP TABLE IF EXISTS usRegister;
DROP TABLE IF EXISTS DUP_usRegister;
CREATE TABLE IF NOT EXISTS usRegister (
   HIID         bigint        NOT NULL
  ,rgID         int           NOT NULL
  ,rgName       varchar(20)   NOT NULL
  ,rgOwner      int               NULL
  ,rgPath       varchar(255)      NULL
  ,rgValue      text              NULL
  ,PRIMARY KEY (rgID)
);
--
CREATE TABLE IF NOT EXISTS DUP_usRegister (
   RowID          bigint            NOT NULL auto_increment
  ,OLD_HIID       bigint                NULL
  ,DUP_InsTime    datetime          NOT NULL
  ,DUP_action     enum('I','U','D') NOT NULL
  ,DUP_UserName   varchar(16)       NOT NULL
  ,DUP_HostName   varchar(128)      NOT NULL
  ,DUP_AppName    varchar(128)      NOT NULL
  ,HIID           bigint            NOT NULL
  ,rgID           int               NOT NULL
  ,rgName         varchar(20)       NOT NULL
  ,rgOwner        int                   NULL
  ,rgPath         varchar(255)          NULL
  ,rgValue        text                  NULL
  ,PRIMARY KEY (RowID)
);
--
