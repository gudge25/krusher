DROP PROCEDURE IF EXISTS crm_SetSabdResponsible;
DELIMITER $$
CREATE PROCEDURE crm_SetSabdResponsible(
    $token          VARCHAR(100)
    , $ffID         INT
)
DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $qtyResp  INT DEFAULT 0;
  DECLARE $lim      INT;
  DECLARE $emID            INT;
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_SetSabdResponsible');
  ELSE
    SET $emID = fn_GetEmployID($token);
    --
    SELECT COUNT(*)       qty
    INTO $qtyResp
    FROM crmClient cl
    INNER JOIN crmClientEx ex ON ex.clID = cl.clID
    WHERE ffID = $ffID
          AND isActual = 0
          AND CallDate<NOW()
          AND responsibleID = $emID
          AND cl.Aid = $Aid;
    --
    IF $qtyResp < 3 THEN
      SET $lim = 3-$qtyResp;
      --
      UPDATE crmClient SET responsibleID = $emID WHERE ffID = $ffID AND responsibleID IS NULL AND Aid = $Aid LIMIT $lim;
    END IF;
  END IF;
END $$
DELIMITER ;
--
