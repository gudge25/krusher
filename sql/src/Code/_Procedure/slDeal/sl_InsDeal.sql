DELIMITER $$
DROP PROCEDURE IF EXISTS sl_InsDeal;
CREATE PROCEDURE sl_InsDeal(
    $token            VARCHAR(100)
    , $dcID           int           -- ID документа
    , $dcNo           varchar(35)   -- Номер документа
    , $dcDate         date          -- дата документа
    , $dcLink         int           -- ID документа основания
    , $dcComment      varchar(200)  -- комментарий
    , $dcSum          decimal(14,2) -- сумма документа
    , $dcStatus       int           -- статус документа
    , $clID           int           -- ID клиента
    , $emID           int           -- ID владельца
    , $isActive       BIT
    , $HasDocNo       varchar(35)   -- номер официального документа
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'sl_InsDeal');
  ELSE
    call sl_IPInsDeal(
      $token
      , $dcID
      , $dcNo
      , $dcDate
      , $dcLink
      , $dcComment
      , $dcSum
      , $dcStatus
      , $clID
      , $emID
      , $HasDocNo
      , $isActive
    );
  END IF;
END $$
DELIMITER ;
--
