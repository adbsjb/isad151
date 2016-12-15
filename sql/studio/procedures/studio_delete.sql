##  DELETE Studio Procedure
--
--  Parameters:
--    id: INT
--
--  Example Usage:
--    studio_delete(1);

DROP PROCEDURE IF EXISTS studio_delete;

DELIMITER //

CREATE PROCEDURE studio_delete(IN inId INT)
  BEGIN
    DELETE FROM Studio WHERE Studio.id = inId;
  END

//

DELIMITER ;
