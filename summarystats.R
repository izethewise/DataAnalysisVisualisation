# Set up libraries.
library(ggplot2)
library(readr)
library(sqldf)
library(RH2)
library(grid)
library(gridExtra)


p1 <- ggplot(data=pol) + aes(x=`NO2 Mean`) + geom_histogram(binwidth=max(pol$`NO2 Mean`)/80) + scale_x_continuous(limits = c(-5, 45))
p2 <- ggplot(data=pol) + aes(x=`O3 Mean`) + geom_histogram(binwidth=max(pol$`O3 Mean`)/100) + scale_x_continuous(limits = c(-0.01, 0.06))
p3 <- ggplot(data=pol) + aes(x=`SO2 Mean`) + geom_histogram(binwidth=max(pol$`SO2 Mean`)/100) + scale_x_continuous(limits = c(-1, 15))
p4 <- ggplot(data=pol) + aes(x=`CO Mean`) + geom_histogram(binwidth=max(pol$`CO Mean`)/100) + scale_x_continuous(limits = c(-0.1, 1))
grid.arrange(p1, p2, p3, p4)


max(pol$`NO2 Mean`)
# Read in dataset.
pol <- read_csv("US_pollution_sample.csv", 
                col_types = cols('Date Local' = col_date(format = "%Y-%m-%d"), 
                                 'NO2 1st Max Value' = col_double()))

#summary(pol)

# Add derived variables.
pol$unqref <- paste(as.character(pol$`State Code`),as.character(pol$`Site Num`))
pol$unqsite <- paste(as.character(pol$`County`),as.character(pol$`State`), sep=", ")
pol$unqsitemul <- paste(as.character(pol$`County`),as.character(pol$`State`), sep="\n")
pol$urban <- !(pol$City=="Not in a city")
pol$year <- as.integer(format(pol$`Date Local`,'%Y'))
pol$month <- as.integer(format(pol$`Date Local`,'%m'))


# Dedup dataset.
pol <- unique(pol[!is.na(pol$`CO AQI`) & !is.na(pol$`SO2 AQI`),])


unique(pol$unqsite)
unique(pol$urban)
unique(pol$month)
unique(pol$year)
View(pol)

# Check missing dates.
length(unique(pol$`Date Local`)) # 2312
dates = c("2010-01-01", "2016-04-30")
round(difftime(dates[2], dates[1], units = "days")) # 2311 - no missing dates.

# Do box plots of means by site.
N02.plot <- ggplot(data=pol) + aes(reorder(unqsitemul,`NO2 Mean`),`NO2 Mean`) 
N02.plot + geom_boxplot(aes(fill = factor(urban))) + facet_wrap(~month,scales="free")


O3.plot <- ggplot(data=pol) + aes(reorder(unqsite,`O3 Mean`),`O3 Mean`)
O3.plot + geom_boxplot(aes(fill = factor(urban)))

SO2.plot <- ggplot(data=pol) + aes(reorder(unqsite,`SO2 Mean`),`SO2 Mean`)
SO2.plot + geom_boxplot(aes(fill = factor(urban)))

CO.plot <- ggplot(data=pol) + aes(reorder(unqsite,`CO Mean`),`CO Mean`)
CO.plot + geom_boxplot(aes(fill = factor(urban)))

# # Do box plots of means by urban.
# N02.plot <- ggplot(data=pol) + aes(x=urban,y=`NO2 Mean`)
# N02.plot + geom_boxplot()
# 
# O3.plot <- ggplot(data=pol) + aes(x=urban,y=`O3 Mean`)
# O3.plot + geom_boxplot()
# 
# SO2.plot <- ggplot(data=pol) + aes(x=urban,y=`SO2 Mean`)
# SO2.plot + geom_boxplot()
# 
# CO.plot <- ggplot(data=pol) + aes(x=urban,y=`CO Mean`)
# CO.plot + geom_boxplot()

# Do dot plots of polutant by date.
#ds <- unique(subset(pol, select=c("Date Local","CO Mean")))
#ggplot(unique(pol[ds$`CO Mean`>0,]), aes(x=`Date Local`,y=`CO Mean`)) + geom_point()

ggplot(pol, aes(x=`Date Local`,y=`NO2 Mean`)) + geom_point(aes(colour = factor(urban),alpha = 100)) + facet_wrap(~unqsite,scales="free")
ggplot(pol, aes(x=`Date Local`,y=`O3 Mean`)) + geom_point(aes(colour = factor(urban))) + facet_wrap(~unqsite,scales="free")
ggplot(pol, aes(x=`Date Local`,y=`SO2 Mean`)) + geom_point(aes(colour = factor(urban))) + facet_wrap(~unqsite,scales="free")
ggplot(pol, aes(x=`Date Local`,y=`CO Mean`)) + geom_point(aes(colour = factor(urban))) + facet_wrap(~unqsite,scales="free")

ggplot(pol, aes(x=`Date Local`,y=`CO Mean`)) + geom_line(aes(colour = factor(urban))) + facet_wrap(~unqsite,scales="free")

# Do box plots for polutant by month.
ggplot(data=pol) + aes(reorder(month,`NO2 Mean`),`NO2 Mean`) + geom_boxplot() + scale_x_discrete(limits=unique(pol$month))

O3.plot <- ggplot(data=pol) + aes(reorder(month,`O3 Mean`),`O3 Mean`)
O3.plot + geom_boxplot(aes(fill = factor(urban))) + scale_x_discrete(limits=unique(pol$month))

SO2.plot <- ggplot(data=pol[pol$`SO2 Mean`>0,]) + aes(reorder(month,log10(`SO2 Mean`)),log10(`SO2 Mean`))
SO2.plot + geom_boxplot(aes(fill = factor(urban))) + scale_x_discrete(limits=unique(pol$month))# + scale_y_log10()

CO.plot <- ggplot(data=pol[pol$`CO Mean`>0,]) + aes(reorder(month,`CO Mean`),`CO Mean`)
CO.plot + geom_boxplot(aes(fill = factor(urban))) + scale_x_discrete(limits=unique(pol$month))


# Create the regression model.
result <- aov(`NO2 Mean`~unqsite*month,data = pol)
print(summary(result))
result <- aov(`O3 Mean`~unqsite*month,data = pol)
print(summary(result))
result <- aov(`SO2 Mean`~unqsite*month,data = pol)
print(summary(result))
result <- aov(`CO Mean`~unqsite*month,data = pol)
print(summary(result))

# line plots of max hour
ggplot(pol, aes(x=`Date Local`,y=`NO2 1st Max Hour`)) + geom_line()# + facet_wrap(~unqsite,scales="free")
ggplot(pol, aes(x=`Date Local`,y=`O3 1st Max Hour`)) + geom_line() #+ facet_wrap(~unqsite,scales="free")
ggplot(pol, aes(x=`Date Local`,y=`SO2 1st Max Hour`)) + geom_line()# + facet_wrap(~unqsite,scales="free")
ggplot(pol, aes(x=`Date Local`,y=`CO 1st Max Hour`)) + geom_line() #+ facet_wrap(~unqsite,scales="free")


# dot plots of max hour
ggplot(pol, aes(x=`Date Local`,y=`NO2 1st Max Hour`)) + geom_point(aes(alpha = 100)) + facet_wrap(~unqsite,scales="free")
ggplot(pol, aes(x=`Date Local`,y=`O3 1st Max Hour`)) + geom_point(aes(alpha = 100)) + facet_wrap(~unqsite,scales="free")
ggplot(pol, aes(x=`Date Local`,y=`SO2 1st Max Hour`)) + geom_point(aes(alpha = 100)) + facet_wrap(~unqsite,scales="free")
ggplot(pol, aes(x=`Date Local`,y=`CO 1st Max Hour`)) + geom_point(aes(alpha = 100)) + facet_wrap(~unqsite,scales="free")


ggplot(pol, aes(x=`NO2 1st Max Value`,y=1/`O3 1st Max Value`)) + geom_point(aes(alpha = 100)) + facet_wrap(~unqsite,scales="free")


# box plots of max hour
ggplot(pol, aes(x=month,y=`NO2 1st Max Hour`)) + geom_boxplot(aes(group=month)) + facet_wrap(~unqsite,scales="free")
ggplot(pol, aes(x=month,y=`O3 1st Max Hour`)) + geom_boxplot(aes(group=month)) + facet_wrap(~unqsite,scales="free")
ggplot(pol, aes(x=month,y=`SO2 1st Max Hour`)) + geom_boxplot(aes(group=month)) + facet_wrap(~unqsite,scales="free")
ggplot(pol, aes(x=month,y=`CO 1st Max Hour`)) + geom_boxplot(aes(group=month)) + facet_wrap(~unqsite,scales="free")

ggplot(data=pol) + aes(x=`NO2 Mean`) + geom_histogram(binwidth=0.2)

sqldf("select top 100 `NO2 Mean` from pol")

ggplot(data=pol) + aes(x=`SO2 Mean`) + geom_histogram(binwidth=0.5)


div <- 500
bw <- max(pol$`CO Mean`)/div
p1 <- ggplot(data=pol) + aes(x=`CO Mean`) + geom_histogram(binwidth=bw) #+ scale_x_continuous(limits = c(-.1, 1.2))
p2 <- ggplot(data=pol) + aes(x=`CO 1st Max Value`) + geom_histogram(binwidth=.1) + scale_x_continuous(limits = c(-.1, 1.5))
bw <- max(pol$`CO AQI`)/div
p3 <- ggplot(data=pol) + aes(x=`CO AQI`) + geom_bar()
p4 <- ggplot(data=pol) + aes(x=`CO 1st Max Hour`) + geom_bar()
grid.arrange(p1, p2, p3, p4)
