#Read the data file
file<-read.table("household_power_consumption.txt",
                 header=TRUE,sep=';',
                 stringsAsFactors=FALSE,
                 na.strings='?')

#Format the date column to an R date class
file$Date<-as.Date(file$Date,format='%d/%m/%Y')

#Set Start and End Times
t1<-'2007-02-01'
t2<-'2007-02-02'

#Subset the Data to the Time Period of Interest
subfile<-file[(file$Date==t1)|(file$Date==t2),]

#Make new vector combining Date and Time
datetimes<-with(subfile,paste(Date,Time))

#Convert datetimes vector to R Date class
DT<-strptime(datetimes,format='%Y-%m-%d %H:%M:%S')

#Add the new datetime column to the data
subfile$DT<-DT

# Plot 3

#Open the PNG Device
png(filename='plot3.png',width=480,height=480,bg='transparent')

#Plot linegraph for Sub_metering_1
plot(subfile$DT,subfile$Sub_metering_1,type='l',
     xlab=NA,ylab='Energy sub metering')

#Add line for Sub_metering_2
lines(subfile$DT,subfile$Sub_metering_2,col='red')

#Add line for Sub_metering_3
lines(subfile$DT,subfile$Sub_metering_3,col='blue')

#Add a legend
legend('topright',c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),lty=c(1,1,1),col=c('black','red','blue'))

#Close the PNG Device
dev.off()
