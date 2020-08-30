/**
This trigger will ensure that a row has the last name value if the fullname is provided.
This example is an AFTER INSERT trigger, which means that it is invoked after the data has 
been inserted into the table.

Test script:
select * from tblPersonNames;
--Test lastname is not provided
Insert into tblPersonNames (FullName) values ('Kyle Westminster');
Insert into tblPersonNames (FullName) values ('Jackson, Liam');
--Test the provided lastname matches the extracted lastname from the fullname
Insert into tblPersonNames (FullName, LastName) values ('Jack London', 'London');
--Test the provided lastname does not match the extracted lastname from the fullname
Insert into tblPersonNames (FullName, LastName) values ('Hemingway, Ernest', 'Hemingwey');

*/
CREATE TRIGGER dbo.utrLastnameAfterInsertTblPersonNames ON tblPersonNames AFTER INSERT
AS
BEGIN
--Declare the local variables: @ln varchar(50), @lnExtracted varchar(50), @fullname varchar(100);
DECLARE @ln varchar(50) = '', @lnExtracted varchar(50) = '', @fullname varchar(100) ='';
	
--Declare the local variable: @pid int;
DECLARE @pid int = 0;
	
--Get inserted values from inserted
SELECT @ln = LastName, @fullname = FullName FROM inserted;

	--Check if Fullname is provided:
	IF @fullname is not null
	BEGIN
		--If the fullname is provided
	
		--Check if lastname is provided:
		IF @ln is not null
		BEGIN
			--If the lastname is provided
			--Extract the lastname from the fullname
			SET @lnExtracted = dbo.ufnGetLastName(@fullname);
			--If the provided lastname does not match the extracted lastname,
			IF @ln != @lnExtracted
			BEGIN
				--we update the LastName column with the extracted lastname
				--@@IDENTITY contains id of newly inserted feild
				SET @pid = @@IDENTITY;
				
				PRINT 'The lastnames do not match, using the last name from the fullname.';
				UPDATE tblPersonNames SET LastName=@lnExtracted WHERE PersonID = @pid;
				PRINT @fullname + '''s last name has been updated';
			END
			ELSE
			BEGIN
				--If the provided lastname matches the extracted lastname, we just print a message
				PRINT 'The lastnames match';
			END
		END
		ELSE 
		BEGIN
			--If the lastname is not provided:
			--extract the lastname from the fullname and update the LastName column of the row
			SET @lnExtracted = dbo.ufnGetLastName(@fullname);
			SET @pid = @@IDENTITY; 
			UPDATE tblPersonNames SET LastName = @lnExtracted where PersonID = @pid;
			PRINT 'Lastname is not provided, lastname feild updated';
		END
	
	END
	ELSE
	BEGIN
		--If the fullname is not provided, we just print a message
		PRINT 'Fullname is not provided, we cannot do anything';
	END	

END