Author: Ramon Chalmeta Ugas
Version: 1.0


The data set includes the following files:

- 'README.md'
- 'CodeBook.pdf'
- 'run_analysis.R'

How the script work:

source("run_analysis.R")
finalData <- run_analysis()

Preconditions:

1) The work directory contains the script 'run_analysis.R'
2) The work directory contains the folder 'UCI HAR Dataset' with its original structure of Samsung data.

Results:

File "myTidyDataSet.txt" whit tidy data set in the work directory.
The variable finalData the tidy data set load in R.

Considerations:

The final tidy data set has been sorted to subject, in my opinion it is easier to check the results and it is easier to view the results.
The measures included and the criterion to select these measeures are in the code book.
