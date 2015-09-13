plot1 <- function()
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
  
  png(filename = "plot1.png")
  hist(as.numeric(as.vector.factor((filterDataText$V3))), col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)") 
  dev.off()
}