##  CREATE Studio Procedure
--
--  Parameters:
--    name: VARCHAR(45)
--
--  Example Usage:
--    studio_create('Paramount Pictures');

DROP PROCEDURE IF EXISTS studio_create;

DELIMITER //

CREATE PROCEDURE studio_create(IN inName VARCHAR(45))
  BEGIN
    INSERT INTO Studio (name) VALUES (inName);
  END

//

DELIMITER ;
