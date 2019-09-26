DROP PROCEDURE IF EXISTS cc_InsContactStat;
DELIMITER $$
CREATE PROCEDURE cc_InsContactStat(
    $Aid            INT
    , $ccName       VARCHAR(50)
    , $IsOut        BIT
    , $disposition  VARCHAR(45)
    , $isAutocall   BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $CurDate          VARCHAR(25);
  --
  IF ($Aid < 1) THEN
    call RAISE(77068, 'cc_InsContactStat');
  ELSE
    SET $CurDate = CONCAT(SUBSTRING(NOW(), 1, 13), ':00:00');
    --
    UPDATE ccContactStat SET
      calls             = IF($disposition = 'RINGING', calls + 1, calls)
      , callsAutocall   = IF($disposition = 'RINGING' AND $isAutocall IS TRUE, callsAutocall + 1, callsAutocall)
      , callsOut        = IF($disposition = 'RINGING' AND $IsOut IS TRUE, callsOut + 1, callsOut)
      , callsIn         = IF($disposition = 'RINGING' AND $IsOut IS NOT TRUE, callsIn + 1, callsIn)
      , callsRinging    = IF($disposition = 'RINGING', callsRinging+1, callsRinging)
      , callsUp         = IF($disposition = 'UP', callsUp+1, callsUp)
      , callsAnswered   = IF($disposition = 'ANSWERED', callsAnswered+1, callsAnswered)
      , callsNoanswered = IF($disposition = 'NO ANSWER', callsNoanswered+1, callsNoanswered)
      , callsBusy       = IF($disposition = 'BUSY', callsBusy+1, callsBusy)
      , callsFailed     = IF($disposition = 'FAILED', callsFailed+1, callsFailed)
      , callsCongestion = IF($disposition = 'CONGESTION', callsCongestion+1, callsCongestion)
    WHERE ccName LIKE CONCAT('%', $ccName) AND Aid = $Aid AND callsDate = $CurDate;
    --
    IF(ROW_COUNT() = 0)THEN
      INSERT INTO ccContactStat (HIID
                                , Aid
                                , ccName
                                , callsDate
                                , calls
                                , callsAutocall
                                , callsOut
                                , callsIn
                                , callsRinging
                                , callsUp
                                , callsAnswered
                                , callsNoanswered
                                , callsBusy
                                , callsFailed
                                , callsCongestion)
                VALUES
                                (fn_GetStamp()
                                , $Aid
                                , $ccName
                                , $CurDate
                                , 1
                                , IF($isAutocall IS TRUE, 1, 0)
                                , IF($IsOut IS TRUE, 1, 0)
                                , IF($IsOut IS NOT TRUE, 1, 0)
                                , IF($disposition = 'RINGING', 1, 0)
                                , IF($disposition = 'UP', 1, 0)
                                , IF($disposition = 'ANSWERED', 1, 0)
                                , IF($disposition = 'NO ANSWER', 1, 0)
                                , IF($disposition = 'BUSY', 1, 0)
                                , IF($disposition = 'FAILED', 1, 0)
                                , IF($disposition = 'CONGESTION', 1, 0)
      );
    END IF;
  END IF;
END $$
DELIMITER ;
--
