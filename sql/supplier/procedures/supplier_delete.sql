##  DELETE Supplier Procedure
--
--  Parameters:
--    id: INT
--
--  Example Usage:
--    supplier_delete(1);

DROP PROCEDURE IF EXISTS supplier_delete;

DELIMITER //

CREATE PROCEDURE supplier_delete(IN inId INT)
  BEGIN
    DELETE FROM Supplier WHERE Supplier.id = inId;
  END

//

DELIMITER ;