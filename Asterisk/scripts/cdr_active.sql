DELIMITER $$
DROP PROCEDURE IF EXISTS cdr_active;
CREATE PROCEDURE cdr_active() DETERMINISTIC MODIFIES SQL DATA
BEGIN
  --
SELECT * FROM
  (SELECT calldate,
          DATE_FORMAT(calldate,'%d %b %H:%i') nicedate,
          clid,
          src,
          SUBSTR(c.src, 4),
          dst,
          duration,
          disposition,
          dstchannel,
          `channel`,
          lastdata
  FROM cdr c
  WHERE LENGTH(src) > 6
        AND dstchannel = ""
        AND calldate >= DATE_FORMAT(NOW(), "%Y-%m-%d 00:00:00")
        AND NOT exists (
                  SELECT 1
                  FROM cdr
                  WHERE
                    disposition = 'ANSWERED'
                    AND calldate > c.calldate
                    AND calldate >= DATE_FORMAT(NOW(), "%Y-%m-%d 00:00:00")
                    AND IF(LOCATE('+3', c.src)>0, (src LIKE CONCAT('%', SUBSTR(c.src, 4)) OR
                         lastdata RLIKE SUBSTR(c.src, 4) OR
                         dst = c.src
                        ), (src LIKE CONCAT('%', c.src) OR
                         lastdata RLIKE c.src OR
                         dst = c.src
                        ))
                      )
   LIMIT 100) AS result
GROUP BY result.src
order by calldate desc
LIMIT 100;
--
END $$
DELIMITER ;
GRANT EXECUTE ON PROCEDURE cdr_active TO _dbo;