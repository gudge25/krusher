DELIMITER $$
DROP FUNCTION IF EXISTS fn_GetNumberByString;
CREATE FUNCTION fn_GetNumberByString (
    $str varchar(200)
) RETURNS VARCHAR(50)
BEGIN
  declare $len  tinyint unsigned;
  declare $res  varchar(50);
  declare $i    tinyint unsigned;
  declare $char char;
  --
  set $str = NULLIF(TRIM($str),'');
  if $str is NOT NULL
  then
    set $len = LENGTH($str);
    set $res = '';
    set $i = 1;
    while $i <= $len and $i <= 50
    do
      set $char = SUBSTRING($str, $i, 1);
      if (ASCII($char) between 48 and 57) then
        set $res = CONCAT($res, $char);
      end if;
      --
      set $i = $i + 1;
    end while;
    --
    if SUBSTRING($res, 1, 2) = '89' then
      set $res = CONCAT('7',RIGHT($res, LENGTH($res)-1));
    elseif SUBSTRING($res, 1, 4) = '3800' and LENGTH($res) = 13 then
      set $res = CONCAT('380', RIGHT($res,LENGTH($res)-4));
    end if;
    --
  end if;
  --
  RETURN NULLIF(TRIM(LEADING '0' FROM LEFT($res, 50)), '');
END $$
DELIMITER ;
--
