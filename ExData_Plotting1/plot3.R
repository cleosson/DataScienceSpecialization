library(sqldf)
library(dplyr)

## Downloading the file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile.name <- "course_project_01.zip"
file.name <- "household_power_consumption.txt"

if (!file.exists(zipfile.name)) {
    download.file(url, zipfile.name, method = "curl")
    unzip(zipfile.name, exdir = ".")
}


#Sys.setlocale("LC_TIME", "en_US.UTF-8")

## Loading only two days
data <- read.csv.sql(file.name, sep = ";", sql = "select * from file where Date='1/2/2007' or Date='2/2/2007'")
closeAllConnections()

## Plot 3
png("plot3.png", width=480, height=480)

data <- mutate(data, FullDate = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))
with(data, plot(FullDate, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
with(data, points(FullDate, Sub_metering_1, col = "black", type = "l")) 
with(data, points(FullDate, Sub_metering_2, col = "red", type = "l")) 
with(data, points(FullDate, Sub_metering_3, col = "blue", type = "l")) 
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()