##  DELETE Actor Procedure
--
--  Parameters:
--    id: INT
--
--  Example Usage:
--    actor_delete(1);

DROP PROCEDURE IF EXISTS actor_delete;

DELIMITER //

CREATE PROCEDURE actor_delete(IN inId INT)
  BEGIN
    DELETE FROM Actor WHERE Actor.id = inId;
  END

//

DELIMITER ;
