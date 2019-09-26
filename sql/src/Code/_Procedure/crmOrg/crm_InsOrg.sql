DROP PROCEDURE IF EXISTS crm_InsOrg;
DELIMITER $$
CREATE PROCEDURE crm_InsOrg(
    $token          VARCHAR(100)
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
    call RAISE(77068, 'crm_InsOrg');
  ELSE
    SET $emID = fn_GetEmployID($token);
    insert INTO crmOrg (
      HIID
      , clID
      , Aid
      , Account
      , Bank
      , TaxCode
      , SortCode
      , RegCode
      , CertNumber
      , OrgType
      , ShortName
      , KVED
      , KVEDName
      , CreatedBy
      , headPost
      , headFIO
      , headFam
      , headIO
      , headSex
      , orgNote
      , isActive
    )
    values (
      fn_GetStamp()
      , $clID
      , $Aid
      , $Account
      , $Bank
      , $TaxCode
      , $SortCode
      , $RegCode
      , $CertNumber
      , $OrgType
      , $ShortName
      , $KVED
      , $KVEDName
      , $emID
      , $headPost
      , $headFIO
      , $headFam
      , $headIO
      , $headSex
      , $orgNote
      , $isActive
    );
  END IF;
END $$
DELIMITER ;
--
