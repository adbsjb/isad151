##  UPDATE Supplier Procedure
--
--  Parameters:
--    id:   INT
--    name: VARCHAR(100)
--
--  Example Usage:
--    supplier_update(1, 'Amazon');

DROP PROCEDURE IF EXISTS supplier_update;

DELIMITER //

CREATE PROCEDURE supplier_update(IN inId INT, IN inName VARCHAR(100))
  BEGIN
    UPDATE Supplier
    SET Supplier.name = inName
    WHERE Supplier.id = inId;
  END

//

DELIMITER ;