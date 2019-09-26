DELIMITER $$
DROP PROCEDURE IF EXISTS ast_DelTrunk;
CREATE PROCEDURE ast_DelTrunk(
    $token          VARCHAR(100)
    , $trID         INT
)
BEGIN
  DECLARE $Aid            INT;
  DECLARE $coID1            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_DelTrunk');
  ELSE
    SELECT coID
    INTO $coID1
    FROM ast_trunk
    WHERE trID = $trID AND Aid = $Aid
    LIMIT 1;
    --
    IF($coID1 IS NOT NULL AND $coID1 > 0)THEN
      DELETE FROM ast_pool_list
      WHERE trID = $trID AND Aid = $Aid;
      DELETE FROM ast_pools
      WHERE coID = $coID1 AND Aid = $Aid AND poolID NOT IN (SELECT poolID FROM ast_pool_list WHERE Aid = $Aid);
      DELETE FROM ast_route_outgoing
      WHERE coID = $coID1 AND Aid = $Aid AND destination NOT IN (SELECT poolID FROM ast_pools WHERE Aid = $Aid);
    ELSE
      DELETE FROM ast_pool_list
      WHERE trID = $trID AND Aid = $Aid;
    END IF;
    DELETE FROM ast_trunk
    WHERE trID = $trID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
