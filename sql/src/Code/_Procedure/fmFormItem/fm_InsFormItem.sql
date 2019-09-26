DROP PROCEDURE IF EXISTS fm_InsFormItem;
DELIMITER $$
CREATE PROCEDURE fm_InsFormItem(
    $token            VARCHAR(100)
    , $fiID           int           -- 'ID записи'
    , $dcID           int           -- 'ID документа'
    , $qID            varchar(200)  -- 'ID вопроса '
    , $qName          varchar(2000)  -- 'вопрос '
    , $qiID           int           -- 'ID вариант ответа'
    , $qiAnswer       varchar(100)  -- 'вариант ответа'
    , $qiComment      varchar(2000)
    , $isActive       BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fm_InsFormItem');
  ELSE
    if ($dcID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021,NULL);
    end if;
    --
    insert fmFormItem (
       HIID
      ,fiID
      ,dcID
      ,qID
      ,qName
      ,qiID
      ,qiAnswer
      ,qiComment
      , isActive
      , Aid
    )
    values (
       fn_GetStamp()
      ,$fiID
      ,$dcID
      ,$qID
      ,$qName
      ,$qiID
      ,$qiAnswer
      ,$qiComment
      , $isActive
      , $Aid
    );
  END IF;
END $$
DELIMITER ;
--
