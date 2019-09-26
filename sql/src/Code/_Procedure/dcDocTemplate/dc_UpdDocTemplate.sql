DROP PROCEDURE IF EXISTS dc_UpdDocTemplate;
DELIMITER $$
CREATE PROCEDURE dc_UpdDocTemplate(
    $token            VARCHAR(100)
    , $HIID           bigint
    , $dtID           int
    , $dtName         varchar(100)
    , $dcTypeID       tinyint(4)
    , $dtTemplate     text
    , $isDefault      bit
    , $isActive       bit
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'dc_UpdDocTemplate');
  ELSE
    if not exists (
      select 1
      from dcDocTemplate
      where HIID = $HIID
        and dtID = $dtID AND Aid = $Aid) then
      call RAISE(77003,NULL);
    end if;
    --
    update dcDocTemplate set
       HIID          = fn_GetStamp()
      ,dtName        = $dtName
      ,dcTypeID      = $dcTypeID
      ,dtTemplate    = $dtTemplate
      ,isActive      = $isActive
      ,isDefault     = $isDefault
    where dtID = $dtID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
