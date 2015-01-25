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
unzip('.data/Emmissions.zip',exdir="./data")

if (!file.exists("images")) {
  dir.create("images")
}

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
boxplot(NEI$Emissions~NEI$year,outline=F)


#####################
#Create line chart
#####################
Q1table<-tapply(NEI$Emissions/1000,NEI$year,sum)
png(file ="./images/Q1.png",bg="white")

plot(Q1table,type="b",ylab="Total Emissions by 1000 tons",xlab="Year",main="U.S. Total Emissions by Year",xaxt = "n")
axis(1,1:4,c("1999", "2002", "2005", "2008"))
points(Q1table,col="blue",pch=19)

#####################
#Copy screen device output to png, saved in ./images/ with w,h at 480 pixels
#####################

dev.off()  ## Don't forget to close the PNG device!








#####################
#Create line chart
#####################
Q2table<-tapply(NEI$Emissions[NEI$fips == 24510]/1000,NEI$year[NEI$fips == 24510],sum)
png(file ="./images/Q2.png",bg="white")

plot(Q2table,type="l",ylab="Total Emissions",xlab="Year",main = "Emissions for Baltimore, MD",xaxt = "n")
axis(1,1:4,c("1999", "2002", "2005", "2008"))
points(Q2table,col="blue",pch=19)

#####################
#Copy screen device output to png, saved in ./images/ with w,h at 480 pixels
#####################

dev.off()  ## Don't forget to close the PNG device!




#####################
#Create ggplot chart
#####################

df3<-subset(NEI, fips == 24510, select = c(Emissions, year, type)) 
nrow(df3)
final<-melt(df3, id=c("year", "type"), measure.vars=c("Emissions"))
head(final)
sum(final$value)

final<-(dcast(final,year+type~variable,sum))


Q3ggplot<-ggplot(data=final, aes(x=year, y=Emissions ,group=type,color=type))
summary(Q3ggplot)
png(file ="./images/Q3.png",bg="white",width = 960, height =480)
Q3ggplot+geom_line()+geom_point()+facet_wrap(~type,nrow = 1, ncol = 4)+ylab("Emissions, Tons/1000") + ggtitle("Baltimore, MD PM2.5 Emissions by Year, color by Type")


#####################
#Copy screen device output to png, saved in ./images/ with w,h at 480 pixels
#####################

dev.off()  ## Don't forget to close the PNG device!


#####################
#Q4
#####################

#Across the United States, how have emissions from coal combustion-related 
#sources changed from 1999–2008?
#
#

#merge SCC and NEI by NEI$SCC and SCC$SCC.  select short.name from scc
#grep coal from short name?  Possibly use cross walk

#subset by the grep'd item, redo #1
#subSCC<-(subset(SCC,select =c("SCC","Short.Name"))) ##pulls just the 2 columns
######
#alternatively
#subSCC<-SCC[,c(1,3)]


#####################
#Q5
#####################

#How have emissions from motor vehicle sources changed from 
#1999–2008 in Baltimore City?

#####################
#Q6
#####################

#Compare emissions from motor vehicle sources in Baltimore City with 
#emissions from motor vehicle sources in 
#Los Angeles County, California (fips == "06037"). Which city has seen 
#greater changes over time in motor vehicle emissions?
#
#






