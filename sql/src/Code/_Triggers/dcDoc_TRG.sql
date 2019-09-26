DROP TRIGGER IF EXISTS tI_dcDoc;
DROP TRIGGER IF EXISTS tU_dcDoc;
DROP TRIGGER IF EXISTS tD_dcDoc;

/*
DELIMITER $$
CREATE TRIGGER tI_dcDoc BEFORE INSERT on dcDoc
FOR EACH ROW
BEGIN
  declare $UserName varchar(30);
  declare $HostName varchar(128);
  declare $CurDate  datetime;
  declare $AppName  varchar(128);
  declare $Stamp    bigint;
  --
  set $UserName = fn_GetUserName();
  set $HostName = fn_GetHostName();
  set $CurDate  = NOW();
  set $AppName  = USER();
  set $Stamp    = fn_GetStamp();
  set NEW.HIID  = $Stamp;
  set NEW.uID   = UUID_SHORT();
  --
  insert DUP_dcDoc set
     OLD_HIID       = NULL
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'I'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = NEW.HIID
    ,dcID           = NEW.dcID
    ,dctID          = NEW.dctID
    ,dcNo           = NEW.dcNo
    ,dcState        = NEW.dcState
    ,dcDate         = NEW.dcDate
    ,dcLink         = NEW.dcLink
    ,dcComment      = NEW.dcComment
    ,dcSum          = NEW.dcSum
    ,dcStatus       = NEW.dcStatus
    ,dcRate         = NEW.dcRate
    ,crID           = NEW.crID
    ,clID           = NEW.clID
    ,emID           = NEW.emID
    ,pcID           = NEW.pcID
    ,CreatedAt      = NEW.CreatedAt
    ,CreatedBy      = NEW.CreatedBy
    ,EditedAt       = NEW.EditedAt
    ,EditedBy       = NEW.EditedBy
    ,uID            = NEW.uID;
END $$
--
CREATE TRIGGER tU_dcDoc BEFORE UPDATE on dcDoc
FOR EACH ROW
BEGIN
  declare $UserName varchar(30);
  declare $HostName varchar(128);
  declare $CurDate  datetime;
  declare $AppName  varchar(128);
  declare $Stamp    bigint;
  --
  set $UserName = fn_GetUserName();
  set $HostName = fn_GetHostName();
  set $CurDate  = NOW();
  set $AppName  = USER();
  set $Stamp    = fn_GetStamp();
  set NEW.HIID  = $Stamp;
  --
  insert DUP_dcDoc set
     OLD_HIID       = OLD.HIID
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'U'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = NEW.HIID
    ,dcID           = NEW.dcID
    ,dctID          = NEW.dctID
    ,dcNo           = NEW.dcNo
    ,dcState        = NEW.dcState
    ,dcDate         = NEW.dcDate
    ,dcLink         = NEW.dcLink
    ,dcComment      = NEW.dcComment
    ,dcSum          = NEW.dcSum
    ,dcStatus       = NEW.dcStatus
    ,dcRate         = NEW.dcRate
    ,crID           = NEW.crID
    ,clID           = NEW.clID
    ,emID           = NEW.emID
    ,pcID           = NEW.pcID
    ,CreatedAt      = NEW.CreatedAt
    ,CreatedBy      = NEW.CreatedBy
    ,EditedAt       = NEW.EditedAt
    ,EditedBy       = NEW.EditedBy
    ,uID            = NEW.uID;
END $$
--
CREATE TRIGGER tD_dcDoc BEFORE DELETE on dcDoc
FOR EACH ROW
BEGIN
  declare $UserName varchar(30);
  declare $HostName varchar(128);
  declare $CurDate  datetime;
  declare $AppName  varchar(128);
  declare $Stamp    bigint;
  --
  set $UserName = fn_GetUserName();
  set $HostName = fn_GetHostName();
  set $CurDate  = NOW();
  set $AppName  = USER();
  set $Stamp    = fn_GetStamp();
  --
  insert DUP_dcDoc set
     OLD_HIID       = OLD.HIID
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'D'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = $Stamp
    ,dcID           = OLD.dcID
    ,dctID          = OLD.dctID
    ,dcNo           = OLD.dcNo
    ,dcState        = OLD.dcState
    ,dcDate         = OLD.dcDate
    ,dcLink         = OLD.dcLink
    ,dcComment      = OLD.dcComment
    ,dcSum          = OLD.dcSum
    ,dcStatus       = OLD.dcStatus
    ,clID           = OLD.clID
    ,emID           = OLD.emID
    ,pcID           = OLD.pcID
    ,CreatedAt      = OLD.CreatedAt
    ,CreatedBy      = OLD.CreatedBy
    ,EditedAt       = OLD.EditedAt
    ,EditedBy       = OLD.EditedBy
    ,uID            = OLD.uID;
END $$
DELIMITER ;
--
*/