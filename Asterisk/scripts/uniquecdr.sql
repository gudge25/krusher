( select calldate,DATE_FORMAT(calldate,'%d %b %H:%i') AS nicedate,clid,src,dst,duration,disposition,dstchannel,channel,lastdata,COUNT(src) as count from cdr as c
WHERE  calldate >= ( CURDATE() - INTERVAL 0 DAY )
and LENGTH(c.src) >= 7
GROUP BY c.src
LIMIT 50)
UNION
(select calldate,DATE_FORMAT(calldate,'%d %b %H:%i') AS nicedate,clid,src,dst,duration,disposition,dstchannel,channel,lastdata,COUNT(src) as count  from cdr as c
WHERE  calldate >= ( CURDATE() - INTERVAL 0 DAY )
and LENGTH(c.dst) >= 7
GROUP BY c.dst
LIMIT 50)
order by calldate desc