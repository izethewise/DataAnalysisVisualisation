


--select whole table into temp
select * into #temp1
from [dbo].[pol_orig]

--drop id col
alter table #temp1 drop column [column 0]

--count unique
select count(*) from 
(
select * from
#temp1
union
select * from
#temp1
) x
--1790054

--count all
select count(*) from #temp1
--1843511

--result is there are duplicates

select 'T1',* 
from #temp1
where  [county code] = 7
and [site num] = 2
and [Date Local] = '14/07/2014'

select 'Pol',* from pol where [Site Num] = 2
and [Date Local] = '2014-07-14'


select * 
from [pol_orig] t
where exists(
	select [Date Local]
	,[Site Num] 
	,[State Code]
	from [pol_orig] 
	where [Date Local] = t.[Date Local]
	and [Site Num] = t.[Site Num]
	and [State Code] = t.[State Code]
	group by [Date Local]
	,[Site Num]
	,[State Code]
	having count(*) > 1
)




