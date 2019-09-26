DELIMITER $$
DROP FUNCTION  IF EXISTS crm_IPGetCallStatus;
CREATE FUNCTION crm_IPGetCallStatus (
  $clID varchar(50)
) RETURNS varchar(50)
BEGIN
  DECLARE $status INT;
  --
  /*select
    case
      when d.dcStatus = 7001
        and exists (
          select 1
          from ccComment cc
          where dcID = d.dcID
            and comID != 0) then 201
      when d.dcStatus = 7001 then 202
      when d.dcStatus = 7002 then 203
      when d.dcStatus = 7003 then 204
      else 205
    end as ccStatus
  into $status
  from dcDoc d
  where d.clID = $clID
    and d.dctID = 1
  order by ccStatus asc
  limit 1;*/
  SELECT
    case
      when cc.ccStatus = 7001
        and exists (
          select 1
          from ccComment cc
          where dcID = cc.dcID
            and comID != 0) then 201
      when cc.ccStatus = 7001 then 202
      when cc.ccStatus = 7002 then 203
      when cc.ccStatus = 7003 then 204
      else 205
    end ccStatus
  INTO $status
  FROM ccContact cc
  WHERE cc.clID = $clID
    AND cc.ccStatus = 7001
  #order by ccStatus asc
  limit 1;
  if($status IS NULL)THEN
    SELECT
      case
        when cc.ccStatus = 7001
          and exists (
            select 1
            from ccComment cc
            where dcID = cc.dcID
              and comID != 0) then 201
        when cc.ccStatus = 7001 then 202
        when cc.ccStatus = 7002 then 203
        when cc.ccStatus = 7003 then 204
        else 205
      end ccStatus
    INTO $status
    FROM ccContact cc
    WHERE cc.clID = $clID
      AND cc.ccStatus = 7002
    #order by ccStatus asc
    limit 1;
    if($status IS NULL)THEN
      SELECT
        case
          when cc.ccStatus = 7001
            and exists (
              select 1
              from ccComment cc
              where dcID = cc.dcID
                and comID != 0) then 201
          when cc.ccStatus = 7001 then 202
          when cc.ccStatus = 7002 then 203
          when cc.ccStatus = 7003 then 204
          else 205
        end ccStatus
      INTO $status
      FROM ccContact cc
      WHERE cc.clID = $clID
        AND cc.ccStatus = 7003
      #order by ccStatus asc
      limit 1;
    END IF;
  END IF;
  --
  set $status = if($status is NULL, 206, $status);
  --
  RETURN $status;
END $$
DELIMITER ;
--
