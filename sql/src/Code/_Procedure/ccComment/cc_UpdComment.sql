DELIMITER $$
DROP PROCEDURE IF EXISTS cc_UpdComment;
CREATE PROCEDURE cc_UpdComment(
    $token            VARCHAR(100)
    , $HIID           BIGINT
    , $cccID          INT
    , $dcID           INT
    , $comID          INT
    , $comName        VARCHAR(200)
    , $isActive       BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'cc_UpdComment');
  ELSE
    if not exists (
      select 1
      from ccComment
      where HIID = $HIID
        and cccID = $cccID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    UPDATE ccComment SET
      comID         = $comID
      , comName     = $comName
      , isActive    = $isActive
      , dcID        = $dcID
      , HIID        = fn_GetStamp()
    WHERE cccID = $cccID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
