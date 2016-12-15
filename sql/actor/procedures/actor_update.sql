##  UPDATE Actor Procedure
--
--  Parameters:
--    id: INT
--    name:       VARCHAR(60)
--    biography:  LONGTEXT
--
--  Example Usage:
--    actor_update(1, 'Matt Damon', 'The one true martian.');

DROP PROCEDURE IF EXISTS actor_update;

DELIMITER //

CREATE PROCEDURE actor_update(IN inId INT, IN inName VARCHAR(60), inBiography LONGTEXT)
  BEGIN
    UPDATE Actor
    SET
      Actor.name      = inName,
      Actor.biography = inBiography
    WHERE Actor.id = inId;
  END

//

DELIMITER ;
