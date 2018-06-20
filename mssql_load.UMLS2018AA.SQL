USE [UMLS2018AA]

/************************************************************************************/
/* Unified Medical Language System - Microsoft SQL Server data load script */
/* Script 2 of 3 */
/* */
/* This script is based upon the "SQL load script for Metathesaurus subset" (Feb 2011) of Dr. Nader Elshehabi, shared */
/* on the UMLS website in the UMLS Community - User Contributions section, and upon the */
/* Oracle scripts created during MetamorphoSys execution in the 2018AA release. */
/* https://www.nlm.nih.gov/research/umls/implementation_resources/community/dbloadscripts/metathesaurus_sql.txt */
/* */
/* See the comments of the table creation script for recommended usage */
/* */
/* To configure the value for the @AllTables variable, you may want use DOS command "dir /b *.rrf" in the */
/* directory specified by @DataFilePath. */
/************************************************************************************/

/****** Declaring variables that will be used in loading data ******/
DECLARE @DataFilePath NVARCHAR(500);
DECLARE @AllTables NVARCHAR(500);
DECLARE @ChangeTables NVARCHAR(500);
DECLARE @CurrentFile NVARCHAR(500);
DECLARE @CurrentPosition INT;
DECLARE @CurrentTable NVARCHAR(500);
DECLARE @statement NVARCHAR(500);

/* Change this path to the root folder of your metathesaurus e.g. N'D:\UMLS\2010AA\META' */
SET @DataFilePath = N'\\win.ad.jhu.edu\...\umls-2018AA-full\KBSubset20180521'

/****** Comma separated list of table names which are mapped to RRF files in the path mentioned above ******/
SET @AllTables = N'AMBIGLUI,AMBIGSUI,MRAUI,MRCOLS,MRCONSO,MRCUI,MRDEF,MRDOC,MRFILES,MRHIER,MRHIST,MRMAP,MRRANK,MRREL,MRSAB,MRSAT,MRSMAP,MRSTY,MRXNS_ENG,MRXNW_ENG,MRXW_BAQ,MRXW_CHI,MRXW_CZE,MRXW_DAN,MRXW_DUT,MRXW_ENG,MRXW_EST,MRXW_FIN,MRXW_FRE,MRXW_GER,MRXW_GRE,MRXW_HEB,MRXW_HUN,MRXW_ITA,MRXW_JPN,MRXW_KOR,MRXW_LAV,MRXW_NOR,MRXW_POL,MRXW_POR,MRXW_RUS,MRXW_SCR,MRXW_SPA,MRXW_SWE,MRXW_TUR'

/****** Tables mapped to files under CHANGE subfolder ******/
SET @ChangeTables = N'deletedcui,deletedlui,deletedsui,mergedcui,mergedlui'

/****** Inserting data into tables ******/

if right(rtrim(@AllTables),1) <> ','
set @AllTables = @AllTables + ','
set @CurrentPosition = patindex('%,%' , @AllTables)
while @CurrentPosition <> 0
begin

set @CurrentTable = left(@AllTables, @CurrentPosition - 1);
set @AllTables = stuff(@AllTables, 1, @CurrentPosition, '');
set @CurrentPosition = patindex('%,%' , @AllTables);
SET @CurrentFile = @DataFilePath + N'\' + @CurrentTable + N'.rrf';
SET @statement = N'
BULK INSERT [' + @CurrentTable + N'] FROM ''' + @CurrentFile + N'''
WITH (FIELDTERMINATOR =''|'', ROWTERMINATOR = ''|\n'')
';

PRINT('Executing command ' + @statement);

EXEC dbo.sp_executesql @statement;
END

/****** Inserting data into change tables ******/

if right(rtrim(@ChangeTables),1) <> ','
set @ChangeTables = @ChangeTables + ','
set @CurrentPosition = patindex('%,%' , @ChangeTables)

while @CurrentPosition <> 0
begin

set @CurrentTable = left(@ChangeTables, @CurrentPosition - 1);
set @ChangeTables = stuff(@ChangeTables, 1, @CurrentPosition, '');
set @CurrentPosition = patindex('%,%' , @ChangeTables);
SET @CurrentFile = @DataFilePath + N'\change\' + @CurrentTable + N'.rrf';

SET @statement = N'
BULK INSERT [' + @CurrentTable + N'] FROM ''' + @CurrentFile + N'''
WITH (FIELDTERMINATOR =''|'', ROWTERMINATOR = ''|\n'')
';

PRINT('Executing command ' + @statement);

EXEC dbo.sp_executesql @statement;
END

PRINT('FINISHED WITH BULK LOAD LOOP');

--BULK INSERT [mrsat] FROM 'U:\users\kburke23\UMLS\2016AB-active\kbSubsetForCCDADec2016\2016AB\META\MRSAT.RRF.problem_lines_Jan2017'
--WITH (FIELDTERMINATOR ='|', ROWTERMINATOR = '|\n')
--
--PRINT('DONE EXECUTING JHU ROWS INTO MRSAT TO REPLACE ERROR ROWS OF BULK LOAD');
