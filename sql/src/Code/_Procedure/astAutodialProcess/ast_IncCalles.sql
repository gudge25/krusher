DELIMITER $$
DROP PROCEDURE IF EXISTS ast_IncCalles;
CREATE PROCEDURE ast_IncCalles(
    $Aid                INT(11)
    , $id_autodial      INT(11)
) DETERMINISTIC MODIFIES SQL DATA
BEGIN
  SET $id_autodial = IFNULL($id_autodial, 0);
  --
  IF ($id_autodial > 0) THEN
    UPDATE ast_autodial_process SET
      called = called + 1
    WHERE id_autodial = $id_autodial AND Aid = $Aid;
  END IF;
END $$
DELIMITER ;
--
