##========================================
## Coursera - Exploratory Data Analysis
## Project 1
##
## Author:  César Ribeiro
## Date:    2014-06-04
##=========================================

## Download and extract the data to the current working directory
## You can comment out the four lines bellow if you already have the dataset
##  in your current working directory
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "household_power_consumption.zip"
download.file(url=url, destfile=destfile, method="curl")
unzip(destfile)

## Read data from the dates 2007-02-01 and 2007-02-02
## read.table skips 66636 rows (total number of minutes from 16/12/2006;17:24:00)
## and reads 2880 rows (2 days * 24 hours * 60 minutes)
dataset.file <- "household_power_consumption.txt"
header <- c("Date",
            "Time",
            "Global_active_power",
            "Global_reactive_power",
            "Voltage",
            "Global_intensity",
            "Sub_metering_1",
            "Sub_metering_2",
            "Sub_metering_3")

dataset <- read.table(file=dataset.file,
                 sep=";",
                 na.strings="?",
                 header=TRUE,
                 colClasses=c(rep("character",2) ,rep("numeric",7)),
                 skip=66636,        
                 nrows=2880     
                 )

names(dataset) <- header

## Convert Date and Time character variables to a single POSIXlt Date/Time class
dataset$Time <- paste(dataset$Date, dataset$Time)
dataset$Date <- NULL
dataset$Time <- strptime(dataset$Time, "%d/%m/%Y %H:%M:%S") 


## Make several scatterplots as a function of Time and save it to a png file
png("plot4.png", width=480, height=480)

par(mfrow = c(2,2))
with(dataset,{

    # Global_active_power
    plot(Time, Global_active_power,
        type="l",
        xlab="",
        ylab="Global Active Power"
    )

    # Voltage
    plot(Time, Voltage,
        type="l",
        xlab="datetime",
        ylab="Voltage"
    )

    # Energy sub metering
    plot(Time, Sub_metering_1,
        type="n",
        xlab="",
        ylab="Energy sub metering"
    )
    lines(Time, Sub_metering_1, col="black")
    lines(Time, Sub_metering_2, col="red")
    lines(Time, Sub_metering_3, col="blue")
    legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        col=c("black","red","blue"), lty=1, bty="n")

    # Global reactive power
    plot(Time, Global_reactive_power,
       type="l",
       xlab="datetime",
       ylab="Global_reactive_power"
    )       


})



dev.off()
