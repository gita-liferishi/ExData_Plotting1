library(sqldf)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
hpc <- "power_cons.zip"
download.file(url, hpc)
unzip("power_cons.zip")


readHPC <- read.csv.sql("household_power_consumption.txt", sep = ";", sql = 'select * from file where Date IN ("1/2/2007", "2/2/2007")')
readHPC$Date <- as.Date(readHPC$Date, "%m/%d/%Y")
dt <- paste(household_data$Date, household_data$Time)
readHPC$date_time <- strptime(dt, "%Y-%d-%m %H:%M:%S")

Sys.setlocale("LC_TIME", "C") 

par(mfrow = c(2,2), mar = c(4,4,2,1)

##Creating first and second plot
with(readHPC, {
    plot(date_time, Global_active_power, type ="l", xlab = "", ylab = "Global Active Power")
    plot(date_time, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
})

##Creating third plot
with(readHPC, plot(date_time, Sub_metering_1, type = "n", xlab = "", ylab = "Energy Sub Meeting"))
with(readHPC,lines(date_time, Sub_metering_1, ))
with(readHPC, lines(date_time, Sub_metering_2, col = "red"))
with(readHPC, lines(date_time, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##Creating fourth plot
with(readHPC, plot(date_time, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))

dev.copy(png, file = "plot4.png", width = 480, height = 480)

dev.off()
