DELIMITER $$
DROP PROCEDURE IF EXISTS dc_IPDelDoc;
CREATE PROCEDURE dc_IPDelDoc(
    $Aid          INT
    , $dcID       int
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  IF ($Aid < 1) THEN
    call RAISE(77068, 'dc_IPDelDoc');
  ELSE
    if $dcID is NULL then
      -- Параметр ID документа должен иметь значение;
      call raise(77001, NULL);
    end if;
    --
    delete from dcDoc
    where dcID = $dcID AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
