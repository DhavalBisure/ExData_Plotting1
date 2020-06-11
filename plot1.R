
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

##Creating plot 1
png(file = "plot1.png", height = 480, width = 480)
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power(kilowatt)")
dev.off()