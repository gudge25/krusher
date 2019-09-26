DELIMITER $$
DROP PROCEDURE IF EXISTS ast_UpdCdrComment;
CREATE PROCEDURE ast_UpdCdrComment(
   $uniqueid varchar(32)
  ,$comment  varchar(260)
) BEGIN
  update cdr set
    comment = $comment
  where uniqueid = $uniqueid;
END $$
DELIMITER ;
--


