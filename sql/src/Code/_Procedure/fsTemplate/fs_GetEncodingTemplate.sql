DELIMITER $$
DROP PROCEDURE IF EXISTS fs_GetEncodingTemplate;
CREATE PROCEDURE fs_GetEncodingTemplate(
    $token            VARCHAR(100)
)
BEGIN
  select
     CHARACTER_SET_NAME as Encoding
    ,DESCRIPTION        as Description
  from information_schema.CHARACTER_SETS
  ORDER BY Encoding;
END $$
DELIMITER ;
--
