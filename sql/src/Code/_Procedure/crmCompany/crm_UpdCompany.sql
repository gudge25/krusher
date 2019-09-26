DELIMITER $$
DROP PROCEDURE IF EXISTS crm_UpdCompany;
CREATE PROCEDURE crm_UpdCompany(
    $HIID                 BIGINT
    , $token              VARCHAR(100)
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
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'crm_UpdCompany');
  ELSE
    --
    if not exists (
      select 1
      from crmCompany
      where HIID = $HIID
        and coID = $coID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действис еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    UPDATE crmCompany SET
        coName                = $coName
        , coDescription       = $coDescription
        , isActive            = $isActive
        , inMessage           = $inMessage
        , outMessage          = $outMessage
        , HIID                = fn_GetStamp()
        , pauseDelay          = $pauseDelay
        , isActivePOPup       = $isActivePOPup
        , isRingingPOPup      = $isRingingPOPup
        , isUpPOPup           = $isUpPOPup
        , isCCPOPup           = $isCCPOPup
        , isClosePOPup        = $isClosePOPup
    WHERE coID = $coID AND Aid = $Aid;
    --
    UPDATE ast_pools SET
        poolName = $coName
    WHERE coID = $coID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
