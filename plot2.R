# Title:  Coursera Course 4 Project 1 - Plot2
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


# Create plot2 and save as png
dev.cur()
plot(df$Date_Time, df$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)", main="Global Active Power")
dev.copy(png, file="plot2.png")
dev.off()