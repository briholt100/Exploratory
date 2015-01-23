#######
##libraries
#######
library(data.table)
library(reshape2)
library(tidyr)
library(dplyr)
library(lattice)
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

NEI$year<-strptime(NEI$year,format = "%Y", tz="UTC") #transform chr to date
NEI$year<-year(NEI$year) #lubridate to year type


###################look for outliers###########################

p<-ggplot(NEI,aes(y=log(Emissions+1)))
p+geom_boxplot()
BoxEm<-boxplot(NEI$Emissions)
objects(BoxEm)


BoxEm$out <- NULL
BoxEm$group <- NULL
bxp(BoxEm)  # this will plot without any outlier points

plot(NEI$Emissions)
hist(NEI$Emissions,breaks= 20)
boxplot(NEI$Emissions,outline=F)



Q1table<-tapply(NEI$Emissions/1000,NEI$year,sum)
tableNames<-names(Q1table)
plot(Q1table,type="l",ylab="Total Emissions",xlab="Year",main="U.S. Total Emissions by Year",xaxt = "n")
axis(1,1:4,c("1999", "2002", "2005", "2008"))
points(Q1table,col="blue",pch=19)



Q2table<-tapply(NEI$Emissions[NEI$fips == 24510]/1000,NEI$year[NEI$fips == 24510],sum)
plot(Q2table,type="l",ylab="Total Emissions",xlab="Year",main = "Emissions for Baltimore, MD",xaxt = "n")
axis(1,1:4,c("1999", "2002", "2005", "2008"))
points(Q2table,col="blue",pch=19)






subSCC<-(subset(SCC,select =c("SCC","Short.Name"))) ##pulls just the 2 columns
######
#alternatively
#subSCC<-SCC[,c(1,3)]

df<-merge(NEI,subSCC,by.x = "SCC",by.y="SCC",all=T)
names(df)



####Read random sample to get file structure
power <- fread('grep "^[12]/2/2007" ./data/household_power_consumption.txt',na.strings="?")
temp<-read.csv("./data/household_power_consumption.txt", header = TRUE, sep=";", nrows=20)



###########
#This will take some processing time
###########
