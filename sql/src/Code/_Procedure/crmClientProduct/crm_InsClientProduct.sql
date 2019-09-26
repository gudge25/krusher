DROP PROCEDURE IF EXISTS crm_InsClientProduct;
DELIMITER $$
CREATE PROCEDURE crm_InsClientProduct(
    $token          VARCHAR(100)
    , $cpID         int
    , $clID         int
    , $psID         int
    , $cpQty        decimal(14,4)
    , $cpPrice      decimal(14,2)
    , $isActive     BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  DECLARE $emID           INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  SET $emID = fn_GetEmployID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_InsClientProduct');
  ELSE
    insert crmClientProduct (
       HIID
      ,cpID
      ,clID
      ,psID
      ,cpQty
      ,cpPrice
      , isActive
      , Aid
    )
    values (
       fn_GetStamp()
      ,$cpID
      ,$clID
      ,$psID
      ,$cpQty
      ,$cpPrice
      , $isActive
      , $Aid
    );
  END IF;
END $$
DELIMITER ;
--
