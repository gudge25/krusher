DROP PROCEDURE IF EXISTS fm_InsQuestion;
DELIMITER $$
CREATE PROCEDURE fm_InsQuestion(
    $token            VARCHAR(100)
    , $qID            int           --  'ID записи'
    , $qName          varchar(2000)  --  'вопрос'
    , $ParentID       int           --  'родитель'
    , $tpID           int
    , $isActive       bit
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fm_InsQuestion');
  ELSE
    if ($qID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    --
    insert fmQuestion (
       HIID
      ,qID
      ,qName
      ,isActive
      ,ParentID
      ,tpID
      , Aid
    )
    values (
       fn_GetStamp()
      ,$qID
      ,$qName
      ,$isActive
      ,$ParentID
      ,$tpID
      , $Aid
    );
  END IF;
END $$
DELIMITER ;
--
