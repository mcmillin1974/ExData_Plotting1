plot1 <- function () {
        
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
        png("plot1.png")
        
        #create the  red histogram and change the xlabel
        hist(as.numeric(sb_plot$Global_active_power), col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
        
        ##close the device and suppress the "null device" message
        invisible(dev.off())
        
        }