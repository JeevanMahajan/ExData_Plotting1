# Name: Jeevan Mahajan
# Date: 26-Aug-2018
# Course: Coursera Exploratory Data Analysis
# Week 1 - Peer Graded Assignment
# The code uses 'sqldf' package to read the input data and assumes that the 'sqldf' package is installed.

# Load Libraries
library(sqldf)

# Read Input Data.
# Using sqldf function, read the Household electric consumption data for dates '2007-02-01' and '2007-02-02' only.

# Define Input File with path and file handle.
inputDataFile <- "C:\\Jeevan\\coursera\\Course4\\household_power_consumption.txt"
fileHandle <- file(inputDataFile)

# Read the  Household electric consumption data for dates '2007-02-01' and '2007-02-02' only.
plotData <- sqldf("select * from fileHandle where Date = '1/2/2007' 
                  or Date = '2/2/2007'", 
                  file.format = list(header = TRUE, sep = ";"))

# Close File Connection
close(fileHandle)

# Convert Date and Time variables into Date/Time classes
plotData$Date <- as.Date(plotData$Date, "%d/%m/%Y")
plotData$Time <- format(strptime(plotData$Time, "%H:%M:%S"), "%H:%M:%S")

# Open the PNG graphics device and create the first plot
png(filename = "C:\\Jeevan\\coursera\\Course4\\plot3.png",
    width = 480, height = 480, bg = "white")

# Construct third Plot
# Submetering 1
with(plotData, plot(as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"), Sub_metering_1, type = "l", 
                    ylab = "Energy sub metering", xlab = ""))

# Submetering 2
with(plotData, lines(as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"), Sub_metering_2, col = "red"))

# Submetering 3
with(plotData, lines(as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"), Sub_metering_3, col = "blue"))

# Add Legend
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Close the PNG Graphics Device
dev.off()
