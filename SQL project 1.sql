/****Task II: Write and execute queries to analyze the data****/
/*Problem 1*/
/*Find the total number of crimes recorded in the CRIME table.*/
SELECT COUNT(DISTINCT case_number) AS total_crime FROM chicago_crime_data;
/*Counting rows will give the same result as there are no duplicates*/
SELECT COUNT(*) total_rows FROM chicago_crime_data;

/*Problem 2
Retrieve first 10 rows from the CRIME table.*/
SELECT* FROM chicago_crime_data LIMIT 10;

/*Problem 3
How many crimes involve an arrest */
SELECT COUNT(*) AS crimes_with_arrest 
FROM chicago_crime_data 
WHERE arrest = 'TRUE';

/*Problem 4
Which unique types of crimes have been recorded at GAS STATION locations?*/
SELECT DISTINCT PRIMARY_TYPE, LOCATION_DESCRIPTION 
FROM chicago_crime_data 
WHERE LOCATION_DESCRIPTION 
LIKE '%Gas station%';

/*Problem 5

In the CENUS_DATA table list all Community Areas whose names start with the letter ‘B’. */
SELECT community_area_name 
FROM CENSUS_DATA 
WHERE community_area_name 
LIKE 'b%';

/* Problem 6

Which schools in Community Areas 10 to 15 are healthy school certified?*/
-- Sometimes it’s hard to find the exact column names and which table have this column, 
-- so we can find the column names and the table with query like below:
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME LIKE '%area%'
ORDER BY TABLE_NAME ;
-- Query for problem 6
SELECT name_of_school 
FROM CHICAGO_PUBLIC_SCHOOLS 
WHERE Healthy_School_Certified = 'Yes' 
AND Community_Area_Number 
BETWEEN 10 AND 15;

/* Problem 7

What is the average school Safety Score*/
/*Rounded the figure to 2 decimals.*/
SELECT ROUND(AVG(Safety_Score),2)AS avg_sfety_score 
FROM CHICAGO_PUBLIC_SCHOOLS ;

/* Problem 8

List the top 5 Community Areas by average College Enrollment [number of students] */
SELECT  Community_Area_Name, AVG(College_Enrollment) AS AVG_ENROLLMENT 
FROM CHICAGO_PUBLIC_SCHOOLS
GROUP BY Community_Area_Name 
ORDER BY AVG_ENROLLMENT DESC 
LIMIT 5;

/*Problem 9
Use a sub-query to determine which Community Area has the least value for school Safety Score? */
SELECT COMMUNITY_AREA_NAME, safety_score 
FROM chicago_public_schools 
WHERE  safety_score=(SELECT min(safety_score)
FROM chicago_public_schools);
-- I found out there are blanks in above query so i used alternate query first checked the distinct value
SELECT DISTINCT safety_score 
FROM chicago_public_schools 
ORDER BY safety_score ; 
-- I found 1 the least value
SELECT COMMUNITY_AREA_NAME, safety_score 
FROM (SELECT COMMUNITY_AREA_NAME, safety_score
FROM chicago_public_schools WHERE safety_score =1) school;
desc chicago_public_schools;



/*Problem 10
[Without using an explicit JOIN operator] Find the Per Capita Income of the Community Area which has a school Safety Score of 1.*/
SELECT cs.COMMUNITY_AREA_NAME, cs.COMMUNITY_AREA_NUMBER, PER_CAPITA_INCOME 
FROM census_data cd, chicago_public_schools cs 
WHERE cs.COMMUNITY_AREA_NUMBER=cd.COMMUNITY_AREA_NUMBER AND safety_score=1;
/*Alternate query with JOIN  operator*/
SELECT  cs.COMMUNITY_AREA_NAME, cs.COMMUNITY_AREA_NUMBER, PER_CAPITA_INCOME 
FROM census_data cd
JOIN chicago_public_schools cs 
/*Column name same hence using USING instead of ON*/
USING(COMMUNITY_AREA_NUMBER) 
WHERE  safety_score=1;




