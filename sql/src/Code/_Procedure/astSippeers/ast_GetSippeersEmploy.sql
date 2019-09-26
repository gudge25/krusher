DELIMITER $$
DROP PROCEDURE IF EXISTS ast_GetSippeersEmploy;
CREATE PROCEDURE ast_GetSippeersEmploy()
BEGIN
  SELECT a.Aid
      , a.sipName
      , a.template
      , (IF(a.nat IS NOT NULL, (SELECT Name FROM usEnumValue WHERE tvID = a.nat AND Aid = a.Aid), NULL)) Name
      , a.secret
      , a.callgroup
      , a.pickupgroup
      , a.callerid
      , b.Queue
      , b.emID
      , b.emName
      , a.dtmfmode
      , IF(a.dtmfmode IS NOT NULL AND a.dtmfmode>0, (SELECT `Name` FROM usEnumValue WHERE tvID=a.`dtmfmode` AND Aid = a.Aid), NULL) f
      , a.`lines`
      , (IF(a.Aid IS NOT NULL, (SELECT count_of_calls FROM emClient WHERE id_client = a.Aid), NULL)) TariffLimit
      , (IF(a.Aid IS NOT NULL, (SELECT purchaseDate FROM emClient WHERE id_client = a.Aid), NULL)) TariffDate
      , a.context context
      , a.transport transport
      , a.encryption  encryption
      , a.avpf  avpf
      , a.force_avp force_avp
      , a.icesupport  icesupport
      , a.videosupport  videosupport
      , a.allow allow
      , a.dtlsenable  dtlsenable
      , a.dtlsverify  dtlsverify
      , a.dtlscertfile  dtlscertfile
      , a.dtlscafile  dtlscafile
      , a.dtlssetup dtlssetup
      , a.isPrimary isPrimary
      , a.`sipType` sipType
  FROM ast_sippeers a
  INNER JOIN emEmploy b ON (a.sipID = b.sipID AND b.Aid = a.Aid)
  WHERE a.isActive = '1' AND a.Aid IN (SELECT id_client FROM emClient WHERE isActive = TRUE)
  ORDER BY a.Aid, a.sipName;
END $$
DELIMITER ;
--
