DROP PROCEDURE IF EXISTS dc_InsDocTemplate;
DELIMITER $$
CREATE PROCEDURE dc_InsDocTemplate(
    $token              VARCHAR(100)
    , $dtID             int
    , $dtName           varchar(100)
    , $dcTypeID         tinyint(4)
    , $dtTemplate       text
    , $isDefault        bit
    , $isActive         bit
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'dc_InsDocTemplate');
  ELSE
    insert dcDocTemplate (
       HIID
      ,dtID
      ,dtName
      ,dcTypeID
      ,dtTemplate
      ,isActive
      ,isDefault
      , Aid
    )
    values (
       fn_GetStamp()
      ,$dtID
      ,$dtName
      ,$dcTypeID
      ,$dtTemplate
      ,IFNULL($isActive,false)
      ,IFNULL($isDefault,false)
      , $Aid
    );
  END IF;
END $$
DELIMITER ;
--
