/**/
/**/
/*DATE	Programmer	Desc	*/
/*3/4/22	Aiden	Project Created	tables made*/
/*3/09/22	Aiden	Project 3 work, Inserts added*/
/*3/11/22	Aiden	Inserts populated and stuff*/
/*3/18/22	Aiden	Project 4, added views and added report statements*/
/*3/30/22	Aiden	Project 5 continue. */
/*4/1/22	Aiden	Fixed issue with later half of code */
/**/
/**/

use master;
go
DROP DATABASE IF EXISTS disk_inventoryAB;
go
CREATE DATABASE disk_inventoryAB;
go
--add server user
IF SUSER_ID('diskUserAB') IS NULL
	CREATE LOGIN diskUserAB
	WITH PASSWORD = 'Pa$$w0rd',
	DEFAULT_DATABASE = disk_inventoryAB;
use disk_inventoryAB;
--add db user
go
CREATE USER diskUserAB;
ALTER ROLE db_datareader
	ADD MEMBER diskUserAB
go

--create lookup tables
CREATE TABLE media_format (
	format_ID	INT NOT NULL IDENTITY PRIMARY KEY,
	format_type	VARCHAR(50) NOT NULL
);	--CD, Vinyl, DVD, 8Track, Cassette
CREATE TABLE genre (
	genre_ID	INT NOT NULL IDENTITY PRIMARY KEY,
	genre_desc	VARCHAR(50) NOT NULL
);  --country, metal, rock, alt
CREATE TABLE status (
	status_ID	INT NOT NULL IDENTITY PRIMARY KEY,
	status_desc	VARCHAR(15) NOT NULL
);	--Available, Onloan, Damaged, Broken
CREATE TABLE borrower (
	borrower_ID	INT NOT NULL IDENTITY PRIMARY KEY,
	borrower_fname	NVARCHAR(60) NOT NULL,
	borrower_lname	NVARCHAR(60) NOT NULL,
	borrower_phone	NVARCHAR(15) NOT NULL
);
CREATE TABLE CD (
	CD_ID	INT NOT NULL IDENTITY PRIMARY KEY,
	CD_name	NVARCHAR(60) NOT NULL,
	release_date	DATE NOT NULL,
	genre_ID	INT NOT NULL REFERENCES genre(genre_ID),
	status_ID	INT NOT NULL REFERENCES status(status_ID),
	format_ID	INT NOT NULL REFERENCES media_format(format_ID)
);
CREATE TABLE CD_out (
	CD_out_CD_ID	INT NOT NULL IDENTITY PRIMARY KEY,
	borrower_ID	INT NOT NULL REFERENCES borrower(borrower_ID),
	CD_ID	INT NOT NULL REFERENCES CD(CD_ID),
	borrowed_date	DATETIME2 NOT NULL,
	return_date	DATETIME2 NULL
);

--P3 D1

INSERT INTO media_format
	(format_type)
VALUES
	('CD')
	,('Vinyl')
	,('8track')
	,('Cassette')
	,('DVD')
	;

INSERT INTO genre
	(genre_desc)
VALUES
	('Classic Rock')
	,('Metal')
	,('Instrumental')
	,('Electronic')
	,('Indie')
	,('Classical')
	,('Jazz')
	;

INSERT INTO status
	(status_desc)
VALUES
	('Available')
	,('On Loan')
	,('Damaged')
	,('Missing')
	,('Unavailable')
	;

INSERT INTO borrower
	(borrower_fname, borrower_lname, borrower_phone)
VALUES
	('Jon', 'Joey', '555-111-1234'),
	('Adam', 'Addler', '555-111-1123'),
	('Brennan', 'Bolt', '555-211-3244'),
	('Cristy', 'Crupps', '444-222-7980'),
	('Donna', 'Dinklesmitch', '777-843-0900'),
	('Ella', 'Evestone', '777-843-1222'),
	('Fred', 'Fortunes', '342-345-5678'),
	('Greg', 'Goosey', '777-843-3452'),
	('Henry', 'Horton', '234-234-1332'),
	('Issabel', 'Iris', '453-345-2312'),
	('Korbon', 'Kranstor', '777-843-5643'),
	('Misty', 'Moonsrear', '444-222-2312'),
	('Lewis', 'Licks', '234-234-1378'),
	('Norton', 'Neatspoon', '234-346-5685'),
	('Oscar', 'Orangella', '234-234-1345'),
	('Patrick', 'Ports', '444-222-3456'),
	('Quintin', 'Quickslie', '777-843-5478'),
	('Rosey', 'Rogereetrocks', '777-843-3462'),
	('Stacy', 'Stoopstins', '444-222-3456'),
	('Tanner', 'Tortellini', '999-654-4352'),

	('Toby','Deletahed','666-555-6336')
	;

DELETE borrower
WHERE borrower_id = 21;

INSERT CD
	(CD_name, release_date, status_ID, genre_ID,  format_ID)
VALUES
	('Queen Greatest Hits', '11/11/1981', '1', '1', '1'),
	('Backstreet Boys', '09/18/2001', '1', '2', '1'),
	('Nirvana Back and End', '9/11/1979', '1', '3', '1'),
	('Beastie Boys 2', '5/12/1980', '1', '4', '1'),
	('The Band', '8/8/1983', '1', '5', '2'),
	('Aerosmith', '9/6/1995', '2', '6', '1'),
	('Daft Punk', '2/3/2009', '2', '7', '1'),
	('Cream', '6/26/1980', '3', '2', '1'),
	('The Doors', '4/22/1981', '2', '1', '3'),
	('The Kinks', '2/11/1993', '2', '3', '1'),
	('The Pet Shop Boys', '12/22/1997', '2', '4', '1'),
	('Pearl Jam', '10/18/2012', '2', '5', '2'),
	('Pixies', '2/26/2013', '2', '6', '3'),
	('R.E.M', '4/28/1987', '2', '7', '4'),
	('Rage Against the Machine', '2/3/2009', '2', '2', '4'),
	('Static-X', '5/12/1980', '3', '3', '5'),
	('Sonic Youth', '4/13/1992', '3', '2', '5'),
	('U2', '10/18/2012', '4', '4', '1'),
	('Yes', '2/26/2013', '4', '5', '1'),
	('Smash Mouth', '12/22/1997', '5', '6', '2')
	;

INSERT CD_out
	(borrower_ID, CD_ID, borrowed_date, return_date)
VALUES
	(1, 1, '2-16-2021', '2-17-2021')
	,(2, 6, '1-2-2021', NULL)
	,(3, 4, '12-22-2021', '12-25-2021')
	,(4, 7, '1-2-2021', '1-3-2021')
	,(4, 8, '8-2-2021', '8-15-2021')
	,(5, 2, '3-4-2021', '3-5-2021')
	,(5, 6, '8-23-2021', '8-27-2021')
	,(6, 7, '8-16-2021', '8-17-2021')
	,(7, 1, '7-7-2021', '7-15-2021')
	,(8, 9, '9-1-2021', '9-2-2021')
	,(9, 10, '9-24-2021', '9-25-2021')
	,(10, 14, '9-8-2021', '9-9-2021')
	,(11, 3, '10-2-2021', NULL)
	,(12, 17, '4-5-2021', '5-5-2021')
	,(13, 12, '5-2-2021', '10-9-2021')
	,(14, 15, '1-2-2021', '2-15-2021')
	,(15, 1, '1-2-2021', '2-15-2021')
	,(16, 7, '1-2-2021', '1-3-2021')
	,(16, 10, '10-26-2021', NULL)
	,(3, 4, '12-26-2021', '12-27-2021')
	;

SELECT borrower_ID as Borrower_ID, CD_ID as cd_ID, CAST  (borrowed_date as date) as Borrowed_date, return_date as Return_date
FROM CD_out
WHERE return_date IS NULL;

--Project 4

--1

SELECT 'CD Name'=CD_name, release_date, media_format.format_type, genre.genre_desc, status.status_desc
FROM CD
JOIN media_format
	ON CD.format_ID = media_format.format_ID
JOIN genre
	ON CD.genre_ID = genre.genre_ID
JOIN status
	ON CD.status_ID = status.status_ID
ORDER BY CD_name
;

--2

SELECT borrower_lname, borrower_fname, CD_name, borrowed_date, return_date
FROM CD_out
JOIN borrower
	ON CD_out.borrower_ID = borrower.borrower_ID
JOIN CD
	ON CD_out.CD_ID = CD.CD_ID
ORDER BY borrower_lname
;

--3

SELECT CD_name, COUNT(*)
FROM CD_out
JOIN CD
	ON CD_out.CD_ID = CD.CD_ID
GROUP BY CD_name
HAVING COUNT(*) > 1
ORDER BY CD_name
;

--4

SELECT CD_name, borrowed_date, return_date, borrower_lname, borrower_fname
FROM CD
JOIN CD_out
	ON CD.CD_ID = CD_out.CD_ID
JOIN borrower
	ON borrower.borrower_ID = CD_out.borrower_ID
WHERE return_date IS NULL
ORDER BY CD_name
;

--5

GO --Own batch for create view

CREATE VIEW View_Borrower_No_Loans
AS
	SELECT borrower_ID, borrower_lname, borrower_fname
	FROM borrower
	WHERE borrower_ID NOT IN
		(SELECT DISTINCT borrower_ID
		FROM CD_out)
;
GO

CREATE VIEW View_Borrower_No_Loans2
AS
	SELECT borrower.borrower_ID, borrower_lname, borrower_fname
	FROM borrower
	LEFT JOIN CD_out ON
		borrower.borrower_ID =
		CD_out.borrower_ID
	WHERE borrowed_date IS NULL
;
GO

SELECT borrower_lname, borrower_fname
FROM View_Borrower_No_Loans
ORDER BY borrower_lname, borrower_fname
;

--6

SELECT borrower_lname, borrower_fname, COUNT(CD_ID)
FROM CD_out
JOIN borrower
	ON borrower.borrower_ID = CD_out.borrower_ID
GROUP BY borrower_lname, borrower_fname
HAVING COUNT(*) > 1
ORDER BY borrower_lname, borrower_fname
;

--Ch15 Lab

use disk_inventoryAB;
-- create proc sp_ins_disk_has_borrower or CD

DROP PROC IF EXISTS  sp_ins_CD_out;
go
CREATE PROC sp_ins_CD_out
	@borrower_id int, @CD_id int, @borrowed_date datetime2, @return_date datetime2 = NULL
AS
BEGIN TRY
	INSERT CD_out
		(borrower_id, CD_id, borrowed_date, return_date)
	VALUES
		(@borrower_id, @CD_id, @borrowed_date, @return_date);
END TRY
BEGIN CATCH
	PRINT 'An Error Occured';
	PRINT 'Message: ' + CONVERT(VARCHAR(200), ERROR_MESSAGE());
END CATCH
go
GRANT EXEC ON sp_ins_CD_out TO diskUserAB;
go
sp_ins_CD_out 2, 3, '3-27-2022', '3-28-2022'
go
sp_ins_CD_out 4, 5, '3-27-2022'
go

--PROJECT 5

DROP PROC IF EXISTS sp_upd_CD_out
GO

CREATE PROC sp_upd_CD_out
	@CD_out_CD_ID int, @borrower_id int, @CD_id int, @borrowed_date datetime2, @return_date datetime2 = NULL
AS
	BEGIN TRY
		UPDATE CD_out
		SET borrower_id = @borrower_id,
			CD_id = @CD_id,
			borrowed_date = @borrowed_date,
			return_date = @return_date
		WHERE CD_out_CD_ID = @CD_out_CD_ID;
	END TRY
	BEGIN CATCH
		PRINT 'an error occurred.';
		PRINT 'Message: ' + CONVERT(VARCHAR(200), ERROR_MESSAGE());
	END CATCH
GO

sp_upd_CD_out 24, 2, 4, '3-3-2022', '3-23-2022';
GO
declare @today datetime2 = getdate();
exec sp_upd_CD_out 24, 2, 3, '3-13-2022', @today;
GO

DROP PROC IF EXISTS sp_ins_CD;
GO
CREATE PROC sp_ins_CD
	@CD_name nvarchar(6), @release_date date, @genre_id int, @status_id int, @CD_type_id int
AS
	BEGIN TRY
		INSERT CD
		(CD_name, release_date, genre_id, status_id, format_ID)
		VALUES 
		(@CD_name, @release_date, @genre_id, @status_id, @CD_type_id)

	END TRY
	BEGIN CATCH
		PRINT 'an error occurred.';
		PRINT 'Message: ' + CONVERT(VARCHAR(200), ERROR_MESSAGE());
	END CATCH
GO

-- Grants Permissions
GRANT EXECUTE ON sp_ins_CD TO diskUserAB;
GO
EXEC sp_ins_CD 'Beastie Boys 2', '3/25/2022', 4, 1, 1
GO
EXEC sp_ins_CD 'Beastie Boys 2', '3/25/2022', 4, 1, NULL --bad
GO

DROP PROC IF EXISTS sp_upd_CD;
go
CREATE PROC sp_upd_CD
	@CD_id int, @CD_name nvarchar(60), @release_date date, @genre_id int, @status_id int, @format_ID int
AS
	BEGIN TRY
		UPDATE CD
		SET CD_name = @CD_name,
			release_date = @release_date,
			genre_id = @genre_id,
			status_id = @status_id,
			format_ID = @format_ID
		WHERE CD_id = @CD_id;
	END TRY
	BEGIN CATCH
		PRINT 'an error occurred.';
		PRINT 'Message: ' + CONVERT(VARCHAR(200), ERROR_MESSAGE());
	END CATCH
GO

-- Grants Permissions
GRANT EXECUTE ON sp_upd_CD TO diskUserAB;
GO
EXEC sp_upd_CD 23, 'Beastie Boys 2', '3/25/2022', 4, 1, 1
GO
EXEC sp_upd_CD 23, 'Beastie Boys 2', '3/25/2022', 4, 1, NULL
GO

DROP PROC IF EXISTS sp_del_CD;
GO
CREATE PROC sp_del_CD
	@CD_id int
AS
	BEGIN TRY
		DELETE FROM [dbo].[CD]
			  WHERE CD_id = @CD_id;
	END TRY
	BEGIN CATCH
		PRINT 'an error occurred.';
		PRINT 'Message: ' + CONVERT(VARCHAR(200), ERROR_MESSAGE());
	END CATCH
GO
GRANT EXECUTE ON sp_del_CD TO diskUserAB;
GO
EXEC sp_del_CD 44;
GO
EXEC sp_del_CD 3;
GO
