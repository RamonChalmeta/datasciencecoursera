run_analysis <- function()
{
  ## The function work assuming that the work directory has the folder UCI HAS Dataset.
  
  ## Read train files
  trainX <- read.table(file = "./UCI HAR Dataset/train/X_train.txt") 
  trainY <- read.table(file = "./UCI HAR Dataset/train/y_train.txt")
  trainSubject <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt") 
  
  ## Merge data test in a single data set
  mergeTrain <- cbind(trainSubject, trainY, trainX)
  
  ## Read test files
  testX <- read.table(file = "./UCI HAR Dataset/test/X_test.txt") 
  testY <- read.table(file = "./UCI HAR Dataset/test/y_test.txt")
  testSubject <- read.table(file = "./UCI HAR Dataset/test/subject_test.txt") 
  
  ## Merge data test in a single data set
  mergeTest <- cbind(testSubject, testY, testX)
  
  ## Merge data test and data train in one data set
  completeData <- rbind(mergeTest, mergeTrain)
  
  ## Read features
  features <- read.table("UCI HAR Dataset/features.txt")
  
  ## Extracts only the measurements on the mean and standard deviation for each measurement. 
  ## And also save the names of each valid measurements
  descriptiveNames <- c("Subject", "Activity")
  validMeasurements <- as.vector(numeric(0))
  for(index in 1:length(features[,2]))
  {
      if(grepl("mean()", as.character( features[index,2]), fixed = TRUE))
      {
          ## Add 2 because the first two columns are person and activity
          validMeasurements <- c(validMeasurements, index+2)
          descriptiveNames <- c(descriptiveNames, as.character(features[index,2]))
      }
      else if(grepl("std()", as.character(features[index,2]), fixed = TRUE))
      {
          ## Add 2 because the first two columns are person and activity
          validMeasurements <- c(validMeasurements, index+2)
          descriptiveNames <- c(descriptiveNames, as.character(features[index,2]))
      }
  }
  ## Add the index of the columns person and activity
  x <- c(1,2)
  validMeasurements <- union(x, validMeasurements)
  
  ## Get only the valid measurements (mean and std)
  validData <- completeData[validMeasurements]
  
  ## Read activity labels
  activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
  
  ## Add activity names
  for(index in 1:length(validData[,2]))
  {
    validData[index,2] = as.character(activityLabels[validData[index,2],2])
  }
  
  ## Set descriprive names
  validData <- setNames(validData, descriptiveNames)
  
  ## Create a final data with means of each measurement to subject and activity
  finalData <- as.data.frame(matrix( nrow = 0, ncol= length(validData[1,])))
  finalData <- setNames(finalData, names(validData))
  
  for(index in 1:length(validData[,1]))
  {
    ## Get Subject & activity
    valueSubject <- validData[index,1]
    valueActivity <- validData[index,2]
    
    ## If this subject with this activity haven been analyased I go to the next element
    if(length(finalData[finalData$Subject==valueSubject & finalData$Activity==valueActivity,1])==0)
    {
      current <- validData[validData$Subject==valueSubject & validData$Activity==valueActivity,-c(1,2)]
      currentDataFrame <- as.data.frame(matrix( nrow = 0, ncol= length(validData[1,])))
      currentDataFrame <- setNames(currentDataFrame, names(validData))
      currentDataFrame[1,1] = valueSubject
      currentDataFrame[1,2] = valueActivity
      
      ## I calculate the mean of each measure
      for(indexMeasure in 3:length(currentDataFrame[1,]))
      {
          for(indexCurrent in 1:length(current[,indexMeasure-2]))
          {
            if(is.na(currentDataFrame[1,indexMeasure]))
            {
              currentDataFrame[1,indexMeasure] <- current[indexCurrent,indexMeasure-2]
            }
            else
            {
              currentDataFrame[1,indexMeasure] <- currentDataFrame[1,indexMeasure] + current[indexCurrent,indexMeasure-2]
            }
          }
        
          currentDataFrame[1,indexMeasure] <- currentDataFrame[1,indexMeasure] / length(current[,indexMeasure-2])
      } 
      ## Add the row to this subject and this measure with all its means.
      finalData <- rbind(finalData, currentDataFrame)
    }
    
  }
  
  ## sort the data to Subjecte
  finalData <- finalData[order(finalData[,1]),]
  
  ## Write a file whit results
  write.table(finalData, file= "myTidyDataSet.txt", row.names=FALSE)
  
  finalData
}