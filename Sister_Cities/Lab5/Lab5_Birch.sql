Create TABLE tblCommittee (
CommitteeID int NOT NUll IDENTITY (1,1) PRIMARY KEY,
CommitteeName nvarchar (250) Null Unique,
MeetingTime nvarchar (250) Null,
BudgetedExpenditures decimal Null,
ExpendituresToDate decimal Null,
CommitteeType char (1) Not Null,
Constraint tblCommitteeCommitteeTypeCheck Check (CommitteeType = 'C' or CommitteeType = 'S'),
Constraint tblCommitteeCommitteeAK Unique (CommitteeID, CommitteeType));

Select * from tblCommittee



Create Table tblSisterCityCommittee (
SisterCityCommitteeID int Not Null  Primary Key,
SisterCityID int Unique,
TopProject nvarchar (250) Null,
LastVisitToCity datetime Null,
LastVisitFromCity datetime Null,
NextVisitToCity datetime Null,
NextVisitFromCity datetime Null,
CommitteeType char(1) Not Null Default 'C',
Constraint tblSisterCityCommitteeCommitteeTypeCheck Check (CommitteeType = 'C'),
Constraint tblSisterCityCommitteeFK Foreign Key (SisterCityCommitteeID, CommitteeType)
References tblCommittee (CommitteeID, CommitteeType)
on update no action
on delete no action,
Constraint tblSisterCityCommitteeFK2 Foreign KEY (SisterCityID)
References tblSisterCity (sistercityID)
on update no action
on delete no action);

Create Table tblSupportSubCommittee (
SupportCommitteeID int not null Primary key,
CityContact nvarchar(250) null,
MissionStatement text null,
CommitteeType char(1) null Default 'S',
Constraint tblSupportSubCommitteeCommitteeTypeCheck Check (CommitteeType = 'S'),
Constraint tblSupportSubCommitteeFK Foreign Key (SupportCommitteeID, CommitteeType)
References tblCommittee (CommitteeID, CommitteeType)
on update no action
on delete no action);


-- alter table
ALTER TABLE TblCommitteeIMPORT
	ADD CommitteID INT null;
ALTER TABLE TblCommitteeIMPORT
	ADD CommitteeType Char(1) null;
ALTER TABLE TblCommitteeIMPORT
	ADD SisterCityID INT null;

--Update to S or C
UPDATE TblCommitteeIMPORT SET 
	CommitteeType = 'S' WHERE AffiliatedCity IS null;
UPDATE TblCommitteeIMPORT SET 
	CommitteeType = 'C' WHERE MissionStatement IS null;

--Update SisiterCityID
UPDATE TblCommitteeIMPORT SET
	tblcommitteeIMPORT.SisterCityID = tblSisterCity.SisterCityID 
	FROM tblSisterCity
	WHERE TblCommitteeIMPORT.CommitteeName = tblsistercity.CityName; 

--migrate data to tblCommittee
INSERT INTO tblCommittee (CommitteeName, MeetingTime, BudgetedExpenditures, ExpendituresToDate, CommitteeType)
	SELECT CommitteeName, MonthlyMeetingTime, BudgetedExpenditures, ExpendituresToDate, CommitteeType
	FROM TblCommitteeIMPORT;
	
-- update committeeID  in tblcommitteeimport
UPDATE TblCommitteeIMPORT SET
	tblcommitteeIMPORT.CommitteID = tblCommittee.CommitteeID
	FROM tblCommittee
	WHERE TblCommitteeIMPORT.CommitteeName = tblCommittee.CommitteeName;

--migrate to tblcommitteesupport
INSERT INTO tblSupportSubCommittee (SupportCommitteeID, CityContact, MissionStatement, CommitteeType)
	SELECT CommitteID, CityGovernmentContact, MissionStatement, CommitteeType
	FROM TblCommitteeIMPORT
	WHERE TblCommitteeIMPORT.CommitteeType = 'S';

-- migrate data into tblsistercitycommittee
INSERT INTO tblSisterCityCommittee (SisterCityCommitteeID, SisterCityID, TopProject, LastVisitToCity, LastVisitFromCity, NextVisitToCity, NextVisitFromCity, CommitteeType)
	SELECT	CommitteID, SisterCityID, TopProject, MostRecentVisitToCity, MostRecentVisitFromCity, NextVisitToCity, NextVisitFromCity, CommitteeType
	FROM TblCommitteeIMPORT
	WHERE TblCommitteeIMPORT.CommitteeType = 'C';

GO

-- Create view: list of committees
CREATE VIEW vueCommitteeSummary AS 
	SELECT c.CommitteeName, c.MeetingTime, c.BudgetedExpenditures, c.ExpendituresToDate, 
	scc.TopProject, scc.LastVisitFromCity, scc.LastVisitToCity, scc.NextVisitFromCity, scc.NextVisitToCity,
	ssc.CityContact, ssc.MissionStatement
	FROM tblCommittee c
	FULL OUTER JOIN tblSisterCityCommittee scc ON c.committeeID = scc.SisterCityCommitteeID
	FULL OUTER JOIN tblSupportSubCommittee ssc ON c.CommitteeID = ssc.SupportCommitteeID;


GO


-- Create View: return list of city committees
CREATE VIEW vueListCities AS
	SELECT c.CommitteeID, c.CommitteeName, c.MeetingTime, c.BudgetedExpenditures, c.ExpendituresToDate, c.CommitteeType,
	sc.CityName, sc.Country, sc.Description
	FROM tblCommittee c
	JOIN tblSisterCityCommittee ON c.CommitteeID = tblSisterCityCommittee.SisterCityCommitteeID 
	JOIN tblSisterCity sc ON tblSisterCityCommittee.SisterCityID = sc.SisterCityID;

GO

-- Create View: return financial status of committees
CREATE VIEW vueCommitteeFinancialStatus AS
	SELECT CommitteeName, BudgetedExpenditures, ExpendituresToDate, BudgetedExpenditures-ExpendituresToDate AS AmountAvailableToSpend
	FROM tblCommittee;