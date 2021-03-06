# Title: Coursera Course 4 Project 1 - Plot4
# Author: Sharon Puddle
# Date:   5 Aug 2018

library(dplyr)
library(lubridate)

# Set working directory, download source file and unzip if file not available
setwd("~/R/Coursera/Course 4")
if(!file.exists("data/household_power_consumption.txt")){
  dir.create("data")
  URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(URL, destfile="./data/exdata%2Fdata%2Fhousehold_power_consumption.zip")
  unzip("./data/exdata%2Fdata%2Fhousehold_power_consumption.zip", exdir="./data")
}

# Read in data for 2007-02-01 and 2007-02-02
df <- read.csv("data/household_power_consumption.txt", sep=";", head=FALSE, skip=66637, nrows=2880)
df_names <- read.csv("data/household_power_consumption.txt", sep=";", head=FALSE, nrows=1)
for (i in 1:9) {names(df)[i] <- as.character(df_names[1,i])}

df <- tbl_df(df)
df <- mutate(df, Date_Time = dmy_hms(paste(Date,Time)))

# Create plot4 and save as png
dev.cur()
par(mfrow = c(2,2), mar = c(4,4,2,1))

plot(df$Date_Time, df$Global_active_power, type="l", xlab="Date/Time", ylab="Global Active Power")

plot(df$Date_Time, df$Voltage, type="l", xlab="Date/Time", ylab="Voltage")

df_sub <- select(df, Sub_metering_1:Sub_metering_3)
df_dates <- ymd_hms(c("2007-02-01 00:00:00","2007-02-02 00:00:00","2007-02-03 00:00:00"))
matplot(df$Date_Time, df_sub, 
        type="l", lty=c(1,1,1), 
        col=c("black","red","blue"),
        xlab="", xaxt="n",
        ylab="Energy sub metering")
axis(1, at=df_dates, format(df_dates, "%a"))
legend("topright", lty=c(1,1,1), col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.8)

plot(df$Date_Time, df$Global_reactive_power, type="l", xlab="Date/Time", ylab="Global Reactive Power")

dev.copy(png, file="plot4.png")
dev.off()