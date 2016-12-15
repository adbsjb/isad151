##  READ Supplier Procedure
--
--  Parameters:
--    id: INT, optional
--
--  Example Usage:
--    supplier_delete(NULL); // Returns all suppliers
--    supplier_delete(1); // Returns supplier with ID = 1

DROP PROCEDURE IF EXISTS supplier_read;

DELIMITER //

CREATE PROCEDURE supplier_read(IN inId INT)
  BEGIN
    IF inId IS NULL
    THEN
      SELECT
        Supplier.id   AS 'ID',
        Supplier.name AS 'Supplier Name'
      FROM Supplier
      WHERE 1;
    ELSE
      SELECT
        Supplier.id   AS 'ID',
        Supplier.name AS 'Supplier Name'
      FROM Supplier
      WHERE Supplier.id = inId;
    END IF;
  END

//

DELIMITER ;