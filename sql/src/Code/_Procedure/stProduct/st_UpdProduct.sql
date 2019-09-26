DELIMITER $$
DROP PROCEDURE IF EXISTS st_UpdProduct;
CREATE PROCEDURE st_UpdProduct(
    $token            VARCHAR(100)
    , $HIID           bigint
    , $psID           int
    , $psName         varchar(1020)
    , $psState        int
    , $psCode         varchar(25)
    , $msID           int
    , $pctID          int
    , $ParentID       int
    , $bID            int
    , $isActive       bit
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  declare $emID int;
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'st_InsProduct');
  ELSE
    set $psName = NULLIF(TRIM($psName),'');
    --
    if ($psID is NULL) then
      call RAISE(77021,NULL);
    end if;
    if ($psName is NULL) then
      call RAISE(77022,NULL);
    end if;
    --
    if not exists (
      select 1
      from stProduct
      where HIID = $HIID
        and psID = $psID AND Aid = $Aid) then
      call RAISE(77003,NULL);
    end if;
    --
    set $emID = fn_GetEmployID($token);
    --
    update stProduct set
       HIID       = fn_GetStamp()
      ,psName     = $psName
      ,psState    = $psState
      ,psCode     = $psCode
      ,msID       = $msID
      ,pctID      = $pctID
      ,ParentID   = $ParentID
      ,ChangedBy   = $emID
      ,bID        = $bID
      , isActive  = $isActive
    where psID = $psID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
