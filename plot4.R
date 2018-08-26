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
png(filename = "C:\\Jeevan\\coursera\\Course4\\plot4.png",
    width = 480, height = 480, bg = "white")

# Set Global Parameters
par(mfrow = c(2,2))

# Construct fourth Plot
with(plotData, {
  #Row 1, Plot 1   
  plot(as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"), Global_active_power, type = "l", 
                    ylab = "Global Active Power", xlab = "")
  #Row 1, Plot 2
  plot(as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"), Voltage, type = "l", 
       ylab = "Voltage", xlab = "datetime")

  #Row 2, Plot 1
  plot(as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"), Sub_metering_1, type = "l", 
       ylab = "Energy sub metering", xlab = "")
  lines(as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"), Sub_metering_2, col = "red")
  lines(as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"), Sub_metering_3, col = "blue")
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", cex = 1)
  
  #Row 2, Plot 2
  plot(as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"), Global_reactive_power, type = "l", 
       xlab = "datetime")
 }
)

    
# Close the PNG Graphics Device
dev.off()
