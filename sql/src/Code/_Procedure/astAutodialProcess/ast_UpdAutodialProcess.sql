DELIMITER $$
DROP PROCEDURE IF EXISTS ast_UpdAutodialProcess;
CREATE PROCEDURE ast_UpdAutodialProcess(
     $HIID              BIGINT
    , $token            VARCHAR(100)
    , $id_autodial      INT(11)
    , $process          INT(11)
    , $ffID             INT(11)
    , $id_scenario      INT(11)
    , $emID             INT(11)
    , $factor           INT(11)
    , $called           INT(11)
    , $targetCalls      INT(11)
    , $planDateBegin    DATETIME
    , $errorDescription VARCHAR(500)
    , $description      VARCHAR(500)
    , $isActive         BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_UpdAutodialProcess');
  ELSEIF($Aid = 0) THEN
    --
    UPDATE ast_autodial_process SET
      `process`         = $process,
      ffID              = $ffID,
      id_scenario       = $id_scenario,
      emID              = $emID,
      factor            = $factor,
      called            = $called,
      targetCalls       = $targetCalls,
      errorDescription  = $errorDescription,
      description       = $description,
      isActive          = $isActive,
      HIID              = fn_GetStamp(),
      planDateBegin     = $planDateBegin
    WHERE id_autodial = $id_autodial;
  ELSE
    --
    UPDATE ast_autodial_process SET
      `process`         = $process,
      ffID              = $ffID,
      id_scenario       = $id_scenario,
      emID              = $emID,
      factor            = $factor,
      called            = $called,
      targetCalls       = $targetCalls,
      errorDescription  = $errorDescription,
      description       = $description,
      isActive          = $isActive,
      HIID              = fn_GetStamp(),
      planDateBegin     = $planDateBegin
    WHERE id_autodial = $id_autodial AND Aid = $Aid;
  END IF;
  /*IF($process != 101602) THEN
  IF(SELECT COUNT(1)
                              FROM INFORMATION_SCHEMA.COLUMNS
                              WHERE TABLE_SCHEMA = 'krusher' AND table_name = 'AutoCall_data_procedure'
                             ) > 0 THEN
      DELETE FROM AutoCall_data_procedure WHERE id_autodial NOT IN (SELECT id_autodial FROM ast_autodial_process WHERE `process`=101602);
    END IF;
  END IF;*/
END $$
DELIMITER ;
--
