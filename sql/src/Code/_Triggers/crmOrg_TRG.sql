DROP TRIGGER IF EXISTS tI_crmOrg;
DROP TRIGGER IF EXISTS tU_crmOrg;
DROP TRIGGER IF EXISTS tD_crmOrg;
--
/*
DELIMITER $$
CREATE TRIGGER tI_crmOrg BEFORE INSERT on crmOrg
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
  insert DUP_crmOrg set
     OLD_HIID       = NULL
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'I'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = $Stamp
    ,clID           = NEW.clID
    ,Account        = NEW.Account
    ,Bank           = NEW.Bank
    ,TaxCode        = NEW.TaxCode
    ,SortCode       = NEW.SortCode
    ,RegCode        = NEW.RegCode
    ,CertNumber     = NEW.CertNumber
    ,OrgType        = NEW.OrgType
    ,CreatedAt      = NEW.CreatedAt
    ,CreatedBy      = NEW.CreatedBy
    ,EditedAt       = NEW.EditedAt
    ,EditedBy       = NEW.EditedBy
    ,ShortName      = NEW.ShortName
    ,KVED           = NEW.KVED
    ,KVEDName       = NEW.KVEDName
    ,headPost       = NEW.headPost
    ,headFIO        = NEW.headFIO
    ,headFam        = NEW.headFam
    ,headIO         = NEW.headIO
    ,headSex        = NEW.headSex
    ,orgNote        = NEW.orgNote;
END $$
--
CREATE TRIGGER tU_crmOrg BEFORE UPDATE on crmOrg
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
  insert DUP_crmOrg set
     OLD_HIID       = OLD.HIID
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'U'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = $Stamp
    ,clID           = NEW.clID
    ,Account        = NEW.Account
    ,Bank           = NEW.Bank
    ,TaxCode        = NEW.TaxCode
    ,SortCode       = NEW.SortCode
    ,RegCode        = NEW.RegCode
    ,CertNumber     = NEW.CertNumber
    ,OrgType        = NEW.OrgType
    ,CreatedAt      = NEW.CreatedAt
    ,CreatedBy      = NEW.CreatedBy
    ,EditedAt       = NEW.EditedAt
    ,EditedBy       = NEW.EditedBy
    ,ShortName      = NEW.ShortName
    ,KVED           = NEW.KVED
    ,KVEDName       = NEW.KVEDName
    ,headPost       = NEW.headPost
    ,headFIO        = NEW.headFIO
    ,headFam        = NEW.headFam
    ,headIO         = NEW.headIO
    ,headSex        = NEW.headSex
    ,orgNote        = NEW.orgNote;
END $$
--
CREATE TRIGGER tD_crmOrg BEFORE DELETE on crmOrg
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
  insert DUP_crmOrg set
     OLD_HIID       = OLD.HIID
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'D'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = OLD.HIID
    ,clID           = OLD.clID
    ,Account        = OLD.Account
    ,Bank           = OLD.Bank
    ,TaxCode        = OLD.TaxCode
    ,SortCode       = OLD.SortCode
    ,RegCode        = OLD.RegCode
    ,CertNumber     = OLD.CertNumber
    ,OrgType        = OLD.OrgType
    ,CreatedAt      = OLD.CreatedAt
    ,CreatedBy      = OLD.CreatedBy
    ,EditedAt       = OLD.EditedAt
    ,EditedBy       = OLD.EditedBy
    ,ShortName      = OLD.ShortName
    ,KVED           = OLD.KVED
    ,KVEDName       = OLD.KVEDName
    ,headPost       = OLD.headPost
    ,headFIO        = OLD.headFIO
    ,headFam        = OLD.headFam
    ,headIO         = OLD.headIO
    ,headSex        = OLD.headSex
    ,orgNote        = OLD.orgNote;
END $$
DELIMITER ;
*/
--
