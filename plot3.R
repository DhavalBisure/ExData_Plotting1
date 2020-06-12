
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

##Creating plot 3
png(file = "plot3.png", height = 480, width = 480)
with(data , {
       plot(Sub_metering_1~dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
       lines(Sub_metering_2~dateTime,col='Red')
       lines(Sub_metering_3~dateTime,col='Blue')})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1),c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()