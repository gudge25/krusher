DROP PROCEDURE IF EXISTS sl_InsDealByStatus;
DELIMITER $$
CREATE PROCEDURE sl_InsDealByStatus (
    $token            VARCHAR(100)
    , $comID          int
    , $phone          varchar(50)
    , $sipName        varchar(60)
    , $isActive       BIT
)
BEGIN
  declare $dcID         int;
  declare $dcNo         varchar(35);
  declare $dcDate       date;
  declare $dcComment    varchar(200);
  declare $dcStatus     int default 6001;
  declare $clID         int default 0;
  declare $emID         int default 0;
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'sl_InsDealByStatus');
  ELSE
    select
      c.clID into $clID
    from crmContact c
    where c.ccName = $phone
        AND c.Aid = $Aid
      and exists (
        select 1
        from crmClient cl
          inner join fsFile fs on fs.ffID = cl.ffID
        where cl.clID = c.clID
          AND cl.Aid = $Aid
          and cl.isActive = 1
          and fs.isActive = 1)
    order by c.clID desc
    limit 1;
    --
    select
      e.emID into $emID
    from emEmploy e
    where e.SipName = $sipName
      AND e.Aid = $Aid
    limit 1;
    --
    select
      e.tvID into $dcStatus
    from usEnumValue e
    where exists (
      select 1
      from ccCommentList
      where comID = $comID
        and comName = e.Name
        AND Aid = $Aid)
        AND e.Aid = $Aid;
    --
    /*set $dcID      = us_GetNextSequence('dcID'); 11 04 2019 */
    set $dcID      = NEXTVAL(dcID);
    set $dcNo      = CONCAT('СД-', $dcID);
    set $dcDate    = CURDATE();
    set $dcComment = CONCAT('Создана автоматически, по кнопке ',$comID);
    --
    call sl_IPInsDeal(
      $token
      , $dcID
      , $dcNo
      , $dcDate
      , NULL
      , $dcComment
      , NULL
      , $dcStatus
      , $clID
      , $emID
      , NULL
      , $isActive
    );
  END IF;
END $$
DELIMITER ;
--
