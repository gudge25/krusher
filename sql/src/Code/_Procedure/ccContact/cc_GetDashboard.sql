DROP PROCEDURE IF EXISTS cc_GetDashboard;
DELIMITER $$
CREATE PROCEDURE cc_GetDashboard(
    $token          VARCHAR(100)
)
BEGIN
  DECLARE $CurDate                      DATETIME;
  DECLARE $TotalCallsAutocall           INT;
  DECLARE $QtyClientsSuccessAutocall    INT;
  DECLARE $QtyClientsUnSuccessAutocall  INT;
  DECLARE $QtyClientsMissedAutocall     INT;
  DECLARE $TotalCallsAll                INT;
  DECLARE $QtyClientsSuccessAll         INT;
  DECLARE $QtyClientsUnSuccessAll       INT;
  DECLARE $QtyClientsMissedAll          INT;
  DECLARE $Aid                          INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'cc_GetDashboard');
  ELSE
    --
    SET $CurDate = DATE_FORMAT(NOW(), "%Y-%c-%d 00:00:00");
    --
    SELECT
      COUNT(*) INTO $TotalCallsAutocall
    FROM ccContact
    WHERE Created>$CurDate
          AND Aid = $Aid
          AND clID>0;
    --
    SELECT
      COUNT(*) INTO $QtyClientsSuccessAutocall
    FROM ccContact
    WHERE Created>$CurDate
          AND Aid = $Aid
          AND clID > 0
          AND ccStatus=7001
          AND CallType != 101320;
    --
    SELECT
      COUNT(*) INTO $QtyClientsUnSuccessAutocall
    FROM ccContact
    WHERE Created>$CurDate
          AND Aid = $Aid
          AND clID > 0
          AND ccStatus!=7001
          AND CallType != 101320;
    --
    SELECT
      COUNT(*) INTO $QtyClientsMissedAutocall
    FROM ccContact
    WHERE Created>$CurDate
          AND Aid = $Aid
          AND clID > 0
          AND IsOut = FALSE
          AND IsMissed=TRUE
          AND CallType != 101320;
    --
    SELECT
      COUNT(*) INTO $TotalCallsAll
    FROM ccContact
    WHERE Created>$CurDate
          AND Aid = $Aid
          AND CallType != 101320;
    --
    SELECT
      COUNT(*) INTO $QtyClientsSuccessAll
    FROM ccContact
    WHERE Created>$CurDate
          AND Aid = $Aid
          AND ccStatus=7001
          AND CallType != 101320;
    --
    SELECT
      COUNT(*) INTO $QtyClientsUnSuccessAll
    FROM ccContact
    WHERE Created>$CurDate
          AND Aid = $Aid
          AND ccStatus!=7001
          AND CallType != 101320;
    --
    SELECT count(f)
    INTO $QtyClientsMissedAll
    FROM (SELECT
      COUNT(*)  f
    FROM ccContact
    WHERE Created>$CurDate
          AND Aid = $Aid
          AND IsOut = FALSE
          AND IsMissed = TRUE
          AND CallType != 101320
	  GROUP BY ccName)aa;
    --
    SELECT a.ID
          , a.Name
          , a.QtyCalls
          , a.Percent
          , a.SuccesCalls
          , a.data1
          , a.data2
          , a.data3
     FROM (
    SELECT
      1                                     ID
      , 'TotalCallsAutocall'                Name
      , $TotalCallsAutocall                 QtyCalls
      , 1                                   Percent #, ROUND($TotalCalls / $QtyClients, 2) Percent
      , NULL                                SuccesCalls
      , NULL                                data1
      , NULL                                data2
      , NULL                                data3
    UNION ALL
    SELECT
      1
      , 'AnsweredAutocall'
      , $QtyClientsSuccessAutocall
      , ROUND(((100/$TotalCallsAutocall) * $QtyClientsSuccessAutocall)/100, 2)
      , NULL
      , NULL
      , NULL
      , NULL
    UNION ALL
    SELECT
      1
      , 'NoAnsweredAutocall'
      , $QtyClientsUnSuccessAutocall
      , ROUND(((100/$TotalCallsAutocall) * $QtyClientsUnSuccessAutocall)/100, 2)
      , NULL
      , NULL
      , NULL
      , NULL
    UNION ALL
    SELECT
      1
      , 'MissedAutocall'
      , $QtyClientsMissedAutocall
      , ROUND(((100/$TotalCallsAutocall) * $QtyClientsMissedAutocall)/100, 2)
      , NULL
      , NULL
      , NULL
      , NULL
    UNION ALL
    SELECT
      2
      , 'TotalCallsAll'
      , $TotalCallsAll
      , 1
      , NULL
      , NULL
      , NULL
      , NULL
    UNION ALL
    SELECT
      2
      , 'AnsweredAll'
      , $QtyClientsSuccessAll
      , ROUND(((100/$TotalCallsAll) * $QtyClientsSuccessAll)/100, 2)
      , NULL
      , NULL
      , NULL
      , NULL
    UNION ALL
    SELECT
      2
      , 'NoAnsweredAll'
      , $QtyClientsUnSuccessAll
      , ROUND(((100/$TotalCallsAll) * $QtyClientsUnSuccessAll)/100, 2)
      , NULL
      , NULL
      , NULL
      , NULL
    UNION ALL
    SELECT
      2
      , 'MissedAll'
      , $QtyClientsMissedAll
      , ROUND(((100/$TotalCallsAll) * $QtyClientsMissedAll)/100, 2)
      , NULL
      , NULL
      , NULL
      , NULL
    UNION ALL
    SELECT
      3
      , HOUR(Created) hourTime
      , count(*)
      , NULL
      , NULL
      , NULL
      , NULL
      , NULL
    FROM ccContact
    WHERE Created>$CurDate AND Aid = $Aid AND CallType != 101320
    GROUP BY hourTime
    UNION ALL
    SELECT
      5
      , HOUR(Created) hourTime
      , count(*)
      , NULL
      , NULL
      , NULL
      , NULL
      , NULL
    FROM ccContact
    WHERE Created>$CurDate AND clID>0 AND Aid = $Aid AND CallType != 101320
    GROUP BY hourTime
    UNION ALL
    (SELECT
      6
      , f.ffName					                                            ffName
      , f.clients_count  		                                          allContacts
      , ROUND((
              (100/(f.clients_count-f.trash_count))*
             (SELECT count(*) FROM crmStatus WHERE ffID=f.ffID AND ccStatus=202 AND Aid = $Aid)
            )/100, 2) 			                                        allCallsPercent
      , ROUND((SELECT count(*) FROM crmStatus WHERE ffID=f.ffID AND ccStatus=202 AND Aid = $Aid), 2)      successCalls
      , f.ffID
      , f.dbID
      , IF(f.dbID IS NOT NULL, (SELECT dbName FROM fsBase WHERE dbID=f.dbID AND Aid = $Aid), '')
    FROM fsFile f
    WHERE f.ffID>0 AND f.isActive = true AND f.Aid = $Aid
    /*GROUP BY f.ffID*/
    ORDER BY f.Created DESC)) a
    ORDER BY a.ID, a.data1 DESC;
  END IF;
END $$
DELIMITER ;
--
