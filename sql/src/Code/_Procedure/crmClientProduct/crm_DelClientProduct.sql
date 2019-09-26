DELIMITER $$
DROP PROCEDURE IF EXISTS crm_DelClientProduct;
CREATE PROCEDURE crm_DelClientProduct(
    $token        VARCHAR(100)
    , $cpID       int
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_DelClientProduct');
    ELSE
    if ($cpID is NULL) then
      call RAISE(77021,NULL);
    end if;
    --
    delete from crmClientProduct
    where cpID = $cpID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
