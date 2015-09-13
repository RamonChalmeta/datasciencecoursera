plot2 <- function()
{
  ## Load data (I assume that the file "household_power_consumption.txt" is in working directory).
  myDataText <- read.table("household_power_consumption.txt", sep = ";")
  namesTitle <-  head(myDataText,1)
  
  ## Filter data by period 2007-02-01 and 2007-02-02
  initDate <- as.Date("2007-02-01")
  endDate  <- as.Date("2007-02-02")
  myDataText$V1 <- as.Date(myDataText$V1,format="%d/%m/%Y")
  filterDataText <- myDataText[myDataText$V1>=initDate & myDataText$V1<=endDate,]
  filterDataText <- filterDataText[-c(1),]
  
  ## Make a plot
  png(filename = "plot2.png")
  plot(as.numeric(as.vector.factor((filterDataText$V3))), type = "l", ylab = "Global Active Power (kilowatts)", xlab = "", xaxt="n")
  axis(1, at=c(0, 1450, 2900) , labels=c("Thu", "Fri", "Sat"))
  dev.off()
  
}