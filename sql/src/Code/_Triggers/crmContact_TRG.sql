DROP TRIGGER IF EXISTS tI_crmContact;
DROP TRIGGER IF EXISTS tU_crmContact;
DROP TRIGGER IF EXISTS tD_crmContact;
--
/*
DELIMITER $$
CREATE TRIGGER tI_crmContact BEFORE INSERT on crmContact
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
  insert DUP_crmContact set
     OLD_HIID       = NULL
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'I'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = NEW.HIID
    ,ccID           = NEW.ccID
    ,clID           = NEW.clID
    ,ccName         = NEW.ccName
    ,ccType         = NEW.ccType
    ,isPrimary      = NEW.isPrimary
    ,isActive       = NEW.isActive
    ,ccStatus       = NEW.ccStatus
    ,ccComment      = NEW.ccComment;
END $$
--
CREATE TRIGGER tU_crmContact BEFORE UPDATE on crmContact
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
  insert DUP_crmContact set
     OLD_HIID       = OLD.HIID
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'U'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = $Stamp
    ,ccID           = NEW.ccID
    ,clID           = NEW.clID
    ,ccName         = NEW.ccName
    ,ccType         = NEW.ccType
    ,isPrimary      = NEW.isPrimary
    ,isActive       = NEW.isActive
    ,ccStatus       = NEW.ccStatus
    ,ccComment      = NEW.ccComment;
END $$
--
CREATE TRIGGER tD_crmContact BEFORE DELETE on crmContact
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
  insert DUP_crmContact set
     OLD_HIID       = OLD.HIID
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'D'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = $Stamp
    ,ccID           = OLD.ccID
    ,clID           = OLD.clID
    ,ccName         = OLD.ccName
    ,ccType         = OLD.ccType
    ,isPrimary      = OLD.isPrimary
    ,isActive       = OLD.isActive
    ,ccStatus       = OLD.ccStatus
    ,ccComment      = OLD.ccComment;
END $$
DELIMITER ;
*/
--
