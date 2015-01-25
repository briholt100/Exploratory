#######
##libraries
#######
library(reshape2)
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

plot(Q1table,type="b",ylab="Total Emissions by 1000 tons",xlab="Year",
     main="U.S. Total Emissions by Year",xaxt = "n")
axis(1,1:4,c("1999", "2002", "2005", "2008"))
points(Q1table,col="blue",pch=19)

#####################
#Copy screen device output to png, saved in ./images/ with w,h at 480 pixels
#####################

dev.off()  ## Don't forget to close the PNG device!








#####################
#Create line chart
#####################
Q2table<-tapply(NEI$Emissions[NEI$fips == 24510]/1000,
                NEI$year[NEI$fips == 24510],sum)

png(file ="./images/Q2.png",bg="white")

plot(Q2table,type="l",ylab="Total Emissions",xlab="Year",
     main = "Emissions for Baltimore, MD",xaxt = "n")
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
Q3ggplot+geom_line()+geom_point()+facet_wrap(~type,nrow = 1, ncol = 4)+
  ylab("Emissions, Tons/1000") + 
  ggtitle("Baltimore, MD PM2.5 Emissions by Year, color by Type")


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
str(SCC)

coal3<-grep("coal", SCC$SCC.Level.Three, ignore.case=T,value=F)
coal<-grep("coal", SCC$Short.Name, ignore.case=T, value=F)
SCC_coal<-subset(SCC[coal3,],select=c("SCC","Short.Name"))

NEI_SCC_coal<-merge(NEI,SCC_coal,by.x="SCC",by.y="SCC")

#####################
#Create line chart
#####################
#I decided to try grep'ingdfor coal in Short.Name, and then by Level.Three.
#I stuck with Level.3

Q4table<-tapply(NEI_SCC_coal$Emissions/1000,NEI_SCC_coal$year,sum)
png(file ="./images/Q4.png",bg="white")

plot(Q4table,type="b",ylab="Total Emissions by 1000 tons",xlab="Year"
     , main="U.S. Coal Emissions by Year", xaxt = "n")
axis(1,1:4,c("1999", "2002", "2005", "2008"))
points(Q4table,col="blue",pch=19)

#####################
#Copy screen device output to png, saved in ./images/ with w,h at 480 pixels
#####################

dev.off()  ## Don't forget to close the PNG device!






#####################
#Q5
#####################

#How have emissions from motor vehicle sources changed from
#1999–2008 in Baltimore City?

#Select Baltimore
df4<-subset(NEI, fips == 24510, select = c(SCC,Emissions, year, type))

#length(grep("motor",SCC$Short.Name,ignore.case=T,value=T))
#length(grep("highway",SCC$Short.Name,ignore.case=T,value=F))

motor_veh_grep<-grep("veh|motor",SCC$Short.Name,ignore.case=T,value=F)
SCC_motor<-SCC[motor_veh_grep,]
SCC_motor<-SCC_motor[SCC_motor$Data.Category=="Onroad",]

final_SCC_motor<-subset(SCC_motor,select = c("SCC","Short.Name"))

NEI_SCC_motor<-merge(df4,final_SCC_motor,by.x="SCC",by.y="SCC")

final<-melt(NEI_SCC_motor, id=c("year", "type"), measure.vars=c("Emissions"))

final<-(dcast(final,year~variable,sum))

Q5ggplot<-ggplot(data=final, aes(x=year, y=Emissions))
summary(Q5ggplot)
png(file ="./images/Q5.png",bg="white",width = 480, height =480)
Q5ggplot+geom_line()+geom_point()+ylab("Emissions, Tons/1000")+ 
  ggtitle("Baltimore, MD Motor Emissions by Year")
#####################
#Copy screen device output to png, saved in ./images/ with w,h at 480 pixels
#####################

dev.off()  ## Don't forget to close the PNG device!

#####################
#Q6
#####################

#Compare emissions from motor vehicle sources in Baltimore City with
#emissions from motor vehicle sources in
#Los Angeles County, California (fips == "06037"). Which city has seen
#greater changes over time in motor vehicle emissions?
#
#

####Prep NEI database, subset out fips not LA or Balt
#Select Baltimore and LA
df5=NEI[NEI$fips=="24510"|NEI$fips=="06037",c(1:2,4:6)]

#change fips # to County Name
df5$fips<-with(df5, ifelse(df5$fips=="24510","Baltimore, MD","Los Angeles, CA"))
                  

##Grep out vehicles and motors from SCC short.name
motor_veh_grep<-grep("veh|motor", SCC$Short.Name,ignore.case=T,value=F)

SCC_motor<-SCC[motor_veh_grep,]
SCC_motor<-SCC_motor[SCC_motor$Data.Category=="Onroad",]

final_SCC_motor<-subset(SCC_motor,select = c("SCC","Short.Name"
                                             ,"Data.Category", "EI.Sector")
                                             )

NEI_SCC_Balt_LA_motor<-merge(df5,final_SCC_motor,by.x="SCC",by.y="SCC")

final<-melt(NEI_SCC_Balt_LA_motor, id=c("fips","year","EI.Sector","Data.Category" )
            , measure.vars=c("Emissions"))

final<-(dcast(final,fips+year+Data.Category+EI.Sector~variable,sum))
head(final)
Q6ggplot<-ggplot(data=final, aes(x=year, y=Emissions,color=fips))
Q6ggplot+geom_line()+geom_point()+facet_wrap(~EI.Sector,ncol = 4)+
  guides(col = guide_legend(reverse = TRUE))+
  ylab("Emissions, Tons/1000")+ 
  ggtitle("LA County, CA vs. Baltimore, MD \nOnroad Motor Emissions by Year")


#####################
#Copy screen device output to png, saved in ./images/ with w,h at 480 pixels
#####################
dev.copy(png, file ="./images/Q6.png",bg="white",width = 960, height =480)  ## Copy my plot to a PNG file
dev.off()  ## Don't forget!



