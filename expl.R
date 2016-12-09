library(ggplot2)
library(readr)
US_pollution_sample <- read_csv("~/DataVisualisationAssessment/US_pollution_sample.csv", 
                                 col_types = cols('Date Local' = col_date(format = "%Y-%m-%d"), 
                                 'NO2 1st Max Value' = col_double()))
