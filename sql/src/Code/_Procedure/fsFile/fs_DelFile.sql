DROP PROCEDURE IF EXISTS fs_DelFile;
DELIMITER $$
CREATE PROCEDURE fs_DelFile(
    $token            VARCHAR(100)
    , $ffID           int
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'fs_DelFile');
  ELSE
    if $ffID is NULL then
      -- Параметр "ID записи" должен иметь значение
      call RAISE(77021, NULL);
    end if;
    --
    if $ffID = 0 then
      -- Запрещено удалять базу клиентов [Default]
      call RAISE(77041, NULL);
    end if;
    --
    DELETE FROM slDealItem WHERE Aid = $Aid AND dcID IN (SELECT dcID FROM dcDoc WHERE Aid = $Aid AND ffID = $ffID);
/*      inner join dcDoc d on d.dcID = c.dcID
      inner join crmClient cl on cl.clID = d.clID
    where cl.ffID = $ffID AND cl.Aid = $Aid;*/
    --
    DELETE FROM slDeal WHERE Aid = $Aid AND dcID IN (SELECT dcID FROM dcDoc WHERE Aid = $Aid AND ffID = $ffID);
      /*inner join dcDoc d on d.dcID = c.dcID
      inner join crmClient cl on cl.clID = d.clID
    where cl.ffID = $ffID AND cl.Aid = $Aid;*/
    --
    DELETE FROM ccContact WHERE ffID = $ffID AND Aid = $Aid;
      /*inner join dcDoc d on d.dcID = c.dcID
      inner join crmClient cl on cl.clID = d.clID
    where cl.ffID = $ffID AND cl.Aid = $Aid;*/
    --
    DELETE FROM fmFormItem WHERE Aid = $Aid AND dcID IN (SELECT dcID FROM dcDoc WHERE Aid = $Aid AND ffID = $ffID);
      /*inner join dcDoc d on d.dcID = c.dcID
      inner join crmClient cl on cl.clID = d.clID
    where cl.ffID = $ffID AND cl.Aid = $Aid;*/
    --
    DELETE FROM fmForm WHERE Aid = $Aid AND dcID IN (SELECT dcID FROM dcDoc WHERE Aid = $Aid AND ffID = $ffID);
      /*inner join dcDoc d on d.dcID = c.dcID
      inner join crmClient cl on cl.clID = d.clID
    where cl.ffID = $ffID AND cl.Aid = $Aid;*/
    --
    DELETE FROM dcDoc WHERE Aid = $Aid AND ffID = $ffID;
      /*inner join crmClient cl on cl.clID = d.clID
    where cl.ffID = $ffID AND cl.Aid = $Aid;*/
    --
    DELETE FROM crmContact WHERE Aid = $Aid AND ffID = $ffID;
    /*  inner join crmClient cl on cl.clID = cc.clID
    where cl.ffID = $ffID AND cl.Aid = $Aid;*/
    --
    DELETE FROM crmAddress WHERE Aid = $Aid AND clID IN (SELECT clID FROM crmClient WHERE Aid = $Aid AND ffID = $ffID);
      /*inner join crmClient cl on cl.clID = cc.clID
    where cl.ffID = $ffID AND cl.Aid = $Aid;*/
    --
    /*delete cc
    from crmRegion cc
      inner join crmClient cl on cl.clID = cc.clID
    where cl.ffID = $ffID AND cl.Aid = $Aid;*/
    --
    DELETE FROM crmStatus WHERE Aid = $Aid AND ffID = $ffID;
      /*inner join crmClient cl on cl.clID = cc.clID
    where cl.ffID = $ffID AND cl.Aid = $Aid;*/
    --
    DELETE FROM crmTagList WHERE Aid = $Aid AND clID IN (SELECT clID FROM crmClient WHERE Aid = $Aid AND ffID = $ffID);
      /*inner join crmClient cl on cl.clID = cc.clID
    where cl.ffID = $ffID AND cl.Aid = $Aid;*/
    --
    DELETE FROM crmClientEx WHERE Aid = $Aid AND ffID = $ffID;
      /*inner join crmClient cl on cl.clID = cc.clID
    where cl.ffID = $ffID AND cl.Aid = $Aid;*/
    --
    DELETE FROM crmOrg WHERE Aid = $Aid AND clID IN (SELECT clID FROM crmClient WHERE Aid = $Aid AND ffID = $ffID);
      /*inner join crmClient cl on cl.clID = cc.clID
    where cl.ffID = $ffID AND cl.Aid = $Aid;*/
    --
    DELETE FROM crmClient WHERE ffID = $ffID AND Aid = $Aid;
    --
    UPDATE fmFormType SET
      ffID = NULL
    WHERE ffID = $ffID AND Aid = $Aid;
    --
    DELETE FROM fsFile WHERE ffID = $ffID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
