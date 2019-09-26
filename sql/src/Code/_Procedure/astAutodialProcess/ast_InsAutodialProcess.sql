DELIMITER $$
DROP PROCEDURE IF EXISTS ast_InsAutodialProcess;
CREATE PROCEDURE ast_InsAutodialProcess(
    $token              VARCHAR(100)
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
)DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $count_go       INT;
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_InsAutodialProcess');
  ELSE
    SELECT count(*)
    INTO $count_go
    FROM ast_autodial_process
    WHERE Aid = $Aid AND
          ffID = $ffID AND
          id_scenario = $id_scenario AND
          `process` = $process;
    IF($planDateBegin IS NULL) THEN
      SET $planDateBegin = NOW();
    END IF;
    --
    IF($count_go = 0)THEN
      INSERT INTO ast_autodial_process (
        id_autodial,
        `process`,
        ffID,
        id_scenario,
        emID,
        Aid,
        factor,
        called,
        targetCalls,
        planDateBegin,
        errorDescription,
        description,
        isActive,
        HIID
      )
      VALUES (
        $id_autodial,
        $process,
        $ffID,
        $id_scenario,
        $emID,
        $Aid,
        $factor,
        IF($called IS NULL, 0, $called),
        $targetCalls,
        $planDateBegin,
        $errorDescription,
        $description,
        $isActive,
        fn_GetStamp()
      );
    ELSE
      call raise(77100, NULL);
    END IF;
  END IF;
    --
END $$
DELIMITER ;
--
