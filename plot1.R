if(!file.exists("exdata%2Fdata%2Fhousehold_power_consumption.zip")){
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
  data <- unzip(temp)
  unlink(temp)
}

## Pre-Processing...

powerCons <- read.table(data, header = T, sep = ";")
powerCons$Date <- as.Date(powerCons$Date, format="%d/%m/%Y")
DataInterest <- powerCons[(powerCons$Date == "2007-02-01") | (powerCons$Date == "2007-02-02"),]
GAP <- as.numeric(as.character(DataInterest$Global_active_power))
GRP <- as.numeric(as.character(DataInterest$Global_reactive_power))
Voltage <- as.numeric(as.character(DataInterest$Voltage))
DataInterest <- transform(DataInterest, timestamp = as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
SubM1 <- as.numeric(as.character(DataInterest$Sub_metering_1))
SubM2 <- as.numeric(as.character(DataInterest$Sub_metering_2))
SubM3 <- as.numeric(as.character(DataInterest$Sub_metering_3))

## Plotting the first graph...

Plot1 <- function(){
  hist(GAP, main = paste("Global Active Power"), xlab = "Global Active Power(kilowatts)", col = "red")
  dev.copy(png, file="Plot1.png", height = 480, width = 480)
  dev.off()
  cat("Plot1.png was saved in", getwd())
}
Plot1()