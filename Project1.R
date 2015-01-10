######
##libraries
library(dplyr)

getwd()


#on campus
#setwd("I:\\My Data Sources\\mooc\\explore")

#on latitude
#setwd("/home/brian/Projects/Coursera/Explore")


fileUrl <- 'http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
if (!file.exists("data")) {
  dir.create("data")
}

# Check if data already exists; if not, download it.
if (!file.exists('./data/household_power_consumption.zip')) {
    download.file(fileUrl, './data/household_power_consumption.zip', method='wget')
  }
unzip('./data/household_power_consumption.zip',exdir="./data")

######
##Read in data  Must decide whether to filter by specific dates
#####

####Read random sample to get file structure
temp<-read.csv("./data/household_power_consumption.txt",header=T,sep=";",nrows=20,skip=3)
colnames(temp)<-c(
  "Date",
  "Time",
  "Global_active_power",
  "Global_reactive_power",
  "Voltage",
  "Global_intensity",
  "Sub_metering_1",
  "Sub_metering_2",
  "Sub_metering_3"
)

head(temp)
str(temp)
grep("2007",temp$Date )


full<-read.csv("./data/household_power_consumption.txt",header=T,sep=";")

