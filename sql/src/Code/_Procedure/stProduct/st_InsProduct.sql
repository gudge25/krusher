DELIMITER $$
DROP PROCEDURE IF EXISTS st_InsProduct;
CREATE PROCEDURE st_InsProduct(
    $token            VARCHAR(100)
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
    set $emID = fn_GetEmployID($token);
    --
    insert stProduct (
       HIID
      ,psID
      ,psName
      ,psState
      ,psCode
      ,msID
      ,pctID
      ,ParentID
      ,pcID
      ,CreatedBy
      ,bID
      , Aid
      , isActive
      , uID
    )
    values (
       fn_GetStamp()
      ,$psID
      ,$psName
      ,$psState
      ,$psCode
      ,$msID
      ,$pctID
      ,$ParentID
      ,0
      ,$emID
      ,$bID
      , $Aid
      , $isActive
      , UUID_SHORT()
    );
  END IF;
END $$
DELIMITER ;
--
