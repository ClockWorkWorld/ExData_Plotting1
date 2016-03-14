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

# Plot 2

#Open the PNG Device
png(filename='plot2.png',width=480,height=480,bg='transparent')

#Plot the linegraph
plot(subfile$DT,subfile$Global_active_power,type='l',xlab=NA,ylab='Global Active Power (kilowatts)')

#Close the PNG Device
dev.off()
