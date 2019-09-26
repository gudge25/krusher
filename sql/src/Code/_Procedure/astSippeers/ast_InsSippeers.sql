DELIMITER $$
DROP PROCEDURE IF EXISTS ast_InsSippeers;
CREATE PROCEDURE ast_InsSippeers(
    $token              VARCHAR(100)
    , $sipID            INT(11)
    , $sipName          VARCHAR(50)
    , $template         VARCHAR(50)
    , $secret           VARCHAR(50)
    , $context          VARCHAR(50)
    , $callgroup        INT(11)
    , $pickupgroup      INT(11)
    , $callerid         VARCHAR(80)
    , $nat              INT(11)
    , $lines            INT(11)
    , $dtmfmode         INT(11)
    , $emID             INT(11)
    , $transport        VARCHAR(50)
    , $encryption       BIT
    , $avpf             BIT
    , $force_avp        BIT
    , $icesupport       BIT
    , $videosupport     BIT
    , $allow            VARCHAR(50)
    , $dtlsenable       BIT
    , $dtlsverify       BIT
    , $dtlscertfile     VARCHAR(100)
    , $dtlscafile       VARCHAR(100)
    , $dtlssetup        VARCHAR(100)
    , $isPrimary        BIT
    , $sipType          INT(11)
    , $isActive         BIT
)
BEGIN
  DECLARE $Aid            INT;
  DECLARE $calc           INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_InsSippeers');
  ELSE
    if LENGTH(TRIM($secret)) < 12 then
      -- Параметр "Пароль" должен иметь значение
      call RAISE(77025, NULL);
    end if;
    --
    if $callgroup IS NOT NULL then
      if $callgroup > 63 then
        call RAISE(77077, 'callgroup');
      end if;
    end if;
    --
    if $pickupgroup IS NOT NULL then
      if $pickupgroup > 63 then
        call RAISE(77077, 'pickupgroup');
      end if;
    end if;
    --
    SELECT count(sipID)
      INTO $calc
    FROM ast_sippeers
    WHERE sipName = $sipName AND Aid = $Aid;
    IF $calc>0 THEN
      call RAISE(77118, NULL);
    END IF;
    --
    INSERT INTO ast_sippeers (
      sipID
      , sipName
      , template
      , secret
      , `context`
      , callgroup
      , pickupgroup
      , callerid
      , isActive
      , emID
      , Aid
      , HIID
      , nat
      , dtmfmode
      , `lines`
      , transport
      , `encryption`
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
      , isPrimary
      , sipType
    )
    values (
      $sipID
      , $sipName
      , $template
      , $secret
      , CONCAT($context, '_', $Aid)
      , $callgroup
      , $pickupgroup
      , $callerid
      , $isActive
      , $emID
      , $Aid
      , fn_GetStamp()
      , $nat
      , $dtmfmode
      , $lines
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
      , $isPrimary
      , $sipType
    );
  END IF;
END $$
DELIMITER ;
--
