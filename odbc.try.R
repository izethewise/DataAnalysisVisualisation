library(RODBC) 
dbhandle <- odbcDriverConnect('driver={SQL Server};server=hp-pc\\sqlexpress;database=datava;trusted_connection=true')
res <- sqlQuery(dbhandle, 'select * from [dbo].[sum_stats_yms]')

head(res)


ggplot(res, aes(abs(5.5-month), CO)) +
  geom_point() +
  geom_smooth()

ggplot(res, aes(abs(year+month), O3)) +
  geom_point() +
  geom_smooth()

ggplot(res, aes(abs(5.5-month), SO2)) +
  geom_point() +
  geom_smooth()

ggplot(res, aes(abs(5.5-month), NO2)) +
  geom_point() +
  geom_smooth()


abs(-6)
