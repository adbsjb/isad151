##  UPDATE Rate Procedure
--
--  Parameters:
--    id: INT
--    rate: FLOAT
--
--  Example Usage:
--    rate_update(1, 5.50);

DROP PROCEDURE IF EXISTS rate_update;

DELIMITER //

CREATE PROCEDURE rate_update(IN inId INT, IN inRate FLOAT)
  BEGIN
    UPDATE Rate
    SET Rate.rate = inRate
    WHERE Rate.id = inId;
  END

//

DELIMITER ;
