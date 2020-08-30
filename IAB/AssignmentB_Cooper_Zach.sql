Use W20_MIS421_IndividualDB_Cooper_Zach;

--Question 4
-- insert into tblArtist
/*Insert Into tblArtist (LastName, FirstName, YearOfBirth, YearDeceased) 
Values ('Qi', 'Baishi', 1864, 1957), 
	   ('Kadinsky', 'Wassily', 1866, 1944), 
	   ('Klee', 'Paul', 1879, 1940),
	   ('Matisse', 'Henri', 1869, 1954),
	   ('Chagall', 'Marc', 1887, 1985);

Select * from tblArtist; */


-- insert into tblCustomer
/*Insert Into tblCustomer (CustomerID, FirstName, LastName, Street, City, State, Zip, Country, Phone, Email)
Values (1000, 'Chen', 'Jeffrey', '123 W. Elm St', 'Renton', 'WA', '98055', 'USA', '543-2345', 'Jeffrey.Chen@vgr.com'),
	   (1001, 'Smith', 'David', '813 Tumbleweed Lane', 'Loveland', 'CO', '81201', 'USA', '654-9876', 'David.Smith@vgr.com'),
	   (1015, 'Smith', 'Tiffany', '88 1st Avenue', 'Langley', 'WA', '98260', 'USA', '765-5566', 'Tiffany.Smith@vgr.com'),
	   (1033, 'George', 'Fred', '10899 88th Ave', 'Bainbridge Island', 'WA', '98110', 'USA', '876-9911', 'Fred.George@vgr.com'),
	   (1034, 'Frederickson', 'Mary Beth', '25 South Lafayette', 'Denver', 'CO', '80201', 'USA', '513-8822', 'MaryBeth.Frederickson@vgr.com'),
	   (1036, 'Warning', 'Selma', '205 Burnaby', 'Vancouver', 'BC', 'V6Z 1W2', 'Canada', '988-0512', 'Selma.Warning@vgr.com'); 

Select * from tblCustomer;*/

-- insert into tblArtistWork
/*Insert Into tblArtistWork (ArtistID, WorkID, Title, Copy, Medium, Description)
Values (1, 521, 'The Tilled Feild', '788/1000', 'High Quality Limited Print', 'Early Surrealist style'),
	   (1, 522, 'La Lecon de Ski', '353/500', 'High Quality Limited Print', 'Surrealist style'),
	   (2, 523, 'On White II', '435/500', 'High Quality Limited Print', 'Bauhaus style of Kandinsky'),
	   (4, 524, 'Woman with a Hat', '596/750', 'High Qulaity Limited Print', 'A very colorful Impressionist piece'),
	   (2, 551, 'Der Blaue Reiter', '236/1000', 'High Quality Limited Print', 'The Blue Rider-Early Pointilism influence'),
	   (5, 562, 'The Fiddler', '251/1000', 'High Quality Limited Print', 'Shows Belarusian folk-life themes and symbology');


Select * from tblArtistWork;*/


-- Question 5
-- Update tblCustomer
-- UPDATE tblCustomer Set Email = 'Selma.warning@wwu.edu'
-- Where LastName = 'Warning' and FirstName = 'Selma';

-- Select * from tblCustomer;

-- Update tblArtistWork
-- UPDATE tblArtistWork Set Copy = '800/1000'
-- WHERE ArtistID = 1 and WorkID = 521;*/

-- Update tblArtist
-- UPDATE tblArtist set Nationality = 'German'
-- Where FirstName = 'Paul' and LastName = 'Klee';

--SELECT * from tblArtistWork;


-- Question 6
-- Delete from tblAtristWork
-- DELETE from tblArtistWork 
-- where ArtistID = 5 and WorkID = 562; 

-- SELECT * from tblArtistWork;

-- Delete from tblArtist
-- DELETE from tblArtist where ArtistID = 5; 
-- SELECT * from tblArtist;