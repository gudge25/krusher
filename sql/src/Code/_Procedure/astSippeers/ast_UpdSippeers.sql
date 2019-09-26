DELIMITER $$
DROP PROCEDURE IF EXISTS ast_UpdSippeers;
CREATE PROCEDURE ast_UpdSippeers(
    $HIID               BIGINT
    , $token            VARCHAR(100)
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
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  DECLARE $calc           INT;
  DECLARE $siID           INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_UpdSippeers');
  ELSE
    if ((NULLIF(TRIM($secret),'') is NOT NULL) AND (LENGTH($secret) < 12)) then
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
    if not exists (
      select 1
      from ast_sippeers
      where HIID = $HIID
        and sipID = $sipID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохранения и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    SELECT count(sipID), sipID
      INTO $calc, $siID
    FROM ast_sippeers
    WHERE sipName = $sipName AND Aid = $Aid;
    IF $calc>1 OR $siID != $sipID THEN
      call RAISE(77118, NULL);
    END IF;
    --
    IF NULLIF(TRIM($secret),'') is NOT NULL THEN
      update ast_sippeers set
        sipName           = $sipName
        , template        = $template
        , secret          = $secret
        , emID            = $emID
        , callgroup       = $callgroup
        , pickupgroup     = $pickupgroup
        , callerid        = $callerid
        , isActive        = $isActive
        , HIID            = fn_GetStamp()
        , nat             = $nat
        , `lines`         = $lines
        , dtmfmode        = $dtmfmode
        , transport       = $transport
        , `encryption`    = $encryption
        , avpf            = $avpf
        , force_avp       = $force_avp
        , icesupport      = $icesupport
        , videosupport    = $videosupport
        , allow           = $allow
        , dtlsenable      = $dtlsenable
        , dtlsverify      = $dtlsverify
        , dtlscertfile    = $dtlscertfile
        , dtlscafile      = $dtlscafile
        , dtlssetup       = $dtlssetup
        , isPrimary       = $isPrimary
        , sipType         = $sipType
      where sipID = $sipID AND Aid = $Aid;
    ELSE
      update ast_sippeers set
        sipName           = $sipName
        , template        = $template
        , emID            = $emID
        , callgroup       = $callgroup
        , pickupgroup     = $pickupgroup
        , callerid        = $callerid
        , isActive        = $isActive
        , HIID            = fn_GetStamp()
        , nat             = $nat
        , `lines`         = $lines
        , dtmfmode        = $dtmfmode
        , transport       = $transport
        , `encryption`      = $encryption
        , avpf            = $avpf
        , force_avp       = $force_avp
        , icesupport      = $icesupport
        , videosupport    = $videosupport
        , allow           = $allow
        , dtlsenable      = $dtlsenable
        , dtlsverify      = $dtlsverify
        , dtlscertfile    = $dtlscertfile
        , dtlscafile      = $dtlscafile
        , dtlssetup       = $dtlssetup
        , isPrimary       = $isPrimary
        , sipType         = $sipType
      where sipID = $sipID AND Aid = $Aid;
    END IF;
  END IF;
END $$
DELIMITER ;
--
