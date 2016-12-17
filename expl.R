# Set up libraries.
library(ggplot2)
library(readr)
library(sqldf)
library(RH2)

# Read in dataset.
pol <- read_csv("US_pollution_sample.csv", 
                                 col_types = cols('Date Local' = col_date(format = "%Y-%m-%d"), 
                                 'NO2 1st Max Value' = col_double(),
                                 'State Code' = col_factor()))
# Create unique site ref.
str(pol)
pol$unqref <- paste(as.character(pol$`State Code`),as.character(pol$`Site Num`))
View(pol)
pol <- unique(pol)


# Filter out zero N02 as zero seems unlikely.
DS_N02 <- pol[pol$`NO2 Mean`>0,]

# Get boxplot of N02.
N02.plot <- ggplot(data=DS_N02) + aes(x=as.factor(`Site Num`),y=`NO2 Mean`)
N02.plot + geom_boxplot()

# Outlier pattern indicates skew for every site.
# Do freq histogram at one site to see what distribution looks like.
DS_N02_S2 <- DS_N02[DS_N02$`Site Num`==2,] 
N02_S2.plot <- ggplot(data=DS_N02_S2) + aes(x=`NO2 Mean`)
N02_S2.plot + geom_histogram()

# It's possible there's a time effect on the N02 so see how concentration varies by date.
N02_S2.plot <- ggplot(data=DS_N02_S2) + aes(x=`Date Local` ,y=`NO2 Mean`)
N02_S2.plot + geom_line()

# Site 2 indicates a potential seasonal variation.
# See if this is observed at other sites.
DS_N02_S3001 <- DS_N02[DS_N02$`Site Num`==3001,] 
N02_S3001.plot <- ggplot(data=DS_N02_S3001) + aes(x=`Date Local` ,y=`NO2 Mean`)
N02_S3001.plot + geom_line()

# Similar seasonal pattern is observed at 3001


# Perform similar analysis on C0.
DS_C0 <- pol[pol$`CO Mean`>0,]
DS_C0_S2 <- DS_C0[DS_C0$`Site Num`==2,] 
C0_S2.plot <- ggplot(data=DS_C0_S2) + aes(x=`CO Mean`)
C0_S2.plot + geom_histogram()
C0_S2.plot <- ggplot(data=DS_C0_S2) + aes(x=`Date Local` ,y=`CO Mean`)
C0_S2.plot + geom_line()

# Similar pattern observed for C0

# Take one site and two years of C0 2013/2014 site 2
DS_C0_S2_1415 <- DS_C0[DS_C0$`Date Local` >= as.Date("2014-05-01") & DS_C0$`Date Local` <= as.Date("2014-08-31"),]
C0_S2.plot <- ggplot(data=DS_C0_S2_1415) + aes(x=`Date Local` ,y=`CO Mean`)
C0_S2.plot + geom_line()

# It looks as though there might be two mean values per day coming through so investigate further.
jul <- pol[pol$`Date Local` >= as.Date("2014-07-01") & pol$`Date Local` <= as.Date("2014-07-31"),]
jul <- jul[jul$`Site Num`==2,]
C0_S2.plot <- ggplot(data=jul) + aes(x=`Date Local` ,y=`CO Mean`)
C0_S2.plot + geom_line()
View(jul)

C0.plot <- ggplot(data=DS_C0) + aes(x=as.factor(`Site Num`),y=`CO Mean`)
C0.plot + geom_boxplot()

unique(pol$`O3 AQI`)


unique(pol)
