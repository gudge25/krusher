DROP PROCEDURE IF EXISTS crm_UpdClientProduct;
DELIMITER $$
CREATE PROCEDURE crm_UpdClientProduct(
    $token          VARCHAR(100)
    , $HIID         bigint
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

  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_UpdClientProduct');
  ELSE
    if not exists (
      select 1
      from crmClientProduct
      where HIID = $HIID
        and cpID = $cpID AND Aid = $Aid) then
      call RAISE(77003,NULL);
    end if;
    --
    update crmClientProduct set
       HIID       = fn_GetStamp()
      ,psID       = $psID
      ,cpQty      = $cpQty
      ,cpPrice    = $cpPrice
      , isActive = $isActive
    where cpID = $cpID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
