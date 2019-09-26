DELIMITER $$
DROP PROCEDURE IF EXISTS crm_InsCompany;
CREATE PROCEDURE crm_InsCompany(
    $token                VARCHAR(100)
    , $coID               INT(11)
    , $coName             VARCHAR(100)
    , $coDescription      VARCHAR(100)
    , $inMessage          VARCHAR(5000)
    , $outMessage         VARCHAR(5000)
    , $pauseDelay         INT(11)
    , $isActivePOPup      BIT
    , $isRingingPOPup     BIT
    , $isUpPOPup          BIT
    , $isCCPOPup          BIT
    , $isClosePOPup       BIT
    , $isActive           BIT
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_InsCompany');
  ELSE
    IF $coID IS NULL THEN
      call RAISE(77074, $coID);
    END IF;
    --
    if exists (
      select 1
      from crmCompany
      where Aid = $Aid
        and coName = $coName) then
      call RAISE(77116, NULL);
    end if;
    --
    INSERT INTO crmCompany (
        coID
        , Aid
        , coName
        , coDescription
        , isActive
        , HIID
        , inMessage
        , outMessage
        , pauseDelay
        , isActivePOPup
        , isRingingPOPup
        , isUpPOPup
        , isCCPOPup
        , isClosePOPup
    )
    VALUES (
        $coID
        , $Aid
        , $coName
        , $coDescription
        , $isActive
        , fn_GetStamp()
        , $inMessage
        , $outMessage
        , $pauseDelay
        , $isActivePOPup
        , $isRingingPOPup
        , $isUpPOPup
        , $isCCPOPup
        , $isClosePOPup
    );
  END IF;
END $$
DELIMITER ;
--
