#######
##libraries
#######
library(data.table)
library(tidyr)
library(dplyr)
library(lubridate)
library(ggplot2)
getwd()


#on campus
#setwd("I:\\My Data Sources\\mooc\\explore")

#on latitude
#setwd("/home/brian/Projects/Coursera/Explore")

#ondater
#setwd("/home/brian/Projects/Coursera/Explore")


fileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
if (!file.exists("data")) {
  dir.create("data")
}

# Check if data already exists; if not, download it.
if (!file.exists('./data/Emmissions.zip')) {
    download.file(fileUrl, './data/Emmissions.zip', method='wget')
  }
unzip('./data/Emmissions.zip',exdir="./data")


######
##Read in data  Must decide whether to filter by specific conditions
#####

###########
#This will take some processing time
###########


NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
str(SCC)
summary(SCC)
str(NEI)
summary(NEI)

table(NEI$year)

NEI$year<-strptime(NEI$year,format = "%Y", tz="UTC")
NEI$year<-year(NEI$year)


####Is there a way to make this open just the correct fips?

####Read random sample to get file structure
power <- fread('grep "^[12]/2/2007" ./data/household_power_consumption.txt',na.strings="?")
temp<-read.csv("./data/household_power_consumption.txt", header = TRUE, sep=";", nrows=20)



###########
#This will take some processing time
###########
