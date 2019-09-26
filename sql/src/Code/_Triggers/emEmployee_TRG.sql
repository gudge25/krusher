DROP TRIGGER IF EXISTS tI_emEmploy;
DROP TRIGGER IF EXISTS tU_emEmploy;
DROP TRIGGER IF EXISTS tD_emEmploy;
--
/*
--DELIMITER $$
CREATE TRIGGER tI_emEmploy BEFORE INSERT on emEmploy
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
  insert DUP_emEmploy set
     OLD_HIID       = NULL
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'I'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = NEW.HIID
    ,emID           = NEW.emID
    ,emName         = NEW.emName
    ,IsActive       = NEW.IsActive
    ,LoginName      = NEW.LoginName
    ,ManageID       = NEW.ManageID
    ,SipNum         = NEW.SipNum
    ,Queue          = NEW.Queue;
END $$
--
CREATE TRIGGER tU_emEmploy BEFORE UPDATE on emEmploy
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
  insert DUP_emEmploy set
     OLD_HIID       = OLD.HIID
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'U'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = NEW.HIID
    ,emID           = NEW.emID
    ,emName         = NEW.emName
    ,IsActive       = NEW.IsActive
    ,LoginName      = NEW.LoginName
    ,ManageID       = NEW.ManageID
    ,SipNum         = NEW.SipNum
    ,Queue          = NEW.Queue;
END $$
--
CREATE TRIGGER tD_emEmploy BEFORE DELETE on emEmploy
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
  insert DUP_emEmploy set
     OLD_HIID       = OLD.HIID
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'D'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = OLD.HIID
    ,emID           = OLD.emID
    ,emName         = OLD.emName
    ,IsActive       = OLD.IsActive
    ,LoginName      = OLD.LoginName
    ,ManageID       = OLD.ManageID
    ,SipNum         = OLD.SipNum
    ,Queue          = OLD.Queue;
END $$
DELIMITER ;
--
*/