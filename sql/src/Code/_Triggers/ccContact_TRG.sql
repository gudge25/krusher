DROP TRIGGER IF EXISTS tI_ccContacts;
DROP TRIGGER IF EXISTS tU_ccContacts;
DROP TRIGGER IF EXISTS tD_ccContacts;
/*
 DELIMITER $$
 CREATE TRIGGER tI_ccContacts BEFORE INSERT on ccContact
 FOR EACH ROW
 BEGIN
   declare $UserName varchar(30);
   declare $HostName varchar(128);
   declare $CurDate  datetime;
   declare $AppName  varchar(128);
   declare $Stamp    bigint;
   
   set $UserName = fn_GetUserName();
   set $HostName = fn_GetHostName();
   set $CurDate  = NOW();
   set $AppName  = USER();
   set $Stamp    = fn_GetStamp();
   set NEW.HIID  = $Stamp;
   
   insert DUP_ccContact set
      OLD_HIID       = NULL
     ,DUP_InsTime    = $CurDate
     ,DUP_action     = 'I'
     ,DUP_UserName   = $UserName
     ,DUP_HostName   = $HostName
     ,DUP_AppName    = $AppName
     ,HIID           = $Stamp
     ,dcID           = NEW.dcID
     ,ccID           = NEW.ccID
     ,ccName         = NEW.ccName
     ,IsOut          = NEW.IsOut
     ,SIP            = NEW.SIP
     ,LinkFile       = NEW.LinkFile;
 END $$
 
 CREATE TRIGGER tU_ccContacts BEFORE UPDATE on ccContact
 FOR EACH ROW
 BEGIN
   declare $UserName varchar(30);
   declare $HostName varchar(128);
   declare $CurDate  datetime;
   declare $AppName  varchar(128);
   declare $Stamp    bigint;
   
   set $UserName = fn_GetUserName();
   set $HostName = fn_GetHostName();
   set $CurDate  = NOW();
   set $AppName  = USER();
   set $Stamp    = fn_GetStamp();
   set NEW.HIID  = $Stamp;
   
   insert DUP_cc_Contacts set
      OLD_HIID       = OLD.HIID
     ,DUP_InsTime    = $CurDate
     ,DUP_action     = 'U'
     ,DUP_UserName   = $UserName
     ,DUP_HostName   = $HostName
     ,DUP_AppName    = $AppName
     ,HIID           = $Stamp
     ,dcID           = NEW.dcID
     ,ccID           = NEW.ccID
     ,ccName         = NEW.ccName
     ,IsOut          = NEW.IsOut
     ,SIP            = NEW.SIP
     ,LinkFile       = NEW.LinkFile;
 END $$
 
 CREATE TRIGGER tD_ccContacts BEFORE DELETE on ccContact
 FOR EACH ROW
 BEGIN
   declare $UserName varchar(30);
   declare $HostName varchar(128);
   declare $CurDate  datetime;
   declare $AppName  varchar(128);
   declare $Stamp    bigint;
   
   set $UserName = fn_GetUserName();
   set $HostName = fn_GetHostName();
   set $CurDate  = NOW();
   set $AppName  = USER();
   set $Stamp    = fn_GetStamp();
   
   insert DUP_ccContact set
      OLD_HIID       = OLD.HIID
     ,DUP_InsTime    = $CurDate
     ,DUP_action     = 'D'
     ,DUP_UserName   = $UserName
     ,DUP_HostName   = $HostName
     ,DUP_AppName    = $AppName
     ,HIID           = $Stamp
     ,dcID           = OLD.dcID
     ,ccID           = OLD.ccID
     ,ccName         = OLD.ccName
     ,IsOut          = OLD.IsOut
     ,SIP            = OLD.SIP
     ,LinkFile       = OLD.LinkFile;
 END $$
 DELIMITER ;
 
*/