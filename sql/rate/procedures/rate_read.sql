##  READ Rate Procedure
--
--  Parameters:
--    id: INT, optional
--
--  Example Usage:
--    rate_read(NULL); // Returns all rates
--    rate_read(1); // Returns rate with ID = 1

DROP PROCEDURE IF EXISTS rate_read;

DELIMITER //

CREATE PROCEDURE rate_read(IN inId INT)
  BEGIN
    IF inId IS NULL
    THEN
      SELECT
        Rate.id   AS 'ID',
        Rate.rate AS 'Daily Rate'
      FROM Rate
      WHERE 1;
    ELSE
      SELECT
        Rate.id   AS 'ID',
        Rate.rate AS 'Daily Rate'
      FROM Rate
      WHERE Rate.id = inId;
    END IF;
  END

//

DELIMITER ;
