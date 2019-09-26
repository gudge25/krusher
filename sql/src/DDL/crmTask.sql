/*CREATE TABLE IF NOT EXISTS crmTask (
   HIID           bigint        NOT NULL -- версия
  ,dcID           int           NOT NULL -- ID документа
  ,DeadLine       datetime          NULL -- дедлайн
  ,tpStart        datetime          NULL -- план начало
  ,tpDuration     decimal(14,2)     NULL -- план кол. времени
  ,tpDurType      int               NULL -- план тип времени
  ,tpFinish       datetime          NULL -- план финиш
  ,isTracking     bit           NOT NULL DEFAULT 0
  ,PRIMARY KEY (dcID)
);
--
CREATE TABLE IF NOT EXISTS DUP_crmTask(
   RowID          bigint            NOT NULL auto_increment
  ,OLD_HIID       bigint                NULL
  ,DUP_InsTime    datetime          NOT NULL
  ,DUP_action     enum('I','U','D') NOT NULL
  ,DUP_UserName   varchar(16)       NOT NULL
  ,DUP_HostName   varchar(128)      NOT NULL
  ,DUP_AppName    varchar(128)      NOT NULL
  ,HIID           bigint            NOT NULL -- версия
  ,dcID           int               NOT NULL -- ID документа
  ,DeadLine       datetime              NULL -- дедлайн
  ,tpStart        datetime              NULL -- план начало
  ,tpDuration     decimal(14,2)         NULL -- план кол. времени
  ,tpDurType      int                   NULL -- план тип времени
  ,tpFinish       datetime              NULL -- план финиш
  ,isTracking     bit               NOT NULL DEFAULT 0
  ,PRIMARY KEY (RowID)
  ,INDEX DUP_crmTask (HIID,dcID)
);
*/
--
