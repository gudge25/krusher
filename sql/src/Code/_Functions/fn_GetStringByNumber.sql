DELIMITER $$
DROP FUNCTION IF EXISTS fn_GetStringByNumber;
CREATE FUNCTION fn_GetStringByNumber (
  $str varchar(200)
) RETURNS VARCHAR(50)
BEGIN
  declare $len  tinyint unsigned;
  declare $res  varchar(50);
  declare $i    tinyint unsigned;
  declare $char char;
  declare $pos  int default 0;
  declare $n    int default 0;
  --
  set $str = NULLIF(TRIM($str),'');
  if $str is NOT NULL
  then
    set $len = LENGTH($str);
    set $res = '';
    set $i = 1;
    while $i <= $len and $i <= 200
    do
      set $char = SUBSTRING($str,$i,1);
      if $char = '(' then
        set $pos = $i + 1;
      elseif $char = ')' then
        set $n = $i - $pos;
      end if;
      --
      set $i = $i + 1;
    end while;
  end if;
  --
  set $res = SUBSTRING($str,$pos,$n);
  RETURN NULLIF(TRIM($res),'');
END $$
DELIMITER ;
--
