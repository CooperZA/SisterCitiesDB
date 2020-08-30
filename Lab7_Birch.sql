/*
	Team Birch Lab 7i	
*/

-- insert sydney bc into tblsistercity
INSERT INTO tblSisterCity (CityName, Country, Population, Description, Mayor, Website) 
VALUES ('Sidney', 'Canada', 11483, 
	'Sidney is located at the southeast end of Vancouver Island, just north of Victoria and adjacent to the world famous Butchart Gardens.', 
	'Steve Price', 'http://www.sidney.ca/');

-- insert into tbl committee
INSERT INTO tblCommittee (CommitteeName, MeetingTime, BudgetedExpenditures, ExpendituresToDate, CommitteeType)
VALUES ('Summer Music Festival at the Bay', '1st Monday 3pm', 5000, 1000, 'S');

INSERT INTO tblCommittee (CommitteeName, MeetingTime, BudgetedExpenditures, ExpendituresToDate, CommitteeType)
VALUES ('Sidney', '3rd Tuesday 2pm', 1000, 500, 'C');


-- tbl support committee inerst
INSERT INTO tblSupportCommittee (CityContact, MissionStatement, CommitteeType, SupportCommitteeID) 
VALUES ('Parks and Rec. Dir.', 'Promote Bellingham through music events', 'S', 15);

--tbl sister city committee
INSERT INTO tblSisterCityCommittee (SisterCityID, TopProject, LastVisitToCity, LastVisitFromCity, NextVisitToCity, NextVisitFromCity, CommitteeType, SisterCityCommitteeID) 
VALUES (7, 'Establish Relationship', '2015-5-10', '2015-4-24', '2015-6-16', '2015-7-17', 'C', 16);

-- delete sydney from tbl sister city
DELETE FROM tblSisterCity WHERE SisterCityID = 7;

--delete sidney committee
DELETE FROM tblCommittee WHERE CommitteeID = 16;

--delete committe from sister city commiittee table
DELETE FROM tblSisterCityCommittee WHERE SisterCityCommitteeID = 16;

-- se multi user mode
ALTER DATABASE W20_MIS421_Birch SET MULTI_USER;

