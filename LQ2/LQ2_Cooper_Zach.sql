-- MIS 421 Lab Quiz 2
-- Zach Cooper

-- Create tblWood
CREATE TABLE tblWood (
	WoodID		int				NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Name		nvarchar(250)	NULL,
	Description TEXT			NULL,
);

-- create tblProduct
CREATE TABLE tblProduct (
	ProductID	int				NOT NULL IDENTITY(1,1) PRIMARY KEY,
	WoodID		int				NULL,
	Name		nvarchar(250)	NULL,
	Price		DECIMAL			NULL,
	Description	TEXT			NULL,
	ProductType Char(1)			NOT NULL,
	Constraint tblProductProductTypeCheck Check (ProductType = 'F' or ProductType = 'A'),
	Constraint tblProductProductAK Unique (ProductID, ProductType),
	Constraint tblProductFK Foreign Key (WoodID)
	References tblWood (WoodID)
	on update no action
	on delete no action
);

--Create tblFurniture
CREATE Table tblFurniture (
	ProductID	int				NOT NULL PRIMARY KEY,
	Length		int				NULL,
	Width		int				NULL,
	Height		int				NULL,
	ProductType char(1)			NULL Default 'F',
	Constraint tblFurnitureProductTypeCheck Check (ProductType = 'F'),
	Constraint tblFurnitureFK Foreign Key (ProductID, ProductType)
	References tblProduct (ProductID, ProductType)
	on update no action
	on delete no action,
);

--Create tblAccessory
CREATE TABLE tblAccessory (
	ProductID			int				NOT NULL PRIMARY KEY,
	isTableAccessory	bit				null,
	ProductType			char(1)			null Default 'A',
	Constraint tblAccessoryProductTypeCheck Check (ProductType = 'A'),
	Constraint tblAccessoryFK Foreign Key (ProductID, ProductType)
	References tblProduct (ProductID, ProductType)
	on update no action
	on delete no action
);


-- insert data from staging into tblwood
INSERT INTO tblWood (Name, Description)
	SELECT DISTINCT Wood, WoodDescription FROM tblProductSTAGING;

SELECT * FROM tblWood;

-- update staging table with wood id from tblWood
UPDATE tblProductSTAGING SET
	WoodID = w.WoodID
	FROM tblWood w
	WHERE w.Name = tblProductSTAGING.Wood;

-- insert into tbl product from tblProductSTAGING
INSERT INTO tblProduct (WoodID, Name, Price, Description, ProductType)
	SELECT WoodID, Name, Price, Description, ProductType FROM tblProductSTAGING;

--insert into tbl fruniture from staging
INSERT INTO tblFurniture (ProductID, Length, Width, Height, ProductType)
	SELECT ProductID, Length, Height, Width, ProductType 
	FROM tblProductSTAGING
	WHERE Length is not null and ProductType = 'F';

SELECT * FROM tblFurniture;

-- insert into tblaccessory from staging
INSERT INTO tblAccessory (ProductID, isTableAccessory, ProductType)
	SELECT ProductID, isTableAccessory, ProductType 
	FROM tblProductSTAGING
	WHERE ProductType = 'A';

SELECT * FROM tblAccessory;