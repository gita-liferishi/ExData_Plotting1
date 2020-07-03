##downloading & extracting file
library(sqldf)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
hpc <- "power_cons.zip"
download.file(url, hpc)
unzip("power_cons.zip")


readHPC <- read.csv.sql("household_power_consumption.txt", sep = ";", sql = 'select * from file where Date IN ("1/2/2007", "2/2/2007")')
readHPC$Date <- as.Date(readHPC$Date, "%m/%d/%Y")

##generating plot 1
hist(readHPC$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.copy(png, file = "plot1.png", width = 480, height = 480)

dev.off()
