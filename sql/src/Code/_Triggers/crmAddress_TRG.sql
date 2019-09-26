
DROP TRIGGER IF EXISTS tI_crmAddress;
DROP TRIGGER IF EXISTS tU_crmAddress;
DROP TRIGGER IF EXISTS tD_crmAddress;
/*
DELIMITER $$
CREATE TRIGGER tI_crmAddress BEFORE INSERT on crmAddress
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
  insert DUP_crmAddress set
     OLD_HIID       = NULL
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'I'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = NEW.HIID
    ,adsID          = NEW.adsID
    ,adsName        = NEW.adsName
    ,adtID          = NEW.adtID
    ,Postcode       = NEW.Postcode
    ,clID           = NEW.clID
    ,pntID          = NEW.pntID;
END $$
--
CREATE TRIGGER tU_crmAddress BEFORE UPDATE on crmAddress
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
  insert DUP_crmAddress set
     OLD_HIID       = OLD.HIID
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'U'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = $Stamp
    ,adsID          = NEW.adsID
    ,adsName        = NEW.adsName
    ,adtID          = NEW.adtID
    ,Postcode       = NEW.Postcode
    ,clID           = NEW.clID
    ,pntID          = NEW.pntID;
END $$
--
CREATE TRIGGER tD_crmAddress BEFORE DELETE on crmAddress
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
  insert DUP_crmAddress set
     OLD_HIID       = OLD.HIID
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'D'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = $Stamp
    ,adsID          = OLD.adsID
    ,adsName        = OLD.adsName
    ,adtID          = OLD.adtID
    ,Postcode       = OLD.Postcode
    ,clID           = OLD.clID
    ,pntID          = OLD.pntID;

END $$
DELIMITER ;
*/
--
