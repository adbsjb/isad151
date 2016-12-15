##  CREATE Actor Procedure
--
--  Parameters:
--    name:       VARCHAR(60)
--    biography:  LONGTEXT
--
--  Example Usage:
--    actor_create('Mads Mikkelsen', 'This could be a biography.');

DROP PROCEDURE IF EXISTS actor_create;

DELIMITER //

CREATE PROCEDURE actor_create(IN inName VARCHAR(60), IN inBiography LONGTEXT)
  BEGIN
    INSERT INTO Actor (name, biography) VALUES (inName, inBiography);
  END

//

DELIMITER ;
