DELIMITER $$
DROP PROCEDURE IF EXISTS us_InsNewEnums;
CREATE PROCEDURE us_InsNewEnums(
    $tvID               INT(11)
    , $tyID             INT(11)
    , $Name             VARCHAR(100)
    , $isActive         BIT
)
DETERMINISTIC MODIFIES SQL DATA
BEGIN
  declare $n        int;
  declare $i        int;
  declare $Aid      int;
  --
  DROP TABLE IF EXISTS __enums_;
  --
  CREATE TEMPORARY TABLE __enums_ (
    `id` INT NOT NULL AUTO_INCREMENT,
	  `Aid` INT NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`)) ENGINE=MEMORY;
  --
  INSERT INTO __enums_ (
      Aid
  )
  SELECT
    Aid
  FROM usEnumValue
  WHERE Aid > 0
  GROUP BY Aid;
  --
  SELECT count(*)
  INTO $n
  FROM __enums_;
  --
  set $i = 1;
  while $i <= $n do
    select
       Aid
    into
       $Aid
    from __enums_
    where id = $i;
    --
    IF (($tvID IS NULL) AND ($tyID IS NULL) AND ($Name IS NULL)) THEN
      call setEnumsData($Aid);
    ELSE
      call us_IPInsEnum($Aid, $tvID, $tyID, $Name, TRUE);
    END IF;
    --
    set $i = $i + 1;
  end while;
END $$
DELIMITER ;
--
