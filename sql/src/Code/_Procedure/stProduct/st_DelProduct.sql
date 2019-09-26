DELIMITER $$
DROP PROCEDURE IF EXISTS st_DelProduct;
CREATE PROCEDURE st_DelProduct(
    $token        VARCHAR(100)
    , $psID int
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'st_DelProduct');
  ELSE
    if ($psID is NULL) then
      call RAISE(77021,NULL);
    end if;
    --
    delete from stProduct
    where psID = $psID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
