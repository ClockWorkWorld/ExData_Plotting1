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

# Plot 4

#Open the PNG Device
png(filename='plot4.png',width=480,height=480,bg='transparent')

#Setup the plot grid
par(mfrow=c(2,2))

#Plot the Global_active_power linegraph
plot(subfile$DT,subfile$Global_active_power,type='l',xlab=NA,ylab='Global Active Power (kilowatts)')

#Plot the Voltage linegraph
plot(subfile$DT,subfile$Voltage,type='l',xlab='datetime',ylab='Voltage')

#Plot the Energy sub metering linegraph
plot(subfile$DT,subfile$Sub_metering_1,type='l',
     xlab=NA,ylab='Energy sub metering')
lines(subfile$DT,subfile$Sub_metering_2,col='red')
lines(subfile$DT,subfile$Sub_metering_3,col='blue')
legend('topright',c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),lty=c(1,1,1),col=c('black','red','blue'))

#Plot the Global_reactive_power linegraph
plot(subfile$DT,subfile$Global_reactive_power,type='l',xlab='datetime',ylab='Global_reactive_power')

#Close the PNG Device
dev.off()
