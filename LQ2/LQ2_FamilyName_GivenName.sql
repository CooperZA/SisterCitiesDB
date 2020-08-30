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
	WoodID		int				NULL Unique,
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
	ProductType char(1)			NOT NULL,
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
	ProductType			char(1)			not null,

);