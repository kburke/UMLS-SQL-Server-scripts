USE [UMLS2018AA]

/************************************************************************************/
/* Unified Medical Language System - Microsoft SQL Server table creation script */
/* Script 1 of 3 */
/* */
/* This script is based upon the "SQL load script for Metathesaurus subset" (Feb 2011) of Dr. Nader Elshehabi, shared */
/* on the UMLS website in the UMLS Community - User Contributions section, and upon the */
/* Oracle scripts created during MetamorphoSys execution in the 2018AA release. */
/* https://www.nlm.nih.gov/research/umls/implementation_resources/community/dbloadscripts/metathesaurus_sql.txt */
/* */
/* Steps for using this script are:
   1. Use MetamorphoSys to create a UMLS subset folder with Rich Release Format (RRF) files.
   2. create an empty database named UMLS2018AA (or change the USE statement above to match your database name)
      2a-It is recommended to pre-size the database files and AutoGrowth characteristics of your database to
         avoid growing during the table load.
      2b-Set an appropriate recovery model for your database, particularly if you will be making it
         read-only after the load.
   3. Execute this script file to create the tables for your database.
   4. Execute the script file to load data into the tables of your database
   5. Execute the script file to add primary keys and indexes to the fully loaded tables of your database.
*/
/************************************************************************************/

/****** Creating Tables Schema by DROP and CREATE ******/

/****** DROP tables if exist first ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrcols]') AND type in (N'U'))
DROP TABLE [dbo].[mrcols]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrconso]') AND type in (N'U'))
DROP TABLE [dbo].[mrconso]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrcui]') AND type in (N'U'))
DROP TABLE [dbo].[mrcui]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrcxt]') AND type in (N'U'))
DROP TABLE [dbo].[mrcxt]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrdef]') AND type in (N'U'))
DROP TABLE [dbo].[mrdef]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrdoc]') AND type in (N'U'))
DROP TABLE [dbo].[mrdoc]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrfiles]') AND type in (N'U'))
DROP TABLE [dbo].[mrfiles]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrhier]') AND type in (N'U'))
DROP TABLE [dbo].[mrhier]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrhist]') AND type in (N'U'))
DROP TABLE [dbo].[mrhist]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrmap]') AND type in (N'U'))
DROP TABLE [dbo].[mrmap]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrrank]') AND type in (N'U'))
DROP TABLE [dbo].[mrrank]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrrel]') AND type in (N'U'))
DROP TABLE [dbo].[mrrel]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrsab]') AND type in (N'U'))
DROP TABLE [dbo].[mrsab]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrsat]') AND type in (N'U'))
DROP TABLE [dbo].[mrsat]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrsmap]') AND type in (N'U'))
DROP TABLE [dbo].[mrsmap]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrsty]') AND type in (N'U'))
DROP TABLE [dbo].[mrsty]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxns_eng]') AND type in (N'U'))
DROP TABLE [dbo].[mrxns_eng]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxnw_eng]') AND type in (N'U'))
DROP TABLE [dbo].[mrxnw_eng]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mraui]') AND type in (N'U'))
DROP TABLE [dbo].[mraui]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_baq]') AND type in (N'U'))
DROP TABLE [dbo].[mrxw_baq]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_chi]') AND type in (N'U'))
DROP TABLE [dbo].[mrxw_chi]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_cze]') AND type in (N'U'))
DROP TABLE [dbo].[mrxw_cze]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_dan]') AND type in (N'U'))
DROP TABLE [dbo].[mrxw_dan]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_dut]') AND type in (N'U'))
DROP TABLE [dbo].[mrxw_dut]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_eng]') AND type in (N'U'))
DROP TABLE [dbo].[mrxw_eng]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_est]') AND type in (N'U'))
DROP TABLE [dbo].[mrxw_est]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_fin]') AND type in (N'U'))
DROP TABLE [dbo].[mrxw_fin]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_fre]') AND type in (N'U'))
DROP TABLE [dbo].[mrxw_fre]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_ger]') AND type in (N'U'))
DROP TABLE [dbo].[mrxw_ger]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_gre]') AND type in (N'U'))
DROP TABLE [dbo].[mrxw_gre]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_heb]') AND type in (N'U'))
DROP TABLE [dbo].[mrxw_heb]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_hun]') AND type in (N'U'))
DROP TABLE [dbo].[mrxw_hun]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_ita]') AND type in (N'U'))
DROP TABLE [dbo].[mrxw_ita]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_jpn]') AND type in (N'U'))
DROP TABLE [dbo].[mrxw_jpn]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_kor]') AND type in (N'U'))
DROP TABLE [dbo].[mrxw_kor]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_lav]') AND type in (N'U'))
DROP TABLE [dbo].[mrxw_lav]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_nor]') AND type in (N'U'))
DROP TABLE [dbo].[mrxw_nor]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_pol]') AND type in (N'U'))
DROP TABLE [dbo].[mrxw_pol]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_por]') AND type in (N'U'))
DROP TABLE [dbo].[mrxw_por]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_rus]') AND type in (N'U'))
DROP TABLE [dbo].[mrxw_rus]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_scr]') AND type in (N'U'))
DROP TABLE [dbo].[mrxw_scr]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_spa]') AND type in (N'U'))
DROP TABLE [dbo].[mrxw_spa]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_swe]') AND type in (N'U'))
DROP TABLE [dbo].[mrxw_swe]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_tur]') AND type in (N'U'))
DROP TABLE [dbo].[mrxw_tur]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ambigsui]') AND type in (N'U'))
DROP TABLE [dbo].[ambigsui]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ambiglui]') AND type in (N'U'))
DROP TABLE [dbo].[ambiglui]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[deletedcui]') AND type in (N'U'))
DROP TABLE [dbo].[deletedcui]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[deletedlui]') AND type in (N'U'))
DROP TABLE [dbo].[deletedlui]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[deletedsui]') AND type in (N'U'))
DROP TABLE [dbo].[deletedsui]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mergedcui]') AND type in (N'U'))
DROP TABLE [dbo].[mergedcui]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mergedlui]') AND type in (N'U'))
DROP TABLE [dbo].[mergedlui]

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrcoc]') AND type in (N'U'))
DROP TABLE [dbo].[mrcoc]

PRINT('Done dropping tables.');

/****** CREATE tables ******/

/****** Object: Table [dbo].[mrcols] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrcols]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrcols](
[COL] [varchar](40) NULL,
[DES] [varchar](200) NULL,
[REF] [varchar](40) NULL,
[MIN_] [int] NULL,
[AV] [decimal](5, 2) NULL,
[MAX_] [int] NULL,
[FIL] [varchar](50) NULL,
[DTY] [varchar](40) NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrconso] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrconso]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrconso](
[CUI] [char](8) NOT NULL,
[LAT] [char](3) NOT NULL,
[TS] [char](1) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[STT] [varchar](3) NOT NULL,
[SUI] [varchar](10) NOT NULL,
[ISPREF] [char](1) NOT NULL,
[AUI] [varchar](9) NOT NULL,
[SAUI] [varchar](50) NULL,
[SCUI] [varchar](100) NULL,
[SDUI] [varchar](100) NULL,
[SAB] [varchar](40) NOT NULL,
[TTY] [varchar](40) NOT NULL,
[CODE] [varchar](100) NOT NULL,
[STR] [text] NOT NULL,
[SRL] [int] NOT NULL,
[SUPPRESS] [char](1) NOT NULL,
[CVF] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

/****** Object: Table [dbo].[mrcui] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrcui]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrcui](
[CUI1] [char](8) NOT NULL,
[VER] [varchar](10) NOT NULL,
[REL] [varchar](4) NOT NULL,
[RELA] [varchar](100) NULL,
[MAPREASON] [text] NULL,
[CUI2] [char](8) NULL,
[MAPIN] [char](1) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrcxt] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrcxt]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrcxt](
[CUI] [char](8) NULL,
[SUI] [varchar](10) NULL,
[AUI] [varchar](9) NULL,
[SAB] [varchar](40) NULL,
[CODE] [varchar](100) NULL,
[CXN] [int] NULL,
[CXL] [char](3) NULL,
[RANK] [int] NULL,
[CXS] [text] NULL,
[CUI2] [char](8) NULL,
[AUI2] [varchar](9) NULL,
[HCD] [varchar](100) NULL,
[RELA] [varchar](100) NULL,
[XC] [varchar](1) NULL,
[CVF] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

/****** Object: Table [dbo].[mrdef] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrdef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrdef](
[CUI] [char](8) NOT NULL,
[AUI] [varchar](9) NOT NULL,
[ATUI] [varchar](11) NOT NULL,
[SATUI] [varchar](50) NULL,
[SAB] [varchar](40) NOT NULL,
[DEF] [text] NOT NULL,
[SUPPRESS] [char](1) NOT NULL,
[CVF] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

/****** Object: Table [dbo].[mrdoc] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrdoc]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrdoc](
[DOCKEY] [varchar](50) NOT NULL,
[VALUE_] [varchar](200) NULL,
[TYPE] [varchar](50) NOT NULL,
[EXPL] [varchar](1000) NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrfiles] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrfiles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrfiles](
[FIL] [varchar](50) NULL,
[DES] [varchar](200) NULL,
[FMT] [varchar](300) NULL,
[CLS] [int] NULL,
[RWS] [int] NULL,
[BTS] [bigint] NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrhier] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrhier]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrhier](
[CUI] [char](8) NOT NULL,
[AUI] [varchar](9) NOT NULL,
[CXN] [int] NOT NULL,
[PAUI] [varchar](10) NULL,
[SAB] [varchar](40) NOT NULL,
[RELA] [varchar](100) NULL,
[PTR] [text] NULL,
[HCD] [varchar](100) NULL,
[CVF] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrhist] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrhist]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrhist](
[CUI] [char](8) NULL,
[SOURCEUI] [varchar](100) NULL,
[SAB] [varchar](40) NULL,
[SVER] [varchar](40) NULL,
[CHANGETYPE] [text] NULL,
[CHANGEKEY] [text] NULL,
[CHANGEVAL] [text] NULL,
[REASON] [text] NULL,
[CVF] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrmap] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrmap]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrmap](
[MAPSETCUI] [char](8) NOT NULL,
[MAPSETSAB] [varchar](40) NOT NULL,
[MAPSUBSETID] [varchar](10) NULL,
[MAPRANK] [int] NULL,
[MAPID] [varchar](50) NOT NULL,
[MAPSID] [varchar](50) NULL,
[FROMID] [varchar](50) NOT NULL,
[FROMSID] [varchar](50) NULL,
[FROMEXPR] [text] NOT NULL,
[FROMTYPE] [varchar](50) NOT NULL,
[FROMRULE] [text] NULL,
[FROMRES] [text] NULL,
[REL] [varchar](4) NOT NULL,
[RELA] [varchar](100) NULL,
[TOID] [varchar](50) NULL,
[TOSID] [varchar](50) NULL,
[TOEXPR] [text] NULL,
[TOTYPE] [varchar](50) NULL,
[TORULE] [text] NULL,
[TORES] [text] NULL,
[MAPRULE] [text] NULL,
[MAPRES] [text] NULL,
[MAPTYPE] [varchar](50) NULL,
[MAPATN] [varchar](100) NULL,
[MAPATV] [text] NULL,
[CVF] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrrank] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrrank]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrrank](
[RANK] [int] NOT NULL,
[SAB] [varchar](40) NOT NULL,
[TTY] [varchar](40) NOT NULL,
[SUPPRESS] [char](1) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrrel] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrrel]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrrel](
[CUI1] [char](8) NOT NULL,
[AUI1] [varchar](9) NULL,
[STYPE1] [varchar](50) NOT NULL,
[REL] [varchar](4) NOT NULL,
[CUI2] [char](8) NOT NULL,
[AUI2] [varchar](9) NULL,
[STYPE2] [varchar](50) NOT NULL,
[RELA] [varchar](100) NULL,
[RUI] [varchar](10) NOT NULL,
[SRUI] [varchar](50) NULL,
[SAB] [varchar](40) NOT NULL,
[SL] [varchar](40) NOT NULL,
[RG] [varchar](10) NULL,
[DIR] [varchar](1) NULL,
[SUPPRESS] [char](1) NOT NULL,
[CVF] [int] NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrsab] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrsab]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrsab](
[VCUI] [char](8) NULL,
[RCUI] [char](8) NULL,
[VSAB] [varchar](40) NOT NULL,
[RSAB] [varchar](40) NOT NULL,
[SON] [text] NOT NULL,
[SF] [varchar](40) NOT NULL,
[SVER] [varchar](40) NULL,
[VSTART] [char](8) NULL,
[VEND] [char](8) NULL,
[IMETA] [varchar](10) NOT NULL,
[RMETA] [varchar](10) NULL,
[SLC] [text] NULL,
[SCC] [text] NULL,
[SRL] [int] NOT NULL,
[TFR] [int] NULL,
[CFR] [int] NULL,
[CXTY] [varchar](50) NULL,
[TTYL] [varchar](400) NULL,
[ATNL] [text] NULL,
[LAT] [char](3) NULL,
[CENC] [varchar](40) NOT NULL,
[CURVER] [char](1) NOT NULL,
[SABIN] [char](1) NOT NULL,
[SSN] [text] NOT NULL,
[SCIT] [text] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrsat] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrsat]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrsat](
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NULL,
[SUI] [varchar](10) NULL,
[METAUI] [varchar](100) NULL,
[STYPE] [varchar](50) NOT NULL,
[CODE] [varchar](100) NULL,
[ATUI] [varchar](11) NOT NULL,
[SATUI] [varchar](50) NULL,
[ATN] [varchar](100) NOT NULL,
[SAB] [varchar](40) NOT NULL,
[ATV] [text] NULL,
[SUPPRESS] [char](1) NOT NULL,
[CVF] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrsmap] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrsmap]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrsmap](
[MAPSETCUI] [char](8) NOT NULL,
[MAPSETSAB] [varchar](40) NOT NULL,
[MAPID] [varchar](50) NOT NULL,
[MAPSID] [varchar](50) NULL,
[FROMEXPR] [text] NOT NULL,
[FROMTYPE] [varchar](50) NOT NULL,
[REL] [varchar](4) NOT NULL,
[RELA] [varchar](100) NULL,
[TOEXPR] [text] NULL,
[TOTYPE] [varchar](50) NULL,
[CVF] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrsty] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrsty]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrsty](
[CUI] [char](8) NOT NULL,
[TUI] [char](4) NOT NULL,
[STN] [varchar](100) NOT NULL,
[STY] [varchar](50) NOT NULL,
[ATUI] [varchar](11) NOT NULL,
[CVF] [int] NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxns_eng] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxns_eng]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxns_eng](
[LAT] [char](3) NOT NULL,
[NSTR] [text] NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxnw_eng] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxnw_eng]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxnw_eng](
[LAT] [char](3) NOT NULL,
[NWD] [varchar](100) NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mraui] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mraui]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mraui](
[AUI1] [varchar](9) NOT NULL,
[CUI1] [char](8) NOT NULL,
[VER] [varchar](10) NOT NULL,
[REL] [varchar](4) NULL,
[RELA] [varchar](100) NULL,
[MAPREASON] [text] NOT NULL,
[AUI2] [varchar](9) NOT NULL,
[CUI2] [char](8) NOT NULL,
[MAPIN] [char](1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxw_baq] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_baq]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxw_baq](
[LAT] [char](3) NOT NULL,
[WD] [varchar](200) NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxw_chi] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_chi]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxw_chi](
[LAT] [char](3) NOT NULL,
[WD] [varchar](200) NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxw_cze] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_cze]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxw_cze](
[LAT] [char](3) NOT NULL,
[WD] [varchar](200) NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxw_dan] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_dan]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxw_dan](
[LAT] [char](3) NOT NULL,
[WD] [varchar](200) NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxw_dut] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_dut]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxw_dut](
[LAT] [char](3) NOT NULL,
[WD] [varchar](200) NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxw_eng] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_eng]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxw_eng](
[LAT] [char](3) NOT NULL,
[WD] [varchar](200) NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxw_est] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_est]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxw_est](
[LAT] [char](3) NOT NULL,
[WD] [varchar](200) NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxw_fin] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_fin]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxw_fin](
[LAT] [char](3) NOT NULL,
[WD] [varchar](200) NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxw_fre] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_fre]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxw_fre](
[LAT] [char](3) NOT NULL,
[WD] [varchar](200) NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxw_ger] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_ger]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxw_ger](
[LAT] [char](3) NOT NULL,
[WD] [varchar](200) NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxw_gre] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_gre]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxw_gre](
[LAT] [char](3) NOT NULL,
[WD] [varchar](200) NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxw_heb] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_heb]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxw_heb](
[LAT] [char](3) NOT NULL,
[WD] [varchar](200) NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxw_hun] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_hun]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxw_hun](
[LAT] [char](3) NOT NULL,
[WD] [varchar](200) NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxw_ita] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_ita]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxw_ita](
[LAT] [char](3) NOT NULL,
[WD] [varchar](200) NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxw_jpn] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_jpn]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxw_jpn](
[LAT] [char](3) NOT NULL,
[WD] [varchar](500) NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxw_kor] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_kor]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxw_kor](
[LAT] [char](3) NOT NULL,
[WD] [varchar](500) NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxw_lav] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_lav]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxw_lav](
[LAT] [char](3) NOT NULL,
[WD] [varchar](500) NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxw_nor] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_nor]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxw_nor](
[LAT] [char](3) NOT NULL,
[WD] [varchar](200) NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxw_pol] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_pol]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxw_pol](
[LAT] [char](3) NOT NULL,
[WD] [varchar](200) NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxw_por] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_por]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxw_por](
[LAT] [char](3) NOT NULL,
[WD] [varchar](200) NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxw_rus] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_rus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxw_rus](
[LAT] [char](3) NOT NULL,
[WD] [varchar](200) NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxw_scr] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_scr]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxw_scr](
[LAT] [char](3) NOT NULL,
[WD] [varchar](200) NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxw_spa] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_spa]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxw_spa](
[LAT] [char](3) NOT NULL,
[WD] [varchar](200) NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxw_swe] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_swe]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxw_swe](
[LAT] [char](3) NOT NULL,
[WD] [varchar](200) NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrxw_tur] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrxw_tur]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrxw_tur](
[LAT] [char](3) NOT NULL,
[WD] [varchar](200) NOT NULL,
[CUI] [char](8) NOT NULL,
[LUI] [varchar](10) NOT NULL,
[SUI] [varchar](10) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[ambigsui] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ambigsui]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ambigsui](
[SUI] [varchar](10) NOT NULL,
[CUI] [char](8) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[ambiglui] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ambiglui]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ambiglui](
[LUI] [varchar](10) NOT NULL,
[CUI] [char](8) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[deletedcui] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[deletedcui]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[deletedcui](
[PCUI] [char](8) NOT NULL,
[PSTR] [text] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[deletedlui] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[deletedlui]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[deletedlui](
[PLUI] [varchar](10) NOT NULL,
[PSTR] [text] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[deletedsui] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[deletedsui]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[deletedsui](
[PSUI] [varchar](10) NOT NULL,
[LAT] [char](3) NOT NULL,
[PSTR] [text] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mergedcui] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mergedcui]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mergedcui](
[PCUI] [char](8) NOT NULL,
[CUI] [char](8) NOT NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mergedlui] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mergedlui]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mergedlui](
[PLUI] [varchar](10) NULL,
[LUI] [varchar](10) NULL
) ON [PRIMARY]
END

SET ANSI_PADDING OFF

/****** Object: Table [dbo].[mrcoc] ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

SET ANSI_PADDING ON

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mrcoc]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[mrcoc](
[CUI1] [char](8) NOT NULL,
[AUI1] [varchar](9) NOT NULL,
[CUI2] [char](8) NULL,
[AUI2] [varchar](9) NULL,
[SAB] [varchar](20) NOT NULL,
[COT] [varchar](3) NOT NULL,
[COF] [int] NULL,
[COA] [text] NULL,
[CVF] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

PRINT('Done creating tables.');
