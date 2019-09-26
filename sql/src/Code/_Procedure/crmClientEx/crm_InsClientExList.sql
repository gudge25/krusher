DELIMITER $$
DROP PROCEDURE IF EXISTS crm_InsClientExList;
CREATE PROCEDURE crm_InsClientExList(
    $token      VARCHAR(100)
    , $data     LONGTEXT
) DETERMINISTIC MODIFIES SQL DATA
COMMENT 'Добавляет расширеную шапку клиента'
BEGIN
  /*declare $CurDate  datetime;
  declare $UserEmID int;*/
  declare $Count    int;
  declare $CallDate date;
  DECLARE $Aid            INT;
  DECLARE $emID           INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  SET $emID = fn_GetEmployID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_InsClientExList');
  ELSE
    DROP TABLE IF EXISTS _clIDs;
    CREATE TEMPORARY TABLE _clIDs(
        clID int PRIMARY KEY
    );
    if $data is NULL then
      -- Параметр "ID клинта" должен иметь значение;
      call RAISE(77004, NULL);
    end if;
    --
    /*set $UserEmID = fn_GetEmID();*/
    set $Count    = ExtractValue($data, 'count(/data/clID)');
    set $CallDate = ExtractValue($data, '/data/CallDate/text()');
    --
    while $Count > 0 do
      insert into _clIDs values
        (ExtractValue($data, CONCAT('/data/clID[', CAST($Count as char),']/text()')));
      set $Count = $Count - 1;
    end while;
    --
    delete ex
    from crmClientEx ex
      inner join _clIDs i on i.clID = ex.clID;
    --
    INSERT INTO crmClientEx (
      clID
      , CallDate
      , emID
      , HIID
      , ffID
      )
    SELECT
      c.clID
      , $CallDate
      , $emID
      , fn_GetStamp()
      , (SELECT ffID FROM crmClient WHERE clID = c.clID AND Aid = $Aid LIMIT 1)
    from _clIDs c;
  END IF;
END $$
DELIMITER ;
--
