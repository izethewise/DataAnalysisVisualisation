USE [DataVA]
GO

INSERT INTO [dbo].[site]
           ([State Code]
           ,[County Code]
           ,[Site Num]
           ,[Address]
           ,[State]
           ,[County]
           ,[City])
select distinct 
[State Code]
,[County Code]
,[Site Num]
,[Address]
,[State]
,[County]
,[City]
from [dbo].[pol]


INSERT INTO [dbo].[polutant]
           ([name]
           ,[units])
     VALUES
           ('NO2','Parts per billion'),
		   ('O3','Parts per million'),
		   ('SO2','Parts per billion'),
		   ('CO','Parts per million')
GO

INSERT INTO [dbo].[statistic]
           ([name])
     VALUES ('Mean'),('1st Max Value'),('1st Max Hour'),('AQI')



