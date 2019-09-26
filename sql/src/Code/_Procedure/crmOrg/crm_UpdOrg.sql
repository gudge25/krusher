DELIMITER $$
DROP PROCEDURE IF EXISTS crm_UpdOrg;
CREATE PROCEDURE crm_UpdOrg(
    $token          VARCHAR(100)
    , $HIID         BIGINT
    , $clID         INT
    , $Account      BIGINT
    , $Bank         VARCHAR(100)
    , $TaxCode      VARCHAR(14)
    , $SortCode     INT
    , $RegCode      INT
    , $CertNumber   INT
    , $OrgType      INT
    , $ShortName    VARCHAR(50)
    , $KVED         VARCHAR(7)
    , $KVEDName     VARCHAR(250)
    , $headPost     VARCHAR(50)
    , $headFIO      VARCHAR(100)
    , $headFam      VARCHAR(50)
    , $headIO       VARCHAR(100)
    , $headSex      VARCHAR(10)
    , $orgNote      VARCHAR(100)
    , $isActive     BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  DECLARE $emID           INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);

  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_UpdOrg');
  ELSE
    SET $emID = fn_GetEmployID($token);
    if not exists (
      select 1
      from crmOrg
      where HIID = $HIID
        and clID = $clID) then
      -- Запись была изменена другим пользователем. Обновите документ без сохранения и выполните действие еще раз.
      call RAISE(77003,NULL);
    end if;
    --
    update crmOrg set
      Account       = $Account
      , Bank        = $Bank
      , TaxCode     = $TaxCode
      , SortCode    = $SortCode
      , RegCode     = $RegCode
      , CertNumber  = $CertNumber
      , OrgType     = $OrgType
      , ShortName   = $ShortName
      , KVED        = $KVED
      , KVEDName    = $KVEDName
      , headPost    = $headPost
      , headFIO     = $headFIO
      , headFam     = $headFam
      , headIO      = $headIO
      , headSex     = $headSex
      , orgNote     = $orgNote
      , isActive    = $isActive
      , ChangedBy    = $emID
    where clID = $clID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
