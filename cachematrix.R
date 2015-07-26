## Put comments here that give an overall description of what your
## functions do

## This script computes the inverse of a matrix but tries to avoid
## calculating the inverse many times. The function 'makeCacheMatrix'
## creates a special matrix that permits to memorize the inverse of 
## this matrix. The second function 'cacheSolve' uses the first 
## function to get the inverse if this has been calculated before
## otherwise calculates and saves the inverse for future ocasions. 

## Write a short comment describing this function
## This function has 2 attributes 'x' the matrix and 'inverseMatrix' 
## the inverse of matrix 'x'.
## Besides, the function has 4 methods set and get that permit to get
## the matrix or inialize the matrix in this case the 'inverseMatrix' 
## is delete. Then it has two more meethods to get and set the inverse
## of the matrix.

makeCacheMatrix <- function(x = matrix()) {

    inverseMatrix <- NULL
    set <- function(y)
    {
        x <<- y
        inverseMatrix <<- NULL
    }
    
    get <- function() x
    setInverseMatrix <- function(solve) inverseMatrix <<- solve
    getInverseMatrix <- function() inverseMatrix
    list(set = set, get = get,
         setInverseMatrix = setInverseMatrix,
         getInverseMatrix = getInverseMatrix)
}


## Write a short comment describing this function
## This function tries to calculate the inverse of a matrix 'x' but 
## before computing it, it checks that the inverse of the matrix has 
## been calculated previously. Then it returns the message that it 
## doesn't need to calculate it and gets the matrix from cache. If 
## the calculation hasn't been done previously then it calculates the 
##inverse and saves the inverse for future calculations.

cacheSolve <- function(x, ...) {
  
          ## Return a matrix that is the inverse of 'x'
  
          inverseMatrix <- x$getInverseMatrix()
          if(!is.null(inverseMatrix)) {
            message("getting cached data")
            return(inverseMatrix)
          }
          data <- x$get()
          inverseMatrix <- solve(data, ...)
          x$setInverseMatrix(inverseMatrix)
          inverseMatrix
}
