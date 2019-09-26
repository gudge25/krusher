DELIMITER $$
DROP PROCEDURE IF EXISTS cc_UpdCommentList;
CREATE PROCEDURE cc_UpdCommentList(
    $token          VARCHAR(100)
    , $HIID         BIGINT
    , $comID        INT
    , $comName      VARCHAR(200)
    , $isActive     BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'cc_UpdCommentList');
  ELSE
    if not exists (
      select 1
      from ccCommentList
      where HIID = $HIID
        and comID = $comID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    UPDATE ccCommentList SET
       comName = $comName
       , isActive = $isActive
       , HIID        = fn_GetStamp()
    WHERE comID = $comID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
