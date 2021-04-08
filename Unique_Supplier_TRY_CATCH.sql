IF EXISTS (SELECT name FROM sysobjects WHERE name = 'Unique_supplier' AND type = 'TR')
DROP TRIGGER Unique_supplier
GO
	
CREATE TRIGGER Unique_supplier
ON Tb_Supplier
FOR INSERT, UPDATE AS
IF EXISTS(SELECT * FROM Tb_Supplier,inserted
		  WHERE Tb_Supplier.Supp_ID<>inserted.Supp_ID
		      AND Tb_Supplier.Name=inserted.Name)
BEGIN;					-- if there is another supplier with the same name
	--RAISERROR ('There is already a supplier with this name!', 16, 1)
	THROW 50009, 'There is already a supplier with this name!', 1
	ROLLBACK TRANSACTION	-- cancel supplier insertion
END
ELSE
	PRINT 'Supplier successfully inserted!'
GO

--test statements
INSERT Tb_Supplier VALUES('TriggerTest', 'TriggerTestCity', 'TriggerTestCityState')

DELETE Tb_Supplier WHERE Name='TriggerTest'

UPDATE Tb_Supplier
SET Name='Joe'
WHERE Name<>'Joe'