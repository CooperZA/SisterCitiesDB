--add two columns to staging table
--ALTER TABLE tblGameStaging ADD GameID INT NULL, PlayerID INT NULL;

--Insert data from staging into tblGame
--INSERT INTO tblGame (GameName, GameGenre) VALUES ('Wingspan', 'Engine Building');

--INSERT INTO tblGame (GameName, GameGenre) VALUES ('Trickerson', 'Strategy');
--INSERT INTO tblGame (GameName, GameGenre) VALUES ('Tsurro', 'Icebreaker');
--INSERT INTO tblGame (GameName, GameGenre) VALUES ('Clank', 'Deck Building');
--INSERT INTO tblGame (GameName, GameGenre) VALUES ('Perfect Heist', 'Party');
--INSERT INTO tblGame (GameName, GameGenre) VALUES ('Tapestry', 'Worker Placement');
--INSERT INTO tblGame (GameName, GameGenre) VALUES ('Dungeon Mayhem', 'Icebreaker');
--INSERT INTO tblGame (GameName, GameGenre) VALUES ('Dominion', 'Deck Building');
--INSERT INTO tblGame (GameName, GameGenre) VALUES ('Fantastic Factories', 'Strategy');

--insert data from staging into tblPerson
--INSERT INTO tblPlayer SELECT WonBy, Email FROM tblGameStaging;

--update staging table with matching ids
--UPDATE tblGameStaging SET GameID = tblGame.GameID WHERE tblGameStaging.GameName = tblGame.GameName;

-- Bulk insert into tblGameWinner
--INSERT INTO tblGameWinner(GameID, PlayerID, DatePlayed) SELECT GameID, PlayerID, DatePlayed FROM tblGameStaging;

