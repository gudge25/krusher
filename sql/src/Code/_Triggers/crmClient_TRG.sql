/*DROP TRIGGER IF EXISTS tI_crmClient;
DROP TRIGGER IF EXISTS tU_crmClient;
DROP TRIGGER IF EXISTS tD_crmClient;
DELIMITER $$
CREATE TRIGGER tI_crmClient BEFORE INSERT on crmClient
FOR EACH ROW
BEGIN
  DECLARE $UserName VARCHAR(30);
  DECLARE $HostName VARCHAR(128);
  DECLARE $CurDate  DATETIME;
  DECLARE $AppName  INT(11);
  --
  SET $UserName = (SELECT emName FROM emEmploy WHERE emID = NEW.CreatedBy AND Aid = NEW.Aid LIMIT 1);
  SET $HostName = fn_GetHostName();
  SET $CurDate  = NOW();
  SET $AppName  = NEW.CreatedBy;
  --
  INSERT DUP_crmClient SET
    OLD_HIID          = NULL
    , DUP_InsTime     = $CurDate
    , DUP_action      = 'I'
    , DUP_UserName    = $UserName
    , DUP_HostName    = $HostName
    , DUP_AppName     = $AppName
    , HIID            = NEW.HIID
    , clID            = NEW.clID
    , Aid             = NEW.Aid
    , clName          = NEW.clName
    , IsPerson        = NEW.IsPerson
    , Sex             = NEW.Sex
    , Comment         = NEW.Comment
    , ParentID        = NEW.ParentID
    , ffID            = NEW.ffID
    , CompanyID       = NEW.CompanyID
    , uID             = NEW.uID
    , isActual        = NEW.isActual
    , ActualStatus    = NEW.ActualStatus
    , Created         = NEW.Created
    , Changed         = NEW.Changed
    , CreatedBy       = NEW.CreatedBy
    , ChangedBy       = NEW.ChangedBy
    , `Position`      = NEW.Position;
END $$
--
CREATE TRIGGER tU_crmClient BEFORE UPDATE on crmClient
FOR EACH ROW
BEGIN
  DECLARE $UserName VARCHAR(30);
  DECLARE $HostName VARCHAR(128);
  DECLARE $CurDate  DATETIME;
  DECLARE $AppName  VARCHAR(128);
  --
  SET $UserName = (SELECT emName FROM emEmploy WHERE emID = NEW.ChangedBy AND Aid = NEW.Aid LIMIT 1);
  SET $HostName = fn_GetHostName();
  SET $CurDate  = NOW();
  SET $AppName  = NEW.ChangedBy;
  --
  insert DUP_crmClient set
    OLD_HIID          = OLD.HIID
    , DUP_InsTime     = $CurDate
    , DUP_action      = 'U'
    , DUP_UserName    = $UserName
    , DUP_HostName    = $HostName
    , DUP_AppName     = $AppName
    , HIID            = NEW.HIID
    , clID            = NEW.clID
    , Aid             = NEW.Aid
    , clName          = NEW.clName
    , IsPerson        = NEW.IsPerson
    , Sex             = NEW.Sex
    , Comment         = NEW.Comment
    , ParentID        = NEW.ParentID
    , ffID            = NEW.ffID
    , CompanyID       = NEW.CompanyID
    , uID             = NEW.uID
    , isActual        = NEW.isActual
    , ActualStatus    = NEW.ActualStatus
    , Created         = NEW.Created
    , Changed         = NEW.Changed
    , CreatedBy       = NEW.CreatedBy
    , ChangedBy       = NEW.ChangedBy
    , `Position`      = NEW.Position;
END $$
--
CREATE TRIGGER tD_crmClient BEFORE DELETE on crmClient
FOR EACH ROW
BEGIN
  DECLARE $UserName VARCHAR(30);
  DECLARE $HostName VARCHAR(128);
  DECLARE $CurDate  DATETIME;
  DECLARE $AppName  VARCHAR(128);
  --
  SET $UserName = (SELECT emName FROM emEmploy WHERE emID = NEW.ChangedBy AND Aid = NEW.Aid LIMIT 1);
  SET $HostName = fn_GetHostName();
  SET $CurDate  = NOW();
  SET $AppName  = USER();
  SET $Stamp    = fn_GetStamp();
  --
  insert DUP_crmClient set
     OLD_HIID       = OLD.HIID
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'D'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = $Stamp
    ,clID           = OLD.clID
    ,clName         = OLD.clName
    ,IsPerson       = OLD.IsPerson
    ,IsActive       = OLD.IsActive
    ,Comment        = OLD.Comment
    ,ffID           = OLD.ffID
    ,ParentID       = OLD.ParentID
    ,CreatedAt      = OLD.CreatedAt
    ,CreatedBy      = OLD.CreatedBy
    ,EditedAt       = OLD.EditedAt
    ,EditedBy       = OLD.EditedBy
    ,uID            = OLD.uID
    ,isActual       = OLD.isActual
    ,ActualStatus   = OLD.ActualStatus
    ,CompanyID      = OLD.CompanyID
    ,Position       = OLD.Position;
END $$
DELIMITER ;
--*/
