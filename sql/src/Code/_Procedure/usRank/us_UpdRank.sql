DELIMITER $$
DROP PROCEDURE IF EXISTS us_UpdRank;
CREATE PROCEDURE us_UpdRank(
    $HIID             BIGINT
    , $token          VARCHAR(100)
    , $uID            VARCHAR(20)
    , $uRank          VARCHAR(200)
    , $type           INT
    , $isActive       BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid      INT;
  DECLARE $emID      INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);

  IF ($Aid = -999) THEN
    call RAISE(77068, 'us_UpdRank');
  ELSE
    if ($uID is NULL) then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    end if;
    if ($uRank is NULL) then
      -- Параметр "Название" должен иметь значение
      call RAISE(77022, NULL);
    end if;
    --
    SET $emID = fn_GetEmployID($token);
    --
    if not exists (
      select 1
      from usRank
      where HIID = $HIID
        and uID = $uID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    update usRank set
      `type`        = $type
      , uRank       = $uRank
      , isActive    = IFNULL($isActive, 0)
      , emID        = $emID
      , HIID        = fn_GetStamp()
    where uID = $uID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
