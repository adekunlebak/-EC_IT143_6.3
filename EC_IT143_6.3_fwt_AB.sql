/*****************************************************************************************************************
NAME:  EC_IT143_AB_6.3
PURPOSE: My script for T-SQL Data Manipulation—Fun with Triggers

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/25/2024   AB       1. Built this script for EC IT143


RUNTIME: 
Xm Xs

NOTES: 
 
******************************************************************************************************************/

--EC_IT143_6.3_fwt_s1
--Q1: How to keep track of when a record was last modified?
--A1: This works for the initial INSERT...

--ALTER TABLE dbo.t_hello_world
--ADD last_modified_date DATETIME DEFAULT GETDATE();

--Q2: How to keep track of when a record was last 

--EC_IT143_6.3_fwt_s2
--Q1: How to keep track of when a record was last modified?
--A1: This works for the initial INSERT...

--ALTER TABLE dbo.t_hello_world
--ADD last_modified_date DATETIME DEFAULT GETDATE();

--Q2: How to keep track of when a record was last 
--A2: Maybe use an after update trigger

--EC_IT143_6.3_fwt_s3
--Q1: How to keep track of when a record was last modified?
--A1: This works for the initial INSERT...

--ALTER TABLE dbo.t_hello_world
--ADD last_modified_date DATETIME DEFAULT GETDATE();

--Q2: How to keep track of when a record was last 
--A2: Maybe use an after update trigger
--https://stackoverflow.com/questions/57180663/sql-how-do-you-create-a-trigger-in-a-sql-database-to-update-a-last-modified-da
--https://stackoverflow.com/questions/25568526/sql-server-after-update-trigger

--EC_IT143_6.3_fwt_s4
CREATE TRIGGER trg_hello_world_last_mod ON dbo.t_hello_world
AFTER UPDATE
AS
UPDATE dbo.t_hello_world
       SET
	      last_modified_date = GETDATE()
WHERE My_Goodwill IN 
(SELECT DISTINCT
        My_Goodwill
	FROM inserted
);

--EC_IT143_6.3_fwt_s5

--Q2: How to keep track of when a record was last 
--A2: Maybe use an after update trigger

--Q3 Did it work?
--A3 well, it should work... let see
--Remove stuff if it is already there
DELETE FROM dbo.t_hello_world
WHERE My_Goodwill IN ('Hello World2', 'Hello World3','Hello World4');
--Load test row
INSERT INTO dbo.t_hello_world(My_Goodwill)
VALUES('Hello World2'), ('Hello World3');
--see if the trigger worked
SELECT t.* FROM dbo.t_hello_world AS t
--Try it again
UPDATE dbo.t_hello_world SET My_Goodwill = 'Hello World4'
WHERE My_Goodwill = 'Hello World3'
--see if the trigger worked
SELECT t.* FROM dbo.t_hello_world AS t

--EC_IT143_6.3_fwt_s5
--Q4: How to keep track of who last modified a record?
--A4: This works for server user and the initial INSERT...

ALTER TABLE dbo.t_hello_world
ADD last_modified_by VARCHAR(50) DEFAULT SUSER_NAME ();