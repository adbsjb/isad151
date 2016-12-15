##  CREATE Rate Procedure
--
--  Parameters:
--    rate: FLOAT
--
--  Example Usage:
--    rate_create(7.50);

DROP PROCEDURE IF EXISTS rate_create;

DELIMITER //

CREATE PROCEDURE rate_create(IN inRate FLOAT)
  BEGIN
    INSERT INTO Rate (rate) VALUES (inRate);
  END

//

DELIMITER ;
