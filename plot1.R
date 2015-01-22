########################################################################
#Obtain and download Housing dataset
#'http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip' 
# Simply navigate to that web address, download, then unzip.  Keep track of file location
########################################################################

########################################################################
#This script assumes linux forward slash notation
########################################################################

getwd()
###
#setwd("Insert your directory location the Plot?.r script)


#######
##libraries
#######
library(data.table)
library(lubridate)

fileUrl <- 'http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
if (!file.exists("data")) {
  dir.create("data")
}

######
# Check if data already exists; if not, download it.
######

if (!file.exists('./data/household_power_consumption.zip')) {
  download.file(fileUrl, './data/household_power_consumption.zip', method='wget')
}

######
#Unzip file
#####
#unzip('./data/household_power_consumption.zip',exdir="./data")


####Read random sample to get file structure
tmp<-read.csv("./data/household_power_consumption.txt", header = TRUE, sep=";", nrows=20)
names(tmp)
################################
#This next step will take some processing time. If it fails, use the following code:
#df2 <- fread('grep "^[12]/2/2007" ./data/household_power_consumption.txt', sep=";", header= F, na.strings="?")
#colnames(df2)<-names(tmp)
################################

full<-read.csv("./data/household_power_consumption.txt",header=T,sep=";", na.strings=c("?",""))
full$Date<-dmy(full$Date)

################################
#This next step will also take some processing time
################################


full$DateTime<-paste(full$Date,full$Time)
full$DateTime<-ymd_hms(full$DateTime)

################################
#This next grep step will take some processing time
################################

useDates<-grep("2007-02-01|2007-02-02",full$DateTime, value=F )
df<-full[useDates,]


##########################
#PLOT 1
##########################


#########################
#Change varialbe to numeric
#########################

df$Global_active_power<-as.numeric(df$Global_active_power)

#####################
#Create image folder/directory
#####################

if (!file.exists("images")) {
  dir.create("images")
}

#####################
#Create histogram
#####################
png(file ="./images/plot1a.png",bg="transparent")

hist1<-hist(df$Global_active_power, col="red",
            main="Global Active Power",
            xlab="Global Active Power (kilowatts)")


#####################
#Copy screen device output to png, saved in ./images/ with w,h at 480 pixels
#####################

dev.copy(png, file = "./images/plot1.png", width = 480, height =480)  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!

