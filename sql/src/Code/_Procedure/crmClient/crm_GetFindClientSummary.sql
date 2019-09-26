DROP PROCEDURE IF EXISTS crm_GetFindClientSummary;
DELIMITER $$
CREATE PROCEDURE crm_GetFindClientSummary(
    $token          VARCHAR(100)
    , $clName       varchar(200)
    , $ccName       varchar(50)
    , $ccType       int
    , $regID        int
    , $emID         int
    , $tagID        int
    , $ccStatus     int
    , $clStatus     int
    , $ffID         int
    , $CallDate     datetime
    , $rcID         int
    , $offset       int
    , $limit        int
    , $dctID        int
)
BEGIN
  declare $isWhere  bit;
  declare $sql      varchar(3000);
  declare $sqlWhere varchar(3000);
  declare $_where   varchar(6);
  declare $_and     varchar(6);
  DECLARE $Aid        INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_GetFindClientSummary');
  ELSE
    DROP TABLE IF EXISTS __Summary;
    CREATE TABLE __Summary (
       clID     int
      ,ccStatus int
      ,clStatus int
      ,ffID     int
      ,raID     int
      ,PRIMARY KEY(clID)
    )ENGINE=MEMORY;
    --
    set $offset = IFNULL($offset,0);
    set $limit  = IFNULL($limit,10000);
    set $clName = NULLIF(TRIM($clName),'');
    set $ccName = NULLIF(TRIM($ccName),'');
    set $ccType = IFNULL($ccType,36);
    set $isWhere = 0;
    set $sqlWhere = '';
    --
    set $sql = '
  insert __Summary
  select
     cl.clID      as clID
    ,cs.ccStatus  as ccStatus
    ,cs.clStatus  as clStatus
    ,cl.ffID      as ffID
    #,cr.raID      as raID
  from crmClient cl
    inner join crmStatus cs on cl.clID = cs.clID
    #left outer join crmRegion cr on cl.clID = cr.clID';
    --
    set $_where = 'where ';
    set $_and   = ' and ';
    --
    if $clStatus is NOT NULL then
      set $sqlWhere = CONCAT(CHAR(10),'where cs.clStatus = ',$clStatus);
      set $isWhere = 1;
    end if;
    if $ccStatus is NOT NULL then
      set $sqlWhere = CONCAT($sqlWhere,CHAR(10),if($isWhere = 0,$_where,$_and),'cs.ccStatus = ',$ccStatus);
      set $isWhere = 1;
    end if;
    if $ffID is NOT NULL then
      set $sqlWhere = CONCAT($sqlWhere,CHAR(10),if($isWhere = 0,$_where,$_and),'cl.ffID = ',$ffID);
      set $isWhere = 1;
    end if;
    IF $emID is NOT NULL THEN
      SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), if($isWhere = 0, $_where, $_and), 'cl.responsibleID = ', $emID);
      SET $isWhere = 1;
    END IF;
    /*if $rcID is NOT NULL then
      set $sqlWhere = CONCAT($sqlWhere,CHAR(10),if($isWhere = 0,$_where,$_and),'cr.rcID = ',$rcID);
      set $isWhere = 1;
    end if;
    if $rcID is NOT NULL then
      set $sqlWhere = CONCAT($sqlWhere,CHAR(10),if($isWhere = 0,$_where,$_and),'cr.rcID = ',$rcID);
      set $isWhere = 1;
    end if;*/
    if $dctID is NOT NULL then
      set $sqlWhere = CONCAT($sqlWhere,CHAR(10),if($isWhere = 0,$_where,$_and)
        ,'exists (select 1 from dcDoc where clID = cl.clID and dctID = ',$dctID,')');
      set $isWhere = 1;
    end if;
    if $CallDate is NOT NULL then
      set $sqlWhere = CONCAT($sqlWhere,CHAR(10),if($isWhere = 0,$_where,$_and)
        ,'exists (select 1 from crmClientEx e where e.clID = cl.clID and DATEDIFF(CallDate,',$CallDate,') = 0)');
      set $isWhere = 1;
    end if;
    if $tagID is NOT NULL then
      set $sqlWhere = CONCAT($sqlWhere,CHAR(10),if($isWhere = 0,$_where,$_and)
        ,'exists (select 1 from crmTagList where clID = cl.clID and tagID = ',$tagID,')');
      set $isWhere = 1;
    end if;
    --
    SET $sqlWhere = CONCAT($sqlWhere, CHAR(10), if($isWhere = 0,$_where,$_and), 'cl.Aid = ', $Aid);
    --
    set @s = CONCAT($sql,IFNULL($sqlWhere,0));
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    --
    select
       1001        as FilterID
      ,'clStatus'  as FilterName
      ,clStatus    as Name
      ,COUNT(clID) as Qty
    from __Summary
    group by clStatus
    UNION ALL
    select
       1002          as FilterID
      ,'regName'     as FilterName
      ,IFNULL(cr.raName,'нет') as Name
      ,COUNT(s.clID) as Qty
    from __Summary s
      left outer join regArea cr on cr.raID = s.raID
    group by s.raID, cr.raName
    UNION ALL
    select
       1003                     as Filter
      ,'emName'                 as FilterName
      ,IFNULL(ee.emName,'нет')  as Name
      ,COUNT(s.clID)            as Qty
    from __Summary s
      left outer join emEmploy ee on ee.emID = s.responsibleID
    group by ee.emID, ee.emName
    UNION ALL
    select
       1004         as Filter
      ,'Summary'    as FilterName
      ,'QtyClients' as Name
      ,COUNT(clID)  as Qty
    from crmClient
    UNION ALL
    select
       1005        as FilterID
      ,'ccStatus'  as FilterName
      ,ccStatus    as Name
      ,COUNT(clID) as Qty
    from __Summary
    group by ccStatus
    UNION ALL
    select
       1006          as FilterID
      ,'tagName'     as FilterName
      ,tagName       as Name
      ,COUNT(s.clID) as Qty
    from __Summary s
      inner join crmTag t on s.clID = t.clID
      inner join crmTagList l on t.tagID = l.tagID
    group by l.tagID, l.tagName
    UNION ALL
    select
       t.dctID       as FilterID
      ,'docs'        as FilterName
      ,t.dctName     as Name
      ,COUNT(s.clID) as Qty
    from __Summary s
      inner join dcDoc d on d.clID = s.clID
      inner join dcType t on t.dctID = d.dctID
    group by t.dctID, t.dctName;
  END IF;
END $$
DELIMITER ;
--
