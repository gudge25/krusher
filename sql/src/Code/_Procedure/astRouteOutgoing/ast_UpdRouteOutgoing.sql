  DELIMITER $$
  DROP PROCEDURE IF EXISTS ast_UpdRouteOutgoing;
  CREATE PROCEDURE ast_UpdRouteOutgoing(
      $HIID             BIGINT
      , $token          VARCHAR(100)
      , $roID           INT(11)
      , $roName         VARCHAR(50)
      , $destination    INT(11)
      , $destdata       INT(11)
      , $destdata2      VARCHAR(100)
      , $category       INT(11)
      ,	$prepend        VARCHAR(50)
      , $prefix         VARCHAR(50)
      , $callerID       VARCHAR(50)
      , $priority       INT(11)
      , $coID           INT(11)
      , $isActive       BIT
  ) DETERMINISTIC MODIFIES SQL DATA
  BEGIN
    DECLARE $Aid            INT;
    DECLARE $idG            INT;
    --
    SET $token = NULLIF(TRIM($token), '');
    SET $Aid = fn_GetAccountID($token);
    IF ($Aid = -999) THEN
      call RAISE(77068, 'ast_InsRouteOutgoing');
    ELSE
      if not exists (
        select 1
        from ast_route_outgoing
        where HIID = $HIID
          and roID = $roID
          AND Aid = $Aid) then
        -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
        call RAISE(77003, NULL);
      end if;
      --
      if NULLIF(TRIM($roName), '') is NULL OR $roName IS NULL then
        call raise(77117, NULL);
      end if;
      --
      UPDATE ast_route_outgoing SET
        roName          = $roName
        , destination   = $destination
        , destdata      = $destdata
        , destdata2     = $destdata2
        , category      = $category
        , callerID      = $callerID
        , isActive      = $isActive
        , HIID          = fn_GetStamp()
        , priority      = $priority
        , prepend       = $prepend
        , prefix        = $prefix
        /*, coID          = IF($destination = 101403, (SELECT coID FROM ast_trunk WHERE trID = $destdata AND Aid = $Aid), (IF($destination = 101409,(SELECT coID FROM ast_pools WHERE poolID = $destdata AND Aid = $Aid), NULL)))*/
        , coID          = IF($destination = 101409,(SELECT coID FROM ast_pools WHERE poolID = $destdata AND Aid = $Aid), NULL)
      WHERE roID = $roID AND Aid = $Aid;
    END IF;
  END $$
  DELIMITER ;
  --
