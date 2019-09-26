/*CREATE TABLE IF NOT EXISTS coContract (
   HIID           bigint        NOT NULL -- версия
  ,dcID           int           NOT NULL -- ID документа
  ,ContractType   int           NOT NULL
  ,PRIMARY KEY (dcID)
);
--
CREATE TABLE IF NOT EXISTS DUP_coContract(
   RowID          bigint            NOT NULL auto_increment
  ,OLD_HIID       bigint                NULL
  ,DUP_InsTime    datetime          NOT NULL
  ,DUP_action     enum('I','U','D') NOT NULL
  ,DUP_UserName   varchar(16)       NOT NULL
  ,DUP_HostName   varchar(128)      NOT NULL
  ,DUP_AppName    varchar(128)      NOT NULL
  ,HIID           bigint            NOT NULL -- версия
  ,dcID           int               NOT NULL -- ID документа
  ,ContractType   int               NOT NULL
  ,PRIMARY KEY (RowID)
  ,INDEX DUP_slDeal (HIID,dcID)
);
--
*/