DROP TRIGGER IF EXISTS tI_stProduct;
DROP TRIGGER IF EXISTS tU_stProduct;
DROP TRIGGER IF EXISTS tD_stProduct;
/*DELIMITER $$
CREATE TRIGGER tI_stProduct BEFORE INSERT on stProduct
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
  insert DUP_stProduct set
     OLD_HIID       = NULL
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'I'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = $Stamp
    ,psID           = NEW.psID
    ,psName         = NEW.psName
    ,psState        = NEW.psState
    ,psCode         = NEW.psCode
    ,msID           = NEW.msID
    ,pctID          = NEW.pctID
    ,ParentID       = NEW.ParentID
    ,pcID           = NEW.pcID
    ,CreatedAt      = NEW.CreatedAt
    ,CreatedBy      = NEW.CreatedBy
    ,EditedAt       = NEW.EditedAt
    ,EditedBy       = NEW.EditedBy
    ,bID            = NEW.bID
    ,uID            = NEW.uID
  ;
END $$
--
CREATE TRIGGER tU_stProduct BEFORE UPDATE on stProduct
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
  insert DUP_stProduct set
     OLD_HIID       = OLD.HIID
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'U'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = $Stamp
    ,psID           = NEW.psID
    ,psName         = NEW.psName
    ,psState        = NEW.psState
    ,psCode         = NEW.psCode
    ,msID           = NEW.msID
    ,pctID          = NEW.pctID
    ,ParentID       = NEW.ParentID
    ,pcID           = NEW.pcID
    ,CreatedAt      = NEW.CreatedAt
    ,CreatedBy      = NEW.CreatedBy
    ,EditedAt       = NEW.EditedAt
    ,EditedBy       = NEW.EditedBy
    ,bID            = NEW.bID
    ,uID            = NEW.uID
  ;
END $$
--
CREATE TRIGGER tD_stProduct BEFORE DELETE on stProduct
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
  insert DUP_stProduct set
     OLD_HIID       = OLD.HIID
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'D'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = $Stamp
    ,psID           = OLD.psID
    ,psName         = OLD.psName
    ,psState        = OLD.psState
    ,psCode         = OLD.psCode
    ,msID           = OLD.msID
    ,pctID          = OLD.pctID
    ,ParentID       = OLD.ParentID
    ,pcID           = OLD.pcID
    ,CreatedAt      = OLD.CreatedAt
    ,CreatedBy      = OLD.CreatedBy
    ,EditedAt       = OLD.EditedAt
    ,EditedBy       = OLD.EditedBy
    ,bID            = OLD.bID
    ,uID            = OLD.uID
  ;
END $$
DELIMITER ;
--
*/