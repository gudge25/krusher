DROP PROCEDURE IF EXISTS em_GetPrivateEmploy;
DELIMITER $$
CREATE PROCEDURE em_GetPrivateEmploy(
   $token         VARCHAR(100)
   , $url         VARCHAR(250)
   , $LoginName   VARCHAR(50)
)
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'em_GetEmployReportStatus');
  ELSE
    SET $LoginName = LOWER($LoginName);
    --
    SET @s = (SELECT IF(
      (SELECT COUNT(1)
       FROM emEmploy em
        INNER JOIN emRole er ON er.roleID = em.roleID
        WHERE em.LoginName = $LoginName AND em.Aid = $Aid
        ) > 1,
        CONCAT('SELECT
            em.emID
            , em.emName
            , em.LoginName
            , er.roleID
            , er.roleName
            , er.Permission
            , em.sipID
            , em.sipName
            , em.Queue
            , cl.url
            , cl.phone
            , cl.email_info
            , cl.hosting_type
            , cl.id_currency
            , cl.date_fee
            , cl.balance_amount
            , cl.count_of_calls
            , cl.logo_url
            , cl.client_name
            , cl.client_contact
            , cl.vTigerID
            , em.onlineStatus
            , em.coID coIDs
            , IF(em.sipID IS NOT NULL AND em.sipID > 0, (SELECT MD5(secret) FROM ast_sippeers WHERE sipID = em.sipID AND Aid = em.Aid LIMIT 1), NULL) fop2_secret
            , cl.isActive
          FROM emEmploy em
            INNER JOIN emClient cl ON cl.id_client = em.Aid
            INNER JOIN emRole er ON er.roleID = em.roleID
          WHERE em.LoginName = "', $LoginName, '" AND em.Aid = ', $Aid, ' AND url = "', $url, '"
          LIMIT 1;'),
        CONCAT('SELECT
            em.emID
            , em.emName
            , em.LoginName
            , er.roleID
            , er.roleName
            , er.Permission
            , em.sipID
            , em.sipName
            , em.Queue
            , cl.url
            , cl.phone
            , cl.email_info
            , cl.hosting_type
            , cl.id_currency
            , cl.date_fee
            , cl.balance_amount
            , cl.count_of_calls
            , cl.logo_url
            , cl.client_name
            , cl.client_contact
            , cl.vTigerID
            , em.onlineStatus
            , em.coID coIDs
            , IF(em.sipID IS NOT NULL AND em.sipID > 0, (SELECT MD5(secret) FROM ast_sippeers WHERE sipID = em.sipID AND Aid = em.Aid LIMIT 1), NULL) fop2_secret
            , cl.isActive
          FROM emEmploy em
            INNER JOIN emClient cl ON cl.id_client = em.Aid
            INNER JOIN emRole er ON er.roleID = em.roleID
          WHERE em.LoginName = "', $LoginName, '" AND em.Aid = ', $Aid, '
          LIMIT 1;')
        ));
    CALL query_exec(@s);
  END IF;
END $$
DELIMITER ;
--
