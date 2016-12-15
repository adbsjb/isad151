##  DELETE Rate Procedure
--
--  Parameters:
--    id: INT
--
--  Example Usage:
--    rate_delete(1);

DROP PROCEDURE IF EXISTS rate_delete;

DELIMITER //

CREATE PROCEDURE rate_delete(IN inId INT)
  BEGIN
    DELETE FROM Rate WHERE Rate.id = inId;
  END

//

DELIMITER ;
