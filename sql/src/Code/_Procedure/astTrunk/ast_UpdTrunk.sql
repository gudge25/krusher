DELIMITER $$
DROP PROCEDURE IF EXISTS ast_UpdTrunk;
CREATE PROCEDURE ast_UpdTrunk(
    $HIID                 BIGINT
    , $token              VARCHAR(100)
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
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  DECLARE $coID1          INT;
  DECLARE $poolID         INT;
  DECLARE $poolID1        INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_UpdTrunk');
  ELSE
    IF LENGTH(TRIM($callbackextension)) < 1 THEN
      call RAISE(77074, $callbackextension);
    END IF;
    --
    if not exists (
      select 1
      from ast_trunk
      where HIID = $HIID
        and trID = $trID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действис еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    SELECT coID
    INTO $coID1
    FROM ast_trunk
    WHERE trID = $trID AND Aid = $Aid
    LIMIT 1;
    --
    IF $secret is NULL OR LENGTH(TRIM($callbackextension)) < 1 THEN
      UPDATE ast_trunk SET
        trName                = $trName
        , template            = $template
        , callgroup           = $callgroup
        , pickupgroup         = $pickupgroup
        , callerid            = $callerid
        , host                = $host
        , nat                 = $nat
        , fromuser            = $fromuser
        , defaultuser         = $defaultuser
        , fromdomain          = $fromdomain
        , callbackextension   = $callbackextension
        , isActive            = $isActive
        , HIID                = fn_GetStamp()
        , port                = $port
        , isServer            = $isServer
        , `type`              = $type
        , directmedia         = $directmedia
        , insecure            = $insecure
        , outboundproxy       = $outboundproxy
        , acl                 = $acl
        , dtmfmode            = $dtmfmode
        , DIDs                = $DIDs
        , ManageID            = $ManageID
        , coID                = $coID
        , `lines`             = $lines
        , uniqName            = CONCAT($trName, '_', $Aid)
        , transport           = $transport
        , encryption          = $encryption
        , avpf                = $avpf
        , force_avp           = $force_avp
        , icesupport          = $icesupport
        , videosupport        = $videosupport
        , allow               = $allow
        , dtlsenable          = $dtlsenable
        , dtlsverify          = $dtlsverify
        , dtlscertfile        = $dtlscertfile
        , dtlscafile          = $dtlscafile
        , dtlssetup           = $dtlssetup
      WHERE trID = $trID AND Aid = $Aid AND isReadable = 1;
    ELSE
      UPDATE ast_trunk SET
        trName                = $trName
        , template            = $template
        , secret              = $secret
        , callgroup           = $callgroup
        , pickupgroup         = $pickupgroup
        , callerid            = $callerid
        , host                = $host
        , nat                 = $nat
        , fromuser            = $fromuser
        , defaultuser         = $defaultuser
        , fromdomain          = $fromdomain
        , callbackextension   = $callbackextension
        , isActive            = $isActive
        , HIID                = fn_GetStamp()
        , port                = $port
        , isServer            = $isServer
        , `type`              = $type
        , directmedia         = $directmedia
        , insecure            = $insecure
        , outboundproxy       = $outboundproxy
        , acl                 = $acl
        , dtmfmode            = $dtmfmode
        , DIDs                = $DIDs
        , ManageID            = $ManageID
        , coID                = $coID
        , `lines`             = $lines
        , uniqName            = CONCAT($trName, '_', $Aid)
        , transport           = $transport
        , encryption          = $encryption
        , avpf                = $avpf
        , force_avp           = $force_avp
        , icesupport          = $icesupport
        , videosupport        = $videosupport
        , allow               = $allow
        , dtlsenable          = $dtlsenable
        , dtlsverify          = $dtlsverify
        , dtlscertfile        = $dtlscertfile
        , dtlscafile          = $dtlscafile
        , dtlssetup           = $dtlssetup
      WHERE trID = $trID AND Aid = $Aid AND isReadable = 1;
    END IF;
    --
    IF($coID IS NULL OR $coID = 0)THEN
      IF($coID1 IS NOT NULL AND $coID1>0) THEN
        DELETE FROM ast_pool_list
        WHERE trID = $trID AND Aid = $Aid AND poolID IN (SELECT poolID FROM ast_pools WHERE coID = $coID1 AND Aid = $Aid) ;
        --
        DELETE FROM ast_pools
        WHERE coID = $coID1 AND Aid = $Aid AND poolID NOT IN (SELECT poolID FROM ast_pool_list WHERE Aid = $Aid);
      END IF;
    ELSE
      SELECT '95';
      IF($coID1 IS NOT NULL)THEN
        IF($coID != $coID1)THEN
          SELECT poolID
          INTO $poolID1
          FROM ast_pools
          WHERE coID = $coID1 AND Aid = $Aid
          LIMIT 1;
          --
          SELECT '100';
          IF(($poolID1 IS NOT NULL) AND ($poolID1 > 0)) THEN
            SELECT '181';
            SELECT $trID;
            SELECT $poolID1;
            SELECT $coID1;
            DELETE FROM ast_pool_list
            WHERE trID = $trID AND Aid = $Aid AND poolID = $poolID1 ;
            --
            DELETE FROM ast_pools
            WHERE coID = $coID1 AND Aid = $Aid AND poolID NOT IN (SELECT poolID FROM ast_pool_list WHERE Aid = $Aid);
          END IF;
          --
          SELECT poolID
          INTO $poolID
          FROM ast_pools
          WHERE coID = $coID AND Aid = $Aid
          LIMIT 1;
          --
          SELECT '112';
          IF($poolID IS NOT NULL AND $poolID > 0) THEN
            SELECT '200';
            SELECT $trID;
            SELECT $poolID;
            SELECT $coID;
            DELETE FROM ast_pool_list
            WHERE Aid = $Aid AND poolID = $poolID;
            --
            SELECT '117';
            INSERT ast_pool_list (HIID, plID, Aid, poolID, trID, percent, isActive)
            SELECT fn_GetStamp()
                  /*, us_GetNextSequence('plID')11 04 2019 */
                  , NEXTVAL(plID)
                  , $Aid
                  , $poolID
                  , trID
                  , 1
                  , 1
            FROM ast_trunk
            WHERE coID = $coID AND Aid = $Aid AND isActive = TRUE;
            --
            UPDATE ast_pools SET
              poolName = (SELECT coName FROM crmCompany WHERE coID = $coID AND Aid = $Aid LIMIT 1)
            WHERE coID = $coID AND Aid = $Aid;
          ELSE
          SELECT '223';
          SELECT $trID;
          SELECT $poolID;
          SELECT $coID;
            /*SET $poolID = us_GetNextSequence('poolID'); 11 04 2019*/
            SET $poolID = NEXTVAL(poolID);
            --
            SELECT '131';
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
        ELSE /*если coID не менялся*/
          DELETE FROM ast_pool_list
          WHERE Aid = $Aid AND poolID IN (SELECT poolID FROM ast_pools WHERE coID = $coID AND Aid = $Aid) ;
          --
          SELECT poolID
          INTO $poolID
          FROM ast_pools
          WHERE coID = $coID AND Aid = $Aid
          LIMIT 1;
          --
          select $poolID;
          SELECT '156';
          IF($poolID IS NOT NULL AND $poolID > 0) THEN
            SELECT '158';
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
            --
            UPDATE ast_pools SET
                poolName = (SELECT coName FROM crmCompany WHERE coID = $coID AND Aid = $Aid LIMIT 1)
            WHERE coID = $coID AND Aid = $Aid;
          ELSE
            /*SET $poolID = us_GetNextSequence('poolID'); 11 04 2019*/
            SET $poolID = NEXTVAL(poolID);
            --
            SELECT '172';
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
            --
            UPDATE ast_pools SET
                               poolName = (SELECT coName FROM crmCompany WHERE coID = $coID AND Aid = $Aid LIMIT 1)
            WHERE coID = $coID AND Aid = $Aid;
          END IF;
        END IF;
      ELSE
        SELECT poolID
        INTO $poolID
        FROM ast_pools
        WHERE coID = $coID AND Aid = $Aid
        LIMIT 1;
        --
        SELECT '156';
        select $coID;
        select $poolID;
        IF($poolID IS NOT NULL AND $poolID > 0) THEN
          DELETE FROM ast_pool_list
          WHERE Aid = $Aid AND poolID = $poolID;
          --
          SELECT '158';
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
          --
          UPDATE ast_pools SET
                             poolName = (SELECT coName FROM crmCompany WHERE coID = $coID AND Aid = $Aid LIMIT 1)
          WHERE coID = $coID AND Aid = $Aid;
        ELSE
          /*SET $poolID = us_GetNextSequence('poolID'); 11 04 2019*/
          SET $poolID = NEXTVAL(poolID);
          --
          SELECT '172';
          SELECT $poolID;
          SELECT $coID;
          INSERT ast_pools (HIID, poolID, Aid, poolName, priority, isActive, coID) VALUES (fn_GetStamp(), $poolID, $Aid, (SELECT coName FROM crmCompany WHERE coID = $coID AND Aid = $Aid LIMIT 1), 1, 1, $coID);
          --
          INSERT ast_pool_list (HIID, plID, Aid, poolID, trID, percent, isActive)
          SELECT fn_GetStamp()
                /* , us_GetNextSequence('plID') 11 04 2019*/
                , NEXTVAL(plID)
                , $Aid
                , $poolID
                , trID
                , 1
                , 1
          FROM ast_trunk
          WHERE coID = $coID AND Aid = $Aid AND isActive = TRUE;
          --
          UPDATE ast_pools SET
                             poolName = (SELECT coName FROM crmCompany WHERE coID = $coID AND Aid = $Aid LIMIT 1)
          WHERE coID = $coID AND Aid = $Aid;
        END IF;
      END IF;
        --
    END IF;
    --
    /*DELETE FROM ast_pools
    WHERE coID = $coID1 AND Aid = $Aid AND poolID NOT IN (SELECT poolID FROM ast_pool_list WHERE Aid = $Aid);*/
  END IF;
END $$
DELIMITER ;
--
