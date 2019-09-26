DROP TRIGGER IF EXISTS tI_usRegister;
DROP TRIGGER IF EXISTS tU_usRegister;
DROP TRIGGER IF EXISTS tD_usRegister;
/*DELIMITER $$
CREATE TRIGGER tI_usRegister BEFORE INSERT on usRegister
FOR EACH ROW
BEGIN
  declare $UserName varchar(30);
  declare $HostName varchar(128);
  declare $CurDate  datetime;
  declare $AppName  varchar(128);
  declare $Stamp    bigint;
  declare $rgPath   varchar(255);
  --
  select
    rgPath into $rgPath
  from usRegister
  where rgID = NEW.rgOwner;
  --
  if NEW.rgOwner is NOT NULL then
    set NEW.rgPath  = CONCAT(IFNULL($rgPath,''), NEW.rgName);
  else
    -- если вставка папки
    set NEW.rgPath  = CONCAT(IFNULL($rgPath, ''),NEW.rgName,'/');
  end if;
  --
  set $UserName = fn_GetUserName();
  set $HostName = fn_GetHostName();
  set $CurDate  = NOW();
  set $AppName  = USER();
  set $Stamp    = fn_GetStamp();
  set NEW.HIID  = $Stamp;
  --
  insert DUP_usRegister set
     OLD_HIID       = NULL
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'I'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = $Stamp
    ,rgID           = NEW.rgID
    ,rgName         = NEW.rgName
    ,rgOwner        = NEW.rgOwner
    ,rgPath         = NEW.rgPath
    ,rgValue        = NEW.rgValue;
END $$
--
CREATE TRIGGER tU_usRegister BEFORE UPDATE on usRegister
FOR EACH ROW
BEGIN
  declare $UserName varchar(30);
  declare $HostName varchar(128);
  declare $CurDate  datetime;
  declare $AppName  varchar(128);
  declare $Stamp    bigint;
  declare $rgPath   varchar(255);
  --
  select
    rgPath into $rgPath
  from usRegister
  where rgID = NEW.rgOwner;
  --
  if NEW.rgOwner is NOT NULL then
    set NEW.rgPath  = CONCAT(IFNULL($rgPath,''), NEW.rgName);
  else
    -- если вставка папки
    set NEW.rgPath  = CONCAT(IFNULL($rgPath, ''),NEW.rgName,'/');
  end if;
  --
  set $UserName = fn_GetUserName();
  set $HostName = fn_GetHostName();
  set $CurDate  = NOW();
  set $AppName  = USER();
  set $Stamp    = fn_GetStamp();
  set NEW.HIID  = $Stamp;
  --
  insert DUP_usRegister set
     OLD_HIID       = OLD.HIID
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'U'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = $Stamp
    ,rgID           = NEW.rgID
    ,rgName         = NEW.rgName
    ,rgOwner        = NEW.rgOwner
    ,rgPath         = NEW.rgPath
    ,rgValue        = NEW.rgValue;
END $$
--
CREATE TRIGGER tD_usRegister BEFORE DELETE on usRegister
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
  insert DUP_usRegister set
     OLD_HIID       = OLD.HIID
    ,DUP_InsTime    = $CurDate
    ,DUP_action     = 'D'
    ,DUP_UserName   = $UserName
    ,DUP_HostName   = $HostName
    ,DUP_AppName    = $AppName
    ,HIID           = $Stamp
    ,rgID           = OLD.rgID
    ,rgName         = OLD.rgName
    ,rgOwner        = OLD.rgOwner
    ,rgPath         = OLD.rgPath
    ,rgValue        = OLD.rgValue;
END $$
DELIMITER ;*/
--
