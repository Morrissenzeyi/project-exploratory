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

## Plotting the graphs...

Plot4 <- function() {
  par(mfrow=c(2,2))
  
  
  plot(DataInterest$timestamp,GAP, type="l", xlab="", ylab="Global Active Power")
  
  plot(DataInterest$timestamp,Voltage, type="l", xlab="datetime", ylab="Voltage")
  
  plot(DataInterest$timestamp,SubM1, type="l", xlab="", ylab="Energy sub metering")
  lines(DataInterest$timestamp,SubM2,col="red")
  lines(DataInterest$timestamp,SubM3,col="blue")
  legend("topright", col=c("black","red","blue"), c("Sub metering 1  ","Sub metering 2  ", "Sub metering 3  "),lty=c(1,1), bty="n", cex=.5) 
  
  
  plot(DataInterest$timestamp,GRP, type="l", xlab="datetime", ylab="Global Reactive Power")
  
  
  dev.copy(png, file="Plot4.png", width=480, height=480)
  dev.off()
  cat("plot4.png was saved in", getwd())
}
Plot4()