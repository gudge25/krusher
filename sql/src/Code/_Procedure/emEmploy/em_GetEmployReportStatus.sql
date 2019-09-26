DROP PROCEDURE IF EXISTS em_GetEmployReportStatus;
DELIMITER $$
CREATE PROCEDURE em_GetEmployReportStatus(
    $token            VARCHAR(100)
    , $dateFrom       date
    , $dateTo         date
    , $dbID           int
    , $ffID           int
    , $actualStatus   int
)
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'em_GetEmployReportStatus');
  ELSE
    set $dateFrom = IFNULL($dateFrom,'2000-01-01');
    set $dateTo = IFNULL($dateTo,CURDATE() + INTERVAL 1 DAY);
    --
    select
       e.emID        as emID
      ,e.emName      as emName
      ,(select
          COUNT(clID) as qtyClient
        from crmClient cl
          inner join fsFile fs on fs.ffID = cl.ffID
        where cl.ChangedBy = e.emID AND cl.Aid = $Aid
          and ((cl.actualStatus = $actualStatus and cl.isActual = 1) or $actualStatus is NULL)
          and (fs.ffID = $ffID or $ffID is NULL)
          and (fs.dbID = $dbID or $dbID is NULL)
          and cl.Changed between $dateFrom and $dateTo) as qtyClient
    from emEmploy e
    where e.isActive = 1 AND e.Aid = $Aid
    group by e.emID;
  END IF;
END $$
DELIMITER ;
--
