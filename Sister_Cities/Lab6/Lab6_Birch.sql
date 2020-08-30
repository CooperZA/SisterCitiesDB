-- INSERT program committee into the committtee table
INSERT INTO tblCommittee (CommitteeName, MeetingTime, BudgetedExpenditures, ExpendituresToDate, CommitteeType) 
VALUES ('Program', '3rd Friday 7PM', 500, 50, 'S');

SELECT * FROM tblCommittee;

-- INSERT program committee into the committtee support table
INSERT INTO tblCommitteeSupport (SupportCommitteeID, CityContact, MissionStatement, CommitteeType)
VALUES (14, 'Parks and Rec. Dir.', 'To coordinate the programs offered by the various city committees.', 'S');

SELECT * FROM tblCommitteeSupport;

--Create tables service history, authorizedcommitteepostion, position
Create Table tblServiceHistory(
PersonID Int Not Null,
CommitteeID Int Not Null,
PositionID Int Not Null,
StartDate Date Not Null,
EndDate Date Null,
Constraint tblServiceHistoryPK Primary Key (PersonID, CommitteeID, PositionID, StartDate),
Constraint tblServiceHistoryFK1 Foreign Key (PersonID) References tblPerson(PersonID)
On Update No Action
On Delete No Action,
Constraint tblServiceHistoryFK2 Foreign Key (CommitteeID, PositionID) References tblAuthorizedCommitteePosition(CommitteeID, PositionID)
On Update No Action
On Delete No Action
);

--tbl Authorized
Create Table tblAuthorizedCommitteePosition(
CommitteeID Int Not Null,
PositionID Int Not Null,
ApprovedDate Date Null,
Constraint tblAuthorizedCommitteePositionPK Primary Key (CommitteeID, PositionID),
Constraint tblAuthorizedCommitteePositionFK1 Foreign Key (CommitteeID) References tblCommittee (CommitteeID)
On Update No Action
On Delete No Action,
Constraint tblAuthorizedCommitteePositionFK2 Foreign Key (PositionID) References tblPosition (PositionID)
On Update No Action
On Delete No Action
);
 
--tbl Postion
Create Table tblPosition(
PositionID Int Not Null Identity(1,1) Primary Key,
JobTitle nvarchar (250) Not Null Unique,
);

--add foreign keys
ALTER TABLE tblCommitteeOfficers_IMPORT ADD PersonID int Null;
ALTER TABLE tblCommitteeOfficers_IMPORT ADD PositionID int Null;
ALTER TABLE tblCommitteeOfficers_IMPORT ADD CommitteeID int Null;
ALTER TABLE tblCommitteeOfficers_IMPORT ADD AuthorizedPositionID int Null;

--Update import table with person ID
UPDATE tblCommitteeOfficers_IMPORT SET 
tblCommitteeOfficers_IMPORT.PersonID = p.PersonID
FROM tblPerson p
WHERE tblCommitteeOfficers_IMPORT.LastName = p.LastName AND tblCommitteeOfficers_IMPORT.FirstName = p.FirstName;

UPDATE tblCommitteeOfficers_IMPORT SET
PersonID = 41
WHERE FirstName = 'George' and LastName = 'Vancouver (371-2131)';

UPDATE tblCommitteeOfficers_IMPORT SET
PersonID = 59
WHERE FirstName = 'George' and LastName = 'Vancouver (384-5171)';

SELECT PersonID, FirstName, LastName, Phone FROM tblPerson WHERE FirstName = 'George' AND LastName LIKE '%Vancouver%';

--insert authorized position into import table
INSERT INTO tblPosition (JobTitle)
SELECT DISTINCT AuthorizedCommitteePositions FROM tblCommitteeOfficers_IMPORT
WHERE AuthorizedCommitteePositions is not null and CommitteeName is not null;

--update import table wit position id
UPDATE tblCommitteeOfficers_IMPORT SET 
tblCommitteeOfficers_IMPORT.AuthorizedPositionID = p.PositionID 
FROM tblPosition p
WHERE tblCommitteeOfficers_IMPORT.AuthorizedCommitteePositions = p.JobTitle;

-- update import table with position id where office == jobtitle
UPDATE tblCommitteeOfficers_IMPORT SET 
tblCommitteeOfficers_IMPORT.PositionID = p.PositionID 
FROM tblPosition p
WHERE tblCommitteeOfficers_IMPORT.Office = p.JobTitle;

--Update committee ID in import table
Update tblCommitteeOfficers_IMPORT SET
tblCommitteeOfficers_IMPORT.CommitteeID = c.CommitteeID
from tblCommittee c
WHERE tblCommitteeOfficers_IMPORT.CommitteeName = c.CommitteeName;

--pacrim
Update tblCommitteeOfficers_IMPORT SET
tblCommitteeOfficers_IMPORT.CommitteeID = 7
WHERE tblCommitteeOfficers_IMPORT.CommitteeName = 'PacRim';

--programs
Update tblCommitteeOfficers_IMPORT SET
tblCommitteeOfficers_IMPORT.CommitteeID = 14
WHERE tblCommitteeOfficers_IMPORT.CommitteeName = 'Programs';

--insert ids and approved on date into authorized committee postion table
INSERT INTO tblAuthorizedCommitteePosition (CommitteeID, PositionID, ApprovedDate)
SELECT DISTINCT CommitteeID, AuthorizedPositionID, ApprovedOn FROM tblCommitteeOfficers_IMPORT
WHERE AuthorizedCommitteePositions is not null and CommitteeName is not null;

--insert into service history 
INSERT INTO tblServiceHistory (PersonID, PositionID, CommitteeID, StartDate, EndDate)
SELECT DISTINCT PersonID, PositionID, CommitteeID, [Start], [End] FROM tblCommitteeOfficers_IMPORT
WHERE PersonID is not null and PositionID is not null and CommitteeID is not null and [start] is not null;

GO
-- create view count authorized positions for each committee
CREATE VIEW vueCountPositionsByCommittee_6_30 AS
	SELECT COUNT(PositionID) AS 'Number of Authorized Positions', 'Authorized position(s) for ' + CommitteeName AS 'Committee Positions'
	FROM tblAuthorizedCommitteePosition as acp
	JOIN tblCommittee c ON c.CommitteeID = acp.CommitteeID
	WHERE acp.ApprovedDate is not null
	GROUP BY c.CommitteeName;
