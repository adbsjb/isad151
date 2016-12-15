##  READ Actor Procedure
--
--  Parameters:
--    id: INT, optional
--
--  Example Usage:
--    actor_read(NULL); // Returns all actors
--    actor_read(1); // Returns actor with ID = 1

DROP PROCEDURE IF EXISTS actor_read;

DELIMITER //

CREATE PROCEDURE actor_read(IN inId INT)
  BEGIN
    IF inId IS NULL
    THEN
      SELECT
        Actor.id   AS 'ID',
        Actor.name AS 'Actor Name',
        Actor.biography AS 'Actor Biography'
      FROM Actor
      WHERE 1;
    ELSE
      SELECT
        Actor.id   AS 'ID',
        Actor.name AS 'Actor Name',
        Actor.biography AS 'Actor Biography'
      FROM Actor
      WHERE Actor.id = inId;
    END IF;
  END

//

DELIMITER ;
