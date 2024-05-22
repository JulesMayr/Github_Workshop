install.packages('docstring')
library(docstring)


#make a simple function to sum any 2 numbers 

sum_two_nums <- function(x, y){
  #' @title Sum Two Numbers
  #' @description
    #' This function takes 2 input numbers and sums them
  #' @param x and y the 2 numbers we want to sum
  #' @return Prints the sum
  x + y
}
print(sum_two_nums(1, 2))

?sum_two_nums
