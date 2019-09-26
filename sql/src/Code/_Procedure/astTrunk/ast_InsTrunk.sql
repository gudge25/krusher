DELIMITER $$
DROP PROCEDURE IF EXISTS ast_InsTrunk;
CREATE PROCEDURE ast_InsTrunk(
    $token                VARCHAR(100)
    , $trID               INT(11)
    , $trName             VARCHAR(50)
    , $template           VARCHAR(50)
    , $secret             VARCHAR(50)
    , $context            VARCHAR(50)
    , $callgroup          INT(4) UNSIGNED
    , $pickupgroup        INT(4) UNSIGNED
    , $callerid           VARCHAR(80)
    , $host               VARCHAR(80)
    , $nat                INT
    , $defaultuser        VARCHAR(40)
    , $fromuser           VARCHAR(40)
    , $fromdomain         VARCHAR(40)
    , $callbackextension  VARCHAR(40)
    , $port               INT
    , $isServer           BIT
    , $type               INT
    , $directmedia        INT
    , $insecure           INT
    , $outboundproxy      VARCHAR(60)
    , $acl                VARCHAR(60)
    , $dtmfmode           INT(11)
    , $lines              INT(11)
    , $DIDs               VARCHAR(250)
    , $ManageID           INT(11)
    , $coID               INT(11)
    , $transport          VARCHAR(50)
    , $encryption         BIT
    , $avpf               BIT
    , $force_avp          BIT
    , $icesupport         BIT
    , $videosupport       BIT
    , $allow              VARCHAR(50)
    , $dtlsenable         BIT
    , $dtlsverify         BIT
    , $dtlscertfile       VARCHAR(100)
    , $dtlscafile         VARCHAR(100)
    , $dtlssetup          VARCHAR(100)
    , $isActive           BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  DECLARE $poolID         INT;
  DECLARE $poolName       VARCHAR(100);
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_InsTrunk');
  ELSE
    IF $trID IS NULL THEN
      call RAISE(77074, $trID);
    END IF;
    --
    IF LENGTH(TRIM($callbackextension)) < 1 THEN
      call RAISE(77074, $callbackextension);
    END IF;
    --
    if exists (
      select 1
      from ast_trunk
      where Aid != $Aid
        and callbackextension = $callbackextension) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохранения и выполните действия еще раз.
      call RAISE(77075, NULL);
    end if;
    --
    if exists (
      select 1
      from ast_trunk
      where Aid = $Aid
        and trName = $trName) then
      -- Такой транк уже существует
      call RAISE(77111, NULL);
    end if;
    --
    INSERT INTO ast_trunk (
      trID
      , Aid
      , trName
      , template
      , secret
      , context
      , callgroup
      , pickupgroup
      , callerid
      , host
      , nat
      , fromuser
      , defaultuser
      , fromdomain
      , callbackextension
      , isActive
      , HIID
      , port
      , isServer
      , `type`
      , directmedia
      , insecure
      , outboundproxy
      , acl
      , uniqName
      , dtmfmode
      , ManageID
      , DIDs
      , `lines`
      , coID
      , transport
      , encryption
      , avpf
      , force_avp
      , icesupport
      , videosupport
      , allow
      , dtlsenable
      , dtlsverify
      , dtlscertfile
      , dtlscafile
      , dtlssetup
    )
    VALUES (
      $trID
      , $Aid
      , $trName
      , $template
      , $secret
      , CONCAT('incoming_', $Aid)
      , $callgroup
      , $pickupgroup
      , $callerid
      , $host
      , $nat
      , $fromuser
      , $defaultuser
      , $fromdomain
      , $callbackextension
      , $isActive
      , fn_GetStamp()
      , $port
      , $isServer
      , $type
      , $directmedia
      , $insecure
      , $outboundproxy
      , $acl
      , CONCAT($trName, '_', $Aid)
      , $dtmfmode
      , $ManageID
      , $DIDs
      , $lines
      , $coID
      , $transport
      , $encryption
      , $avpf
      , $force_avp
      , $icesupport
      , $videosupport
      , $allow
      , $dtlsenable
      , $dtlsverify
      , $dtlscertfile
      , $dtlscafile
      , $dtlssetup
    );
    IF($coID IS NOT NULL AND $coID > 0) THEN
      SELECT poolID
      INTO $poolID
      FROM ast_pools
      WHERE coID = $coID AND Aid = $Aid
      LIMIT 1;
      --
      IF($poolID IS NOT NULL AND $poolID > 0) THEN
        DELETE FROM ast_pool_list
        WHERE poolID = $poolID AND Aid = $Aid;
        --
        INSERT ast_pool_list (HIID, plID, Aid, poolID, trID, percent, isActive)
        SELECT fn_GetStamp()
              /*, us_GetNextSequence('plID') 11 04 2019*/
              , NEXTVAL(plID)
              , $Aid
              , $poolID
              , trID
              , 1
              , 1
        FROM ast_trunk
        WHERE coID = $coID AND Aid = $Aid AND isActive = TRUE;
      ELSE
        /*SET $poolID = us_GetNextSequence('poolID'); 11 04 2019*/
        SET $poolID = NEXTVAL(poolID);
        --
        INSERT ast_pools (HIID, poolID, Aid, poolName, priority, isActive, coID) VALUES(fn_GetStamp(), $poolID, $Aid, (SELECT coName FROM crmCompany WHERE coID = $coID AND Aid = $Aid LIMIT 1), 1, 1, $coID);
        --
        INSERT ast_pool_list (HIID, plID, Aid, poolID, trID, percent, isActive)
        SELECT fn_GetStamp()
              /*, us_GetNextSequence('plID') 11 04 2019*/
              , NEXTVAL(plID)
              , $Aid
              , $poolID
              , trID
              , 1
              , 1
        FROM ast_trunk
        WHERE coID = $coID AND Aid = $Aid AND isActive = TRUE;
      END IF;
    END IF;
  END IF;
END $$
DELIMITER ;
--
