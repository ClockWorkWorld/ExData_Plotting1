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

# Plot 1

#Open the PNG Device
png(filename='plot1.png',width=480,height=480,bg='transparent')

#Plot the Histogram
hist(subfile$Global_active_power,col='red',xlab='Global Active Power (kilowatts)',main='Global Active Power',lty=0)

#Close the PNG Device
dev.off()


