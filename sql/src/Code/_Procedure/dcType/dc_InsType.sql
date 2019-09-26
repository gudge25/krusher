DROP PROCEDURE IF EXISTS dc_InsType;
DELIMITER $$
CREATE PROCEDURE dc_InsType(
    $token              VARCHAR(100)
    , $dctID            int
    , $dctName          varchar(100)
    , $isActive         bit
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'dc_InsType');
  ELSE
    insert dcType (
       dctID
      ,Aid
      ,dctName
      ,isActive
      , HIID
    )
    values (
      $dctID
      , $Aid
      ,$dctName
      ,IFNULL($isActive,false)
      , fn_GetStamp()
    );
  END IF;
END $$
DELIMITER ;
--
