DROP TRIGGER IF EXISTS tI_crmClientEx;
DROP TRIGGER IF EXISTS tU_crmClientEx;
DROP TRIGGER IF EXISTS tD_crmClientEx;
/*DELIMITER $$
CREATE TRIGGER tI_crmClientEx BEFORE INSERT on crmClientEx
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
  insert DUP_crmClientEx set
     DUP_InsTime    = $CurDate
    ,DUP_action     = 'I'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,clID           = NEW.clID
    ,CallDate       = NEW.CallDate
    ,EditedAt       = NEW.EditedAt
    ,EditedBy       = NEW.EditedBy
    ,isNotice       = NEW.isNotice
    ,isRobocall     = NEW.isRobocall
    ,ActDate        = NEW.ActDate
    ,timeZone       = NEW.timeZone
    ,isCallback     = NEW.isCallback
    ,isDial         = NEW.isDial;
END $$
--
CREATE TRIGGER tU_crmClientEx BEFORE UPDATE on crmClientEx
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
  insert DUP_crmClientEx set
     DUP_InsTime    = $CurDate
    ,DUP_action     = 'U'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,clID           = NEW.clID
    ,CallDate       = NEW.CallDate
    ,EditedAt       = NEW.EditedAt
    ,EditedBy       = NEW.EditedBy
    ,isNotice       = NEW.isNotice
    ,isRobocall     = NEW.isRobocall
    ,ActDate        = NEW.ActDate
    ,timeZone       = NEW.timeZone
    ,isCallback     = NEW.isCallback
    ,isDial         = NEW.isDial;
END $$
--
CREATE TRIGGER tD_crmClientEx BEFORE DELETE on crmClientEx
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
  insert DUP_crmClientEx set
     DUP_InsTime    = $CurDate
    ,DUP_action     = 'D'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,clID           = OLD.clID
    ,CallDate       = OLD.CallDate
    ,EditedAt       = OLD.EditedAt
    ,EditedBy       = OLD.EditedBy
    ,isNotice       = OLD.isNotice
    ,isRobocall     = OLD.isRobocall
    ,ActDate        = OLD.ActDate
    ,timeZone       = OLD.timeZone
    ,isCallback     = OLD.isCallback
    ,isDial         = OLD.isDial;
END $$
DELIMITER ;*/
--
