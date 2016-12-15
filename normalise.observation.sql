declare @StateCode float
declare @CountyCode float
declare @SiteNum float
declare @Address nvarchar(255)
declare @State nvarchar(255)
declare @County nvarchar(255)
declare @City nvarchar(255)
declare @DateLocal datetime
declare @NO2Units nvarchar(255)
declare @NO2Mean float
declare @NO21stMaxValue float
declare @NO21stMaxHour float
declare @NO2AQI float
declare @O3Units nvarchar(255)
declare @O3Mean float
declare @O31stMaxValue float
declare @O31stMaxHour float
declare @O3AQI float
declare @SO2Units nvarchar(255)
declare @SO2Mean float
declare @SO21stMaxValue float
declare @SO21stMaxHour float
declare @SO2AQI nvarchar(255)
declare @COUnits nvarchar(255)
declare @COMean float
declare @CO1stMaxValue float
declare @CO1stMaxHour float
declare @COAQI nvarchar(255) 

declare @date_local	datetime
declare @site int
declare @polutant nvarchar(20)
declare @statistic nvarchar(20)
declare @value float

declare @obsID int

set @obsID = 0


declare c_pol cursor for select * from pol
open c_pol 
fetch next from c_pol into
	@StateCode,
	@CountyCode,
	@SiteNum,
	@Address,
	@State,
	@County,
	@City,
	@DateLocal,
	@NO2Units,
	@NO2Mean,
	@NO21stMaxValue,
	@NO21stMaxHour,
	@NO2AQI,
	@O3Units,
	@O3Mean,
	@O31stMaxValue,
	@O31stMaxHour,
	@O3AQI,
	@SO2Units,
	@SO2Mean,
	@SO21stMaxValue,
	@SO21stMaxHour,
	@SO2AQI,
	@COUnits,
	@COMean,
	@CO1stMaxValue,
	@CO1stMaxHour,
	@COAQI
while @@FETCH_STATUS = 0
begin

set @obsID = @obsID + 1

set @date_local	= @DateLocal
select @site = ID from site where [Address] = @Address
set @polutant = 'NO2'
set @statistic = 'Mean'
set @value = @NO2Mean

INSERT INTO [dbo].[observationT](OrigID,[date_local],[site],[polutant],[statistic],[value])
VALUES (@obsID,@date_local,@site,@polutant,@statistic,@value)
--***

set @date_local	= @DateLocal
select @site = ID from site where [Address] = @Address
set @polutant = 'NO2'
set @statistic = '1st Max Value'
set @value = @NO21stMaxValue

INSERT INTO [dbo].[observationT](OrigID,[date_local],[site],[polutant],[statistic],[value])
VALUES (@obsID,@date_local,@site,@polutant,@statistic,@value)
--***
set @date_local	= @DateLocal
select @site = ID from site where [Address] = @Address
set @polutant = 'NO2'
set @statistic = '1st Max Hour'
set @value = @NO21stMaxHour

INSERT INTO [dbo].[observationT](OrigID,[date_local],[site],[polutant],[statistic],[value])
VALUES (@obsID,@date_local,@site,@polutant,@statistic,@value)
--***

set @date_local	= @DateLocal
select @site = ID from site where [Address] = @Address
set @polutant = 'NO2'
set @statistic = 'AQI'
set @value = @NO2AQI

INSERT INTO [dbo].[observationT](OrigID,[date_local],[site],[polutant],[statistic],[value])
VALUES (@obsID,@date_local,@site,@polutant,@statistic,@value)
--***

set @date_local	= @DateLocal
select @site = ID from site where [Address] = @Address
set @polutant = 'O3'
set @statistic = 'Mean'
set @value = @O3Mean

INSERT INTO [dbo].[observationT](OrigID,[date_local],[site],[polutant],[statistic],[value])
VALUES (@obsID,@date_local,@site,@polutant,@statistic,@value)
--***

set @date_local	= @DateLocal
select @site = ID from site where [Address] = @Address
set @polutant = 'O3'
set @statistic = '1st Max Value'
set @value = @O31stMaxValue

INSERT INTO [dbo].[observationT](OrigID,[date_local],[site],[polutant],[statistic],[value])
VALUES (@obsID,@date_local,@site,@polutant,@statistic,@value)
--***

set @date_local	= @DateLocal
select @site = ID from site where [Address] = @Address
set @polutant = 'O3'
set @statistic = '1st Max Hour'
set @value = @O31stMaxHour

INSERT INTO [dbo].[observationT](OrigID,[date_local],[site],[polutant],[statistic],[value])
VALUES (@obsID,@date_local,@site,@polutant,@statistic,@value)
--***

set @date_local	= @DateLocal
select @site = ID from site where [Address] = @Address
set @polutant = 'O3'
set @statistic = 'AQI'
set @value = @O3AQI

INSERT INTO [dbo].[observationT](OrigID,[date_local],[site],[polutant],[statistic],[value])
VALUES (@obsID,@date_local,@site,@polutant,@statistic,@value)
--***

set @date_local	= @DateLocal
select @site = ID from site where [Address] = @Address
set @polutant = 'SO2'
set @statistic = 'Mean'
set @value = @SO2Mean

INSERT INTO [dbo].[observationT](OrigID,[date_local],[site],[polutant],[statistic],[value])
VALUES (@obsID,@date_local,@site,@polutant,@statistic,@value)
--***

set @date_local	= @DateLocal
select @site = ID from site where [Address] = @Address
set @polutant = 'SO2'
set @statistic = '1st Max Value'
set @value = @SO21stMaxValue

INSERT INTO [dbo].[observationT](OrigID,[date_local],[site],[polutant],[statistic],[value])
VALUES (@obsID,@date_local,@site,@polutant,@statistic,@value)
--***

set @date_local	= @DateLocal
select @site = ID from site where [Address] = @Address
set @polutant = 'SO2'
set @statistic = '1st Max Hour'
set @value = @SO21stMaxHour

INSERT INTO [dbo].[observationT](OrigID,[date_local],[site],[polutant],[statistic],[value])
VALUES (@obsID,@date_local,@site,@polutant,@statistic,@value)
--***

if @SO2AQI = 'NA' set @SO2AQI = NULL
set @date_local	= @DateLocal
select @site = ID from site where [Address] = @Address
set @polutant = 'SO2'
set @statistic = 'AQI'
set @value = @SO2AQI

INSERT INTO [dbo].[observationT](OrigID,[date_local],[site],[polutant],[statistic],[value])
VALUES (@obsID,@date_local,@site,@polutant,@statistic,@value)
--***


set @date_local	= @DateLocal
select @site = ID from site where [Address] = @Address
set @polutant = 'CO'
set @statistic = 'Mean'
set @value = @COMean

INSERT INTO [dbo].[observationT](OrigID,[date_local],[site],[polutant],[statistic],[value])
VALUES (@obsID,@date_local,@site,@polutant,@statistic,@value)
--***

set @date_local	= @DateLocal
select @site = ID from site where [Address] = @Address
set @polutant = 'CO'
set @statistic = '1st Max Value'
set @value = @CO1stMaxValue

INSERT INTO [dbo].[observationT](OrigID,[date_local],[site],[polutant],[statistic],[value])
VALUES (@obsID,@date_local,@site,@polutant,@statistic,@value)
--***

set @date_local	= @DateLocal
select @site = ID from site where [Address] = @Address
set @polutant = 'CO'
set @statistic = '1st Max Hour'
set @value = @CO1stMaxHour

INSERT INTO [dbo].[observationT](OrigID,[date_local],[site],[polutant],[statistic],[value])
VALUES (@obsID,@date_local,@site,@polutant,@statistic,@value)
--***

if @COAQI = 'NA' set @COAQI = NULL
set @date_local	= @DateLocal
select @site = ID from site where [Address] = @Address
set @polutant = 'CO'
set @statistic = 'AQI'
set @value = @COAQI

INSERT INTO [dbo].[observationT](OrigID,[date_local],[site],[polutant],[statistic],[value])
VALUES (@obsID,@date_local,@site,@polutant,@statistic,@value)


fetch next from c_pol into
	@StateCode,
	@CountyCode,
	@SiteNum,
	@Address,
	@State,
	@County,
	@City,
	@DateLocal,
	@NO2Units,
	@NO2Mean,
	@NO21stMaxValue,
	@NO21stMaxHour,
	@NO2AQI,
	@O3Units,
	@O3Mean,
	@O31stMaxValue,
	@O31stMaxHour,
	@O3AQI,
	@SO2Units,
	@SO2Mean,
	@SO21stMaxValue,
	@SO21stMaxHour,
	@SO2AQI,
	@COUnits,
	@COMean,
	@CO1stMaxValue,
	@CO1stMaxHour,
	@COAQI
end
close c_pol
deallocate c_pol



