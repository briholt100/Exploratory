#######
##libraries
#######
library(data.table)
library(tidyr)
library(dplyr)
library(lubridate)

getwd()


#on campus
#setwd("I:\\My Data Sources\\mooc\\explore")

#on latitude
#setwd("/home/brian/Projects/Coursera/Explore")

#ondater
#setwd("/home/brian/Projects/Coursera/Explore")


fileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
if (!file.exists("data")) {
  dir.create("data")
}

# Check if data already exists; if not, download it.
if (!file.exists('./plot1/data/household_power_consumption.zip')) {
    download.file(fileUrl, './plot1/data/household_power_consumption.zip', method='wget')
  }
unzip('./plot1/data/household_power_consumption.zip',exdir="./plot1/data")

######
##Read in data  Must decide whether to filter by specific dates
#####

####Read random sample to get file structure
power <- fread('grep "^[12]/2/2007" ./data/household_power_consumption.txt',na.strings="?")
temp<-read.csv("./data/household_power_consumption.txt", header = TRUE, sep=";", nrows=20)



###########
#This will take some processing time
###########

full<-read.csv("./data/household_power_consumption.txt",header=T,sep=";", na.strings=c("?",""))
full$Date<-dmy(full$Date)

###########
#This will take some processing time
###########


full$DateTime<-paste(full$Date,full$Time)
full$DateTime<-ymd_hms(full$DateTime)

###########
#This will take some processing time
###########

useDates<-grep("2007-02-01|2007-02-02",full$DateTime, value=F )
df<-full[useDates,]


"For each plot you should

Construct the plot and save it to a PNG file with a width of 480 pixels
and a height of 480 pixels.

Name each of the plot files as plot1.png, plot2.png, etc.

Create a separate R code file (plot1.R, plot2.R, etc.) that constructs 
the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. 
Your code file should include code for reading the data so that the plot can 
be fully reproduced. You should also include the code that creates the PNG file.

Add the PNG file and R code file to your git repository"


#####
#PLOT 1
#####

"Add the PNG file and R code file to your git repository"

df$Global_active_power<-as.numeric(df$Global_active_power)
if (!file.exists("images")) {
  dir.create("images")
}

  hist1<-hist(df$Global_active_power, col="red",
            main="Global Active Power",
            xlab="Global Active Power (kilowatts)")


dev.copy(png, file = "./plot1/images/plot1.png", width = 480, height =480)  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!


#####
#PLOT 2
#####
"For each plot you should

Construct the plot and save it to a PNG file with a width of 480 pixels
and a height of 480 pixels.

Name each of the plot files as plot1.png, plot2.png, etc.

Create a separate R code file (plot1.R, plot2.R, etc.) that constructs 
the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. 
Your code file should include code for reading the data so that the plot can 
be fully reproduced. You should also include the code that creates the PNG file.

Add the PNG file and R code file to your git repository"

#####
#PLOT 3
#####
"For each plot you should

Construct the plot and save it to a PNG file with a width of 480 pixels
and a height of 480 pixels.

Name each of the plot files as plot1.png, plot2.png, etc.

Create a separate R code file (plot1.R, plot2.R, etc.) that constructs 
the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. 
Your code file should include code for reading the data so that the plot can 
be fully reproduced. You should also include the code that creates the PNG file.

Add the PNG file and R code file to your git repository"

#####
#PLOT 4
#####

"For each plot you should

Construct the plot and save it to a PNG file with a width of 480 pixels
and a height of 480 pixels.

Name each of the plot files as plot1.png, plot2.png, etc.

Create a separate R code file (plot1.R, plot2.R, etc.) that constructs 
the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. 
Your code file should include code for reading the data so that the plot can 
be fully reproduced. You should also include the code that creates the PNG file.

Add the PNG file and R code file to your git repository"
