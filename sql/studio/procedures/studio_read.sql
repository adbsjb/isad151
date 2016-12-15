##  READ Studio Procedure
--
--  Parameters:
--    id: INT, optional
--
--  Example Usage:
--    studio_read(NULL); // Returns all studios
--    studio_read(1); // Returns studio with ID = 1

DROP PROCEDURE IF EXISTS studio_read;

DELIMITER //

CREATE PROCEDURE studio_read(IN inId INT)
  BEGIN
    IF inId IS NULL
    THEN
      SELECT
        Studio.id   AS 'ID',
        Studio.name AS 'Studio Name'
      FROM Studio
      WHERE 1;
    ELSE
      SELECT
        Studio.id   AS 'ID',
        Studio.name AS 'Studio Name'
      FROM Studio
      WHERE Studio.id = inId;
    END IF;
  END

//

DELIMITER ;
