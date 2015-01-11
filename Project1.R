######
##libraries
library(dplyr)
library(lubridate)

getwd()


#on campus
#setwd("I:\\My Data Sources\\mooc\\explore")

#on latitude
#setwd("/home/brian/Projects/Coursera/Explore")

#ondater
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

temp<-read.csv("./data/household_power_consumption.txt", header = TRUE, sep=";", nrows=20)

full<-read.csv("./data/household_power_consumption.txt",header=T,sep=";")
full$Date<-dmy(full$Date)
full$DateTime<-paste(full$Date,full$Time)
full$DateTime<-ymd_hms(full$DateTime)
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
"Construct the plot and save it to a PNG file with a width of 480 pixels
and a height of 480 pixels.

Name each of the plot files as plot1.png, plot2.png, etc.

Create a separate R code file (plot1.R, plot2.R, etc.) that constructs 
the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. 
Your code file should include code for reading the data so that the plot can 
be fully reproduced. You should also include the code that creates the PNG file.

Add the PNG file and R code file to your git repository"

df$Global_active_power<-as.numeric(df$Global_active_power)


  hist1<-hist(df$Global_active_power*2/1000, col="red",
            main="Global Active Power",
            xlab="Global Active Power (kilowatts)"
            #,xlim = c(0,2)
         #   , breaks = 12
            
    )



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
