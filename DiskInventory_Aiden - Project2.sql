/**/
/**/
/*DATE	Programmer	Desc	*/
/*3/4/22	Aiden	Project Created	*/
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