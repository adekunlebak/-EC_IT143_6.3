/*****************************************************************************************************************
NAME:  EC_IT143_AB_6.3
PURPOSE: My script for T-SQL Data Manipulation—Fun with Functions

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/25/2024   AB       1. Built this script for EC IT143


RUNTIME: 
Xm Xs

NOTES: 
 
******************************************************************************************************************/

 --EC_IT143_6.3_fwf_s1_AB
-- Q1: How to extract first name from contact Name?
--  Let me get started by geting the current date...

SELECT GETDATE() AS my_date;

--EC_IT143_6.3_fwf_s2_AB

-- Q1: How to extract first name from contact Name?

-- A1: Alright, this is how i will solve the problem...
-- ContactName = Maria Anders --> Maria

--EC_IT143_6.3_fwf_s3_AB

-- Q1: How to extract first name from contact Name?

-- A1: Alright, this is how i will solve the problem...
-- ContactName = Maria Anders --> Maria

SELECT t.ContactName
FROM dbo.t_w3_schools_customers AS t
ORDER BY 1 

--EC_IT143_6.3_fwf_s4_AB

-- Q1: How to extract first name from contact Name?

-- A1: Alright, this is how i will solve the problem...
-- ContactName = Maria Anders --> Maria
--Google search "how to extract first name from Combine name"
--https://stackoverflow.com/questions/5145791/extracting-first-name-and%20-last-names

SELECT t.ContactName
     , LEFT(t.ContactName, CHARINDEX(' ', t.ContactName + ' ') - 1) AS  First_name
FROM dbo.t_w3_schools_customers AS t
ORDER BY 1 

--EC_IT143_6.3_fwf_s5_AB

CREATE FUNCTION [dbo].[udf_parse_first_name]
(
 @ContactName VARCHAR(500)
)
RETURNS VARCHAR(100)

AS
    BEGIN
         DECLARE @First_name VARCHAR(100);
	     SET @First_name = LEFT(@ContactName, CHARINDEX(' ', @ContactName + ' ') -1);
	     RETURN @First_name;
     END
GO


--EC_IT143_6.3_fwf_s6_AB

-- Q1: How to extract first name from contact Name?

-- A1: Alright, this is how i will solve the problem...
-- ContactName = Maria Anders --> Maria
--Google search "how to extract first name from Combine name"
--https://stackoverflow.com/questions/5145791/extracting-first-name-and%20-last-names
SELECT t.ContactName
     , LEFT(t.ContactName, CHARINDEX(' ', t.ContactName + ' ') - 1) AS  First_name
	 , [dbo].[udf_parse_first_name](ContactName) AS First_name2
FROM dbo.t_w3_schools_customers AS t
ORDER BY 1 


--EC_IT143_6.3_fwf_s7_AB

WITH s1 --use a common table expression and compare first_name and first_name2
     AS(SELECT t.ContactName
     , LEFT(t.ContactName, CHARINDEX(' ', t.ContactName + ' ') - 1) AS  First_name
	 , [dbo].[udf_parse_first_name](ContactName) AS First_name2
FROM dbo.t_w3_schools_customers AS t)
SELECT s1.*
FROM s1
WHERE s1.First_name <> s1.First_name2; --expected result is 0 rows

--EC_IT143_6.3_fwf_s8_AB

SELECT t.CustomerID
     , t.CustomerName
	 , t.ContactName
	 , [dbo].[udf_parse_first_name](ContactName) AS ContactName_first_name 
	 , ' ' AS ContactName_last_name--How to extract last name from contact name
	 , t.Address
	 , t.City
	 , t.Country
FROM dbo.t_w3_schools_customers AS t
ORDER BY 3