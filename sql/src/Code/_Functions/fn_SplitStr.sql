DELIMITER $$
DROP FUNCTION IF EXISTS fn_SplitStr;
CREATE FUNCTION fn_SplitStr(
   $str   mediumtext
  ,$delim varchar(12)
  ,$pos   int
) RETURNS varchar(255)
BEGIN
  declare $Result varchar(255);
  --
  set $Result = REPLACE(SUBSTRING(SUBSTRING_INDEX($str, $delim, $pos)
                  ,LENGTH(SUBSTRING_INDEX($str, $delim, $pos -1)) + 1)
                  ,$delim, '');
  --
  RETURN $Result;
END $$
DELIMITER ;
--
