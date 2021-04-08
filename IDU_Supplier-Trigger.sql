--Creating a trigger for updates, deletes and inserts
IF EXISTS (SELECT name FROM sysobjects
		WHERE name = 'IDU_supplier' AND type = 'TR')
DROP TRIGGER IDU_supplier
GO
CREATE TRIGGER IDU_supplier
ON Tb_Supplier
FOR INSERT,DELETE,UPDATE AS
IF EXISTS(SELECT * FROM deleted) AND EXISTS(SELECT * FROM inserted)
	PRINT 'Supplier successfully updated!'
ELSE
	IF NOT EXISTS(SELECT * FROM deleted)
		PRINT 'Supplier successfully inserted!'
	ELSE
		PRINT 'Supplier successfully deleted!'
GO

INSERT Tb_Supplier Values('Tr1','City', 'ST1')
UPDATE Tb_Supplier SET Name='XYZ'WHERE Name='Tr1'
DELETE Tb_Supplier WHERE Name='XYZ'