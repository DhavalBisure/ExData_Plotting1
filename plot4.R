##Reading the data
data <- read.csv("household_power_consumption.txt", header = FALSE, skip = 66638, nrows = 2879, sep = ';',na.strings = '?')
features <- read.csv("household_power_consumption.txt", header = FALSE, nrows = 1, sep = ';')
features <- as.character(unname(unlist(features[1,])))
names(data) <- features
data <- data[complete.cases(data),]

##Converting date and time column to 1 datetime column  
dateTime <- paste(data$Date, data$Time)
data <- subset(data,select = -c(Date,Time))
data <- cbind(dateTime, data)
data$dateTime <- as.POSIXct(data$dateTime,format = "%d/%m/%Y %H:%M:%S")

##creating plot 4
png(file = "plot4.png", height = 480, width = 480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data , {
  plot(Global_active_power~dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", ylab="Voltage (volt)", xlab="datetime")
  plot(Sub_metering_1~dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=c(1,1,1),bty='n',c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", ylab="Global Rective Power (kilowatts)",xlab="datetime")
  })
dev.off()
