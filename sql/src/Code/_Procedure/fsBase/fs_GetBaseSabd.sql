DROP PROCEDURE IF EXISTS fs_GetBaseSabd;
DELIMITER $$
CREATE PROCEDURE fs_GetBaseSabd(
    $token            VARCHAR(100)
)
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fs_GetBaseSabd');
  ELSE
    select
       b.dbName
      ,f.ffID
      ,f.ffName
    from fsFile f
      inner join fsBase b on b.dbID = f.dbID
    where f.isActive = 1
      and b.isActive = 1
      and f.ffID != 0
      AND f.Aid = $Aid
    ORDER BY f.Created DESC;
  END IF;
END $$
DELIMITER ;
--
