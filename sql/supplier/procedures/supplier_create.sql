##  CREATE Supplier Procedure
--
--  Parameters:
--    name: VARCHAR(100)
--
--  Example Usage:
--    supplier_create('Amazon');

DROP PROCEDURE IF EXISTS supplier_create;

DELIMITER //

CREATE PROCEDURE supplier_create(IN inName VARCHAR(100))
  BEGIN
    INSERT INTO Supplier (name) VALUES (inName);
  END

//

DELIMITER ;