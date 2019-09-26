DELIMITER $$
DROP PROCEDURE IF EXISTS ast_UpdCustomDestination;
CREATE PROCEDURE ast_UpdCustomDestination(
    $token                          VARCHAR(100)
    , $HIID                         BIGINT
    , $cdID                         INT(11)
    , $cdName                       VARCHAR(50)
    , $context                      VARCHAR(250)
    , $exten                        VARCHAR(50)
    , $description                  VARCHAR(250)
    , $notes                        TEXT
    , $return                       BIT
    , $destination                  INT(11)
    , $destdata                     INT(11)
    , $destdata2                    VARCHAR(100)
    , $priority                     INT(11)
    , $isActive                     BIT
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  DECLARE $Aid            INT;
  --
  SET $token = NULLIF(TRIM($token), '');
  SET $Aid = fn_GetAccountID($token);
  IF ($Aid = -999) THEN
    call RAISE(77068, 'ast_UpdCustomDestination');
  ELSE
    if not exists (
      select 1
      from ast_custom_destination
      where HIID = $HIID
        and cdID = $cdID
        AND Aid = $Aid) then
      -- Запиcь была изменена другим пользователем. Обновите документ без сохраненис и выполните действия еще раз.
      call RAISE(77003, NULL);
    end if;
    --
    UPDATE ast_custom_destination SET
      description               = $description
      , notes                   = $notes
      , `return`                = IF($return = TRUE, 1, 0)
      , destination             = $destination
      , destdata                = $destdata
      , destdata2               = $destdata2
      , isActive                = $isActive
      , HIID                    = fn_GetStamp()
      , cdName                  = $cdName
      , context                 = $context
      , exten                   = $exten
      , priority                = $priority
    WHERE cdID = $cdID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
