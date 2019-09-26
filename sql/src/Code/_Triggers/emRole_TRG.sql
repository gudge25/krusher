DROP TRIGGER IF EXISTS tI_emRole;
DROP TRIGGER IF EXISTS tU_emRole;
DROP TRIGGER IF EXISTS tD_emRole;
--
/*
--DELIMITER $$
CREATE TRIGGER tI_emRole BEFORE INSERT on emRole
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
  insert DUP_emRole set
     OLD_HIID       = NULL
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'I'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = $Stamp
    ,roleID         = NEW.roleID
    ,roleName       = NEW.roleName
    ,isActive       = NEW.isActive
    ,Permission     = NEW.Permission
    ,CreatedAt      = NEW.CreatedAt
    ,CreatedBy      = NEW.CreatedBy
    ,EditedAt       = NEW.EditedAt
    ,EditedBy       = NEW.EditedBy;
END $$
--
CREATE TRIGGER tU_emRole BEFORE UPDATE on emRole
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
  insert DUP_emRole set
     OLD_HIID       = OLD.HIID
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'U'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = $Stamp
    ,roleID         = NEW.roleID
    ,roleName       = NEW.roleName
    ,isActive       = NEW.isActive
    ,Permission     = NEW.Permission
    ,CreatedAt      = NEW.CreatedAt
    ,CreatedBy      = NEW.CreatedBy
    ,EditedAt       = NEW.EditedAt
    ,EditedBy       = NEW.EditedBy;
END $$
--
CREATE TRIGGER tD_emRole BEFORE DELETE on emRole
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
  insert DUP_emRole set
     OLD_HIID       = OLD.HIID
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'D'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = OLD.HIID
    ,roleID         = OLD.roleID
    ,roleName       = OLD.roleName
    ,isActive       = OLD.isActive
    ,Permission     = OLD.Permission
    ,CreatedAt      = OLD.CreatedAt
    ,CreatedBy      = OLD.CreatedBy
    ,EditedAt       = OLD.EditedAt
    ,EditedBy       = OLD.EditedBy;
END $$
DELIMITER ;
--
*/