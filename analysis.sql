

select * 
into #temp
from pol
union
select * from pol

select * from #temp where [Site Num] = 2
and [Date Local] = '2014-07-14'

select * 
from #temp t
where exists(
	select [Date Local]
	,[Site Num] 
	from #temp 
	where [Date Local] = t.[Date Local]
	and [Site Num] = t.[Site Num]
	group by



select * from pol where [Site Num] = 2
and [Date Local] = '2014-07-14' 

select distinct [state code],[county code],[site num],[state],[county],[city] from pol


select [SO2 AQI],count(*)
from pol
group by [SO2 AQI]
with rollup
--NA 25502/51034

select [CO AQI],count(*)
from pol
group by [CO AQI]
with rollup
--NA 25513/51034

select [address], [date local] 
from pol 
where [SO2 AQI] <> 'NA' 
and [CO AQI] <> 'NA'
group by [address], [date local] 
having count(*) > 1

 

select[date local] as x, * from pol 
where address = 'E. 14TH & ORANGE'
and [SO2 AQI] <> 'NA' 
and [CO AQI] <> 'NA'
order by [date local]







