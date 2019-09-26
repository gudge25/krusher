DROP TRIGGER IF EXISTS tI_crmPerson;
DROP TRIGGER IF EXISTS tU_crmPerson;
DROP TRIGGER IF EXISTS tD_crmPerson;
/*--
DELIMITER $$
CREATE TRIGGER tI_crmPerson BEFORE INSERT on crmPerson
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
  set NEW.HIID  = fn_GetStamp();
  --
  insert DUP_crmPerson set
     OLD_HIID       = NULL
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'I'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = NEW.HIID
    ,pnID           = NEW.pnID
    ,clID           = NEW.clID
    ,pnName         = NEW.pnName
    ,Post           = NEW.Post;
END $$
--
CREATE TRIGGER tU_crmPerson BEFORE UPDATE on crmPerson
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
  insert DUP_crmPerson set
     OLD_HIID       = OLD.HIID
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'U'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = $Stamp
    ,pnID           = NEW.pnID
    ,clID           = NEW.clID
    ,pnName         = NEW.pnName
    ,Post           = NEW.Post;
END $$
--
CREATE TRIGGER tD_crmPerson BEFORE DELETE on crmPerson
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
  insert DUP_crmPerson set
     OLD_HIID       = OLD.HIID
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'D'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = $Stamp
    ,pnID           = OLD.pnID
    ,clID           = OLD.clID
    ,pnName         = OLD.pnName
    ,Post           = OLD.Post;
END $$
DELIMITER ;
--
*/