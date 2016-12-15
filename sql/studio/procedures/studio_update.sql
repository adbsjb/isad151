##  UPDATE Studio Procedure
--
--  Parameters:
--    id:   INT
--    name: VARCHAR(45)
--
--  Example Usage:
--    studio_update(1, 'Twentieth Century Fox');

DROP PROCEDURE IF EXISTS studio_update;

DELIMITER //

CREATE PROCEDURE studio_update(IN inId INT, IN inName VARCHAR(45))
  BEGIN
    UPDATE Studio
    SET Studio.name = inName
    WHERE Studio.id = inId;
  END

//

DELIMITER ;
