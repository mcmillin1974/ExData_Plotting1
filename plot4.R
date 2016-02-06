plot4 <- function () {
        
        #load necessary libraries and suppress the associated warnings for these libraries
        suppressWarnings(library(lubridate))
        suppressWarnings(library(dplyr))
        suppressWarnings(library(data.table))
 
        
        #check to see the directory exists, if it doesn't, create it.
        mainDir <- "c:/data_science_data/Project/Exploratory_Analysis_Wk_1_Project"
        subDir <- "data"
        
        dir.create(file.path(mainDir, subDir), showWarnings = FALSE)
        
        ##download the data file (zip)from the course website if it doesn't exists
        if (!file.exists("data/exdata-data-household_power_consumption.zip")) {
                url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                download.file(url, "data/exdata-data-household_power_consumption.zip")       
        }
  
        ##unzip the file in the data directory
        if (!file.exists("data/UCI HAR Dataset")) {
                unzip("data/exdata-data-household_power_consumption.zip", exdir = "./data")
        }
  
        ##read the contents of the file into tmp_stor
        tmp_stor <- suppressWarnings(fread("data/household_power_consumption.txt"))        
              
        ##convert data column to data class
        tmp_stor$Date <- as.Date(dmy(tmp_stor$Date))
        
        #subset tmp_stor as sb_plot and remove tmp_stor
        sb_plot <- subset(tmp_stor, tmp_stor$Date >= "2007-2-1" & tmp_stor$Date <= "2007-2-2")
        rm(tmp_stor)
        
        ##open the device session
        png("plot4.png")
        
        #create the line plot with no xlabel and a renamed ylabel
        plot(as.numeric(sb_plot$Global_active_power), type = "l", ylab = "Global Active Power (kilowatts)", xaxt = "n", xlab = "")
        
        ##Create the multiplot set of graphs (2x2)
        #create a 2 x 2 platform for my 4 graphs
        par(mfrow=c(2,2))
        par(cex = .6)
        
        #Create the top left graph
        #create the line plot with no xlabel and a renamed ylabel
        plot(as.numeric(sb_plot$Global_active_power), type = "l", ylab = "Global Active Power (kilowatts)", xaxt = "n", xlab = "")
        
        ##add the Thu, Fri, Sat labels to the x-axis
        axis(1, at = c(0, nrow(sb_plot)/2, nrow(sb_plot)), labels = c("Thu", "Fri", "Sat"))
        
        #creat the top right graph
        #create the line plot with no xlabel and a renamed ylabel
        plot(as.numeric(sb_plot$Voltage), type = "l", ylab = "Voltage", xaxt = "n", xlab = "datetime")
        
        #add the Thu, Fri, Sat labels to the x-axis
        axis(1, at = c(0, nrow(sb_plot)/2, nrow(sb_plot)), labels = c("Thu", "Fri", "Sat"))
        
        
        #create the bottom left graph
        
        plot(as.numeric(sb_plot$Sub_metering_1), col = "black", type = "l", ylab = "Energy sub metering", xaxt = "n", xlab = "")
        lines(as.numeric(sb_plot$Sub_metering_2), col = "red")
        lines(as.numeric(sb_plot$Sub_metering_3), col = "blue")
        axis(1, at = c(0, nrow(sb_plot)/2, nrow(sb_plot)), labels = c("Thu", "Fri", "Sat"))
        legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lwd = 1, col = c("black", "red", "blue"), bty = "n")
        
        #create the bottom right
        plot(as.numeric(sb_plot$Global_reactive_power), type = "l", ylab = "Global_reactive_power", xaxt = "n", xlab = "datetime")
        
        #add the Thu, Fri, Sat labels to the x-axis
        axis(1, at = c(0, nrow(sb_plot)/2, nrow(sb_plot)), labels = c("Thu", "Fri", "Sat"))

        
        ##close the device and suppress the "null device" message
        invisible(dev.off())
        
        }