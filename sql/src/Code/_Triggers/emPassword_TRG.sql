DROP TRIGGER IF EXISTS tI_emPassword;
DROP TRIGGER IF EXISTS tU_emPassword;
DROP TRIGGER IF EXISTS tD_emPassword;
--
/*
--DELIMITER $$
CREATE TRIGGER tI_emPassword BEFORE INSERT on emPassword
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
  insert DUP_emPassword set
     OLD_HIID       = NULL
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'I'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = $Stamp
    ,emID           = NEW.emID
    ,LoginName      = NEW.LoginName
    ,Password       = NEW.Password
    ,CreatedAt      = NEW.CreatedAt
    ,CreatedBy      = NEW.CreatedBy;
END $$
--
CREATE TRIGGER tU_emPassword BEFORE UPDATE on emPassword
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
  insert DUP_emPassword set
     OLD_HIID       = OLD.HIID
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'U'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = $Stamp
    ,emID           = NEW.emID
    ,LoginName      = NEW.LoginName
    ,Password       = NEW.Password
    ,CreatedAt      = NEW.CreatedAt
    ,CreatedBy      = NEW.CreatedBy;
END $$
--
CREATE TRIGGER tD_emPassword BEFORE DELETE on emPassword
FOR EACH ROW
BEGIN
  declare $UserName varchar(30);
  declare $HostName varchar(128);
  declare $CurDate  datetime;
  declare $AppName  varchar(128);
  --
  set $UserName = fn_GetUserName();
  set $HostName = fn_GetHostName();
  set $CurDate  = NOW();
  set $AppName  = USER();
  --
  insert DUP_emPassword set
     OLD_HIID       = OLD.HIID
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'D'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = OLD.HIID
    ,emID           = OLD.emID
    ,LoginName      = OLD.LoginName
    ,Password       = OLD.Password
    ,CreatedAt      = OLD.CreatedAt
    ,CreatedBy      = OLD.CreatedBy;
END $$
DELIMITER ;
--
*/