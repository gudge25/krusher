DELIMITER $$
DROP PROCEDURE IF EXISTS `vt_SyncClient`;
DROP PROCEDURE IF EXISTS `vt_SyncClientOrg`;
DROP PROCEDURE IF EXISTS `vt_SyncClientContacts`;
--
CREATE PROCEDURE `vt_SyncClient`()
BEGIN
  declare $clID        int;
  declare $ccID        int;
  declare $accountid   int;
  declare $accountname varchar(100);
  --
  DROP TABLE IF EXISTS tmpClient;
  CREATE TEMPORARY TABLE tmpClient (
     accountid	          int(19)
    ,account_no	          varchar(100)
    ,accountname	        varchar(100)
    ,parentid	            int(19)
    ,account_type	        varchar(200)
    ,industry	            varchar(200)
    ,annualrevenue	      decimal(25,8)
    ,rating	              varchar(200)
    ,ownership	          varchar(50)
    ,siccode	            varchar(50)
    ,tickersymbol	        varchar(30)
    ,phone	              varchar(30)
    ,otherphone	          varchar(30)
    ,email1	              varchar(100)
    ,email2	              varchar(100)
    ,website	            varchar(100)
    ,fax	                varchar(30)
    ,employees	          int(10)
    ,emailoptout	        varchar(3)
    ,notify_owner	        varchar(3)
    ,inn	                varchar(30)
    ,kpp	                varchar(30)
    ,splastsms	          datetime
    ,1c_id	              varchar(255)
    ,isconvertedfromlead	varchar(3));
  --
  insert tmpClient
  select * 
  from vtigercrm540201310.vtiger_account c
  where not exists (
      select 1
      from crm_client
      where clName = c.accountname)
    and accountname is NOT NULL;
  --
  while exists (
    select 1
    from tmpClient)
  do
    select 
       c.accountid
      ,c.accountname
    into
       $accountid
      ,$accountname
    from tmpClient c
    limit 1;
    --
    call us_IPGetNextID('clID',$clID);
    call crm_InsClient($clid, $accountname,0,1,'конвертаци�? втайгер');
    --
    delete from tmpClient
    where accountid = $accountid;
  end while;
END $$
--
CREATE PROCEDURE `vt_SyncClientOrg`()
BEGIN
  declare $clID        int;
  declare $Account     bigint;      
  declare $Bank        varchar(100);  
  declare $TaxCode     bigint;        
  declare $SortCode    int;          
  declare $RegCode     int;           
  declare $CertNumber  int;           
  declare $OrgType     int;
  --
  DROP TABLE IF EXISTS tmpOrg;
  CREATE TEMPORARY TABLE tmpOrg (
     clID       int
    ,cf_791	    varchar(100)
    ,cf_792	    varchar(30)
    ,cf_793	    varchar(250)
    ,cf_794	    varchar(100)
    ,cf_795	    varchar(250)); 
  --
  insert tmpOrg
  select 
     clID  
    ,cf_791	  
    ,cf_792	  
    ,cf_793	  
    ,cf_794	  
    ,cf_795	  
  from vtigercrm540201310.vtiger_accountscf s
    inner join vtigercrm540201310.vtiger_account va on va.accountid = s.accountid
    inner join crm_client cc on cc.clName = va.accountname;
  --
  while exists (
    select 1
    from tmpOrg)
  do
    select 
       clID
--       ,NULLIF(LTRIM(RTRIM(cf_791)),'')
--       ,NULLIF(LTRIM(RTRIM(cf_792)),'')
      ,NULLIF(LTRIM(RTRIM(cf_793)),'')
--       ,NULLIF(LTRIM(RTRIM(cf_794)),'')
--       ,NULLIF(LTRIM(RTRIM(cf_795)),'')
    into 
       $clID
--       ,$TaxCode
--       ,$SortCode
      ,$Bank
--       ,$CertNumber
--       ,$RegCode
    from tmpOrg o
    limit 1;
    --
    if (($TaxCode is NOT NULL
      or $SortCode is NOT NULL
      or $Bank is NOT NULL
      or $CertNumber is NOT NULL
      or $RegCode is NOT NULL)
      and not exists (
        select 1
        from crm_org 
        where clID = $clID))
    then
      -- call crm_InsOrg($clID,$Account,$Bank,$TaxCode,$SortCode,$RegCode,$CertNumber,$OrgType);   
      call crm_InsOrg($clID,$Account,$Bank,$TaxCode,NULL,NULL,NULL,$OrgType);   
    end if;
    --    
    delete from tmpOrg
    where clID = $clID;   
  end while;
  --
  DROP TABLE IF EXISTS tmpOrg;
END $$
--
CREATE PROCEDURE `vt_SyncClientContacts`()
BEGIN
  declare $clID        int;
  declare $ccID        int;
  declare $phone	     varchar(30);
  declare $otherphone	 varchar(30);
  declare $email1	     varchar(100);
  declare $email2	     varchar(100);
  declare $website	   varchar(100);
  declare $fax	       varchar(30);
  --
  DROP TABLE IF EXISTS tmpClient;
  CREATE TEMPORARY TABLE tmpClient (
     clID         int
    ,phone	      varchar(30)
    ,otherphone	  varchar(30)
    ,email1	      varchar(100)
    ,email2	      varchar(100)
    ,website	    varchar(100)
    ,fax	        varchar(30)
  );
  --
  insert tmpClient
  select 
     cl.clID   
    ,c.phone	       
    ,c.otherphone    
    ,c.email1	       
    ,c.email2	       
    ,c.website	     
    ,c.fax	                              
  from vtigercrm540201310.vtiger_account c
    inner join crm_client cl on cl.clName = c.accountname;
  --
  while exists (
    select 1
    from tmpClient)
  do
    select 
       clID
      ,NULLIF(LTRIM(RTRIM(phone)),'')	    
      ,NULLIF(LTRIM(RTRIM(otherphone)),'')	
      ,NULLIF(LTRIM(RTRIM(email1)),'')	    
      ,NULLIF(LTRIM(RTRIM(email2)),'')	    
      ,NULLIF(LTRIM(RTRIM(website)),'')	  
      ,NULLIF(LTRIM(RTRIM(fax)),'')	      
    into 
       $clID
      ,$phone	    
      ,$otherphone	
      ,$email1	    
      ,$email2	    
      ,$website	  
      ,$fax	      
    from tmpClient c
    limit 1;
    --
    if ($phone is NOT NULL
      and not exists (
        select 1
        from crm_contact
        where ccType = 36
          and clID = $clID
          and ccName = $phone)) 
    then      
      call us_IPGetNextID('ccID',$ccID);
      call crm_InsContact($ccID,$clID,$phone,36);
    end if;
    --
    if ($otherphone is NOT NULL
      and not exists (
        select 1
        from crm_contact
        where ccType = 36
          and clID = $clID
          and ccName = $otherphone))
    then 
      call us_IPGetNextID('ccID',$ccID);
      call crm_InsContact($ccID,$clID,$otherphone,36);
    end if;
    --
    if ($email1 is NOT NULL
      and not exists (
        select 1
        from crm_contact
        where ccType = 37
          and clID = $clID
          and ccName = $email1))
    then 
      call us_IPGetNextID('ccID',$ccID);
      call crm_InsContact($ccID,$clID,$email1,37);
    end if;
    --
    if ($email2 is NOT NULL
      and not exists (
        select 1
        from crm_contact
        where ccType = 37
          and clID = $clID
          and ccName = $email1))
    then
      call us_IPGetNextID('ccID',$ccID);
      call crm_InsContact($ccID,$clID,$email2,37);
    end if;
    --
    if ($website is NOT NULL
      and not exists (
        select 1
        from crm_contact
        where ccType = 43
          and clID = $clID
          and ccName = $website))
    then
      call us_IPGetNextID('ccID',$ccID);
      call crm_InsContact($ccID,$clID,$website,43);
    end if;
    --
    if ($fax is NOT NULL
      and not exists (
        select 1
        from crm_contact
        where ccType = 38
          and clID = $clID
          and ccName = $fax))
    then
      call us_IPGetNextID('ccID',$ccID);
      call crm_InsContact($ccID,$clID,$fax,38);
    end if;
    --
    delete from tmpClient
    where clID = $clID;
  end while;
END $$
DELIMITER ;

/*
SET autocommit=0;
start transaction;
call vt_SyncClient();
rollback;
SET autocommit=1;
delete from crm_client where clID = 13;
delete from crm_contact where clID = 13;

select * from crm_client
select * from crm_contact


call vt_SyncClientOrg();
select * from crm_org;
select * from dup_crm_org;
*/


