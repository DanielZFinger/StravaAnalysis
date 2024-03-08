--View top 2000 rows of database
SELECT TOP 2000 *
FROM [stravaData].[dbo].[activities];
--Heart Rate Data has extra fluff attached to end of it. Lets see about removing the everything after the first 3 characters
--Start by just temporarily doing it to visualize
SELECT LEFT([Relative Effort], 3) AS Short_Relative_Effort
FROM [stravaData].[dbo].[activities]
--Above code does what I want so lets do this permanently to the database
UPDATE [stravaData].[dbo].[activities]
SET [Max Heart Rate] = LEFT([Max Heart Rate], 3)
--Awesome! This removed the fluff from my heartrate data.
--Next Lets remove Relative Effort bc I don't have any data in that column from Strava
ALTER TABLE [stravaData].[dbo].[activities]
DROP COLUMN [Relative Effort];
-- Lets also remove "Activity Description"
ALTER TABLE [stravaData].[dbo].[activities]
DROP COLUMN [Activity Description];
--Perfect now "Relative Effort" and "Activity Description" have been removed
--Next I only want 'Activity Type" of 'Run' so lets remove all other "Activity Type"(s)
-- Start by doing this temporarily
SELECT *
FROM [stravaData].[dbo].[activities]
WHERE [Activity Type] = 'Run';
--It looks all good so lets do this permanently
DELETE FROM [stravaData].[dbo].[activities]
WHERE [Activity Type] <> 'Run';
--I want to change the commas in "Activity Date" to periods
UPDATE [stravaData].[dbo].[activities]
SET [Activity Date] = REPLACE([Activity Date], ',', '.');
-- DO the same to "Activity Name"
UPDATE [stravaData].[dbo].[activities]
SET [Activity Name] = REPLACE([Activity Name], ',', '.');
--Remove all rows with "Max Heart Rate" value being blank ('')
DELETE FROM [stravaData].[dbo].[activities]
WHERE [Max Heart Rate] = '';
--All set
