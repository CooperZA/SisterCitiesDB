-- Final Lab quiz 
-- Zach Cooper
USE W20_MIS421_LFXM_CooperZach;
GO

-- Create Table tblRoom
CREATE TABLE tblRoom (
  RoomID INT NOT NULL IDENTITY(1,1),
  RoomNumber VARCHAR(250) NULL,
  OccupancyLimit INT NULL,
  RoomType CHAR(1) NULL,
  PRIMARY KEY (RoomID),
  CONSTRAINT tblRoomRoomTypeCheck Check (RoomType = 'D' or RoomType = 'F' or RoomType = 'V'),
  CONSTRAINT tblRoomRoomAK UNIQUE (RoomID, RoomType)
);

-- Create Table tblDemoRoom
CREATE TABLE tblDemoRoom (
  RoomID INT NOT NULL,
  RoomType CHAR(1) NULL Default 'D',
  PRIMARY KEY (RoomID),
  CONSTRAINT  tblDemoRoomRoomTypeCheck Check (RoomType = 'D'),
  CONSTRAINT DemoRoomRoomFK
    FOREIGN KEY (RoomID)
    REFERENCES tblRoom (RoomID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- CrEATE Table tblFreeplayRoom
CREATE TABLE tblFreeplayRoom (
  RoomID INT NOT NULL,
  NumInRoom INT NULL,
  RoomType CHAR(1) NULL Default 'F',
  PRIMARY KEY (RoomID),
  CONSTRAINT  tblFreeplayRoomRoomTypeCheck Check (RoomType = 'F'),
  CONSTRAINT FreeplayRoomRoomFK
    FOREIGN KEY (RoomID)
    REFERENCES tblRoom (RoomID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- Create Table tblVendor
CREATE TABLE tblVendor (
  VendorID INT NOT NULL IDENTITY,
  VendorName VARCHAR(250) NULL,
  PRIMARY KEY (VendorID)
);

-- Create Table tblRetailRoom
CREATE TABLE tblRetailRoom (
  RoomID INT NOT NULL,
  VendorID INT NOT NULL,
  BoothLocation VARCHAR(250) NOT NULL,
  RoomType CHAR(1) NULL Default 'V',
  PRIMARY KEY (RoomID, VendorID),
  CONSTRAINT  tblRetailRoomRoomTypeCheck Check (RoomType = 'V'),
  CONSTRAINT RetailRoomRoomFK1
    FOREIGN KEY (RoomID)
    REFERENCES tblRoom (RoomID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT RetailRoomVendorFK2
    FOREIGN KEY (VendorID)
    REFERENCES tblVendor (VendorID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- CeateTable tblGame
CREATE TABLE tblGame (
  GameID INT NOT NULL IDENTITY,
  GameName VARCHAR(250) NULL,
  MaxNumPlayers INT NULL,
  EstimatedPlayTime INT NULL,
  NumTimesCheckedOut INT NULL,
  NumCopies INT NULL,
  BGGRank INT NULL,
  PRIMARY KEY (GameID),
  CONSTRAINT GameNameUNIQUE UNIQUE (GameName)
);

-- Create Table tblAttendee
CREATE TABLE tblAttendee (
  AttendeeID INT NOT NULL IDENTITY,
  Name VARCHAR(250) NULL,
  BadgeID VARCHAR(250) NULL,
  PRIMARY KEY (AttendeeID)
);

-- Create Table tblGameDemo
CREATE TABLE tblGameDemo (
  DemoerID INT NOT NULL,
  GameID INT NOT NULL,
  RoomID INT NOT NULL,
  DemoStartTime DATETIME NOT NULL,
  DemoEndTime DATETIME NULL,
  NumPeopleAttended INT NULL,
  PRIMARY KEY (DemoerID, GameID, RoomID, DemoStartTime)
 ,
  CONSTRAINT DemoerAttendeeFK1
    FOREIGN KEY (DemoerID)
    REFERENCES tblAttendee (AttendeeID)
    ON DELETE Cascade
    ON UPDATE CASCADE,
  CONSTRAINT GameDemoerDemoRoomFK2
    FOREIGN KEY (RoomID)
    REFERENCES tblDemoRoom (RoomID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT GameDemoerGameFK3
    FOREIGN KEY (GameID)
    REFERENCES tblGame (GameID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- Creaet Table tblAttendeeGamePlay
CREATE TABLE tblAttendeeGamePlay (
  AttendeeID INT NOT NULL,
  CheckedOutGameID INT NOT NULL,
  CheckoutTime DATETIME NOT NULL,
  CheckInTime DATETIME NULL,
  PRIMARY KEY (AttendeeID, CheckedOutGameID, CheckoutTime)
 ,
  CONSTRAINT AttendeePersonFK1
    FOREIGN KEY (AttendeeID)
    REFERENCES tblAttendee (AttendeeID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT AttendeeGameFK2
    FOREIGN KEY (CheckedOutGameID)
    REFERENCES tblGame (GameID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- tables created

-- ERD created

-- staging data imported

-- vendor id added using GUI

-- bulk insert for distinct vendors into tblVendor
INSERT INTO tblVendor (VendorName) SELECT DISTINCT Name FROM tblVendorsSTAGING;
-- done

-- update staging table with with vendorID
UPDATE tblVendorsSTAGING SET tblVendorsSTAGING.VendorID = tblVendor.VendorID FROM tblVendor WHERE tblVendorsSTAGING.Name = tblVendor.VendorName;
-- done

-- update purpose of room col in room staging 
-- done in excel

--insert data into room table
INSERT INTO tblRoom (RoomNumber, OccupancyLimit, RoomType) SELECT [Room Number], [Occupancy Limit], [Purpose of Room] FROM tblRoomsSTAGING;
-- Done

-- ids added using GUI
-- update vendor stagi ng with roomid values where roomtype is 'v'
UPDATE tblVendorsSTAGING set RoomType = 'V', RoomID = r.RoomID FROM tblRoom r WHERE r.RoomNumber = tblVendorsSTAGING.RoomNumber;
--done

--insert data into all tables except tbl AttendeeGamePlay and GameDemo
-- tblRoom done
-- tblVendor done
INSERT INTO tblRetailRoom (RoomID, VendorID, BoothLocation, RoomType) SELECT RoomID, VendorID, BoothLocationinRoom, RoomType FROM tblVendorsSTAGING;
-- tblRetailRoom done

INSERT INTO tblFreeplayRoom (RoomID, NumInRoom, RoomType) SELECT RoomID, OccupancyLimit, RoomType FROM tblRoom WHERE RoomType = 'F';
-- tblFreeplayRoom done

INSERT INTO tblDemoRoom (RoomID, RoomType) SELECT RoomID, RoomType FROM tblRoom WHERE RoomType = 'D';
-- tblDemoRoom done

INSERT INTO tblAttendee (Name, BadgeID) SELECT Name, BadgeID FROM tblAttendeeSTAGING;
-- tblAttendee done

INSERT INTO tblGame (GameName, MaxNumPlayers, EstimatedPlayTime, NumCopies, BGGRank) 
SELECT Name, MaxNumPlayers, EstimatedPlayTime, NumCopies, [BGG Rank]  FROM tblGamesSTAGING;
-- tblGame done

--manul insert for tblattendeegameplay 
INSERT INTO tblAttendeeGamePlay (AttendeeID, CheckedOutGameID, CheckoutTime) VALUES (1, 1, '3-12-2020');
-- done

--manual insert for tblgamedemo
INSERT INTO tblGameDemo (DemoerID, GameID, RoomID, DemoStartTime, NumPeopleAttended) VALUES (1, 1, 6, '3-12-2020', 3);
INSERT INTO tblGameDemo (DemoerID, GameID, RoomID, DemoStartTime, NumPeopleAttended) VALUES (2, 2, 7, '3-12-2020', 4);
INSERT INTO tblGameDemo (DemoerID, GameID, RoomID, DemoStartTime, NumPeopleAttended) VALUES (3, 3, 8, '3-12-2020', 5);
-- done

-- update freeplay room
UPDATE tblFreeplayRoom SET NumInRoom = 4 WHERE RoomID = 9;
-- done

--update tbl game
UPDATE tblGame SET NumTimesCheckedOut = 1 where GameID = 1;
UPDATE tblGame SET NumTimesCheckedOut = 1 where GameID = 2;
UPDATE tblGame SET NumTimesCheckedOut = 1 where GameID = 3;
-- done

GO
-- create view for games for large groups
CREATE VIEW vueGamesForLargeGroups
AS
	SELECT GameName, MaxNumPlayers FROM tblGame WHERE MaxNumPlayers >= 5;
--done

GO
--create view for active demos
CREATE VIEW vueActiveDemos
AS
	SELECT r.RoomNumber, a.Name, g.GameName, g.EstimatedPlayTime 
	FROM tblGame g 
	JOIN tblGameDemo gd ON g.GameID = gd.GameID
	JOIN tblRoom r ON gd.RoomID = r.RoomID
	JOIN tblAttendee a ON gd.DemoerID = a.AttendeeID;
--done





