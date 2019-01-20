# Introduction to R - NOTES

## Contents

1. [Resources](#resources)
2. [Base R](#base-r)

---
### Resources

[R Project](https://www.r-project.org/) - the R Project homepage  
[CRAN](https://cran.r-project.org/) - download R  
[RStudio](https://www.rstudio.com/) - download RStudio (IDE)  
[Bioconductor](http://www.bioconductor.org/) - bioinformatics packages  
[Tidyverse](https://www.tidyverse.org/) - tidyverse packages for data science  

[Cheatsheets](https://www.rstudio.com/resources/cheatsheets/) - a comprehensive list of cheatsheets for many R packages, the most useful of which are provided here as well:
* [Base R](cheatsheets/base-r.pdf)
* [Importing data](cheatsheets/data-import.pdf)
* [Transforming data](cheatsheets/data-transformation.pdf)
* [Visualisation](cheatsheets/data-visualization-2.1.pdf)

[R for Data Science](https://r4ds.had.co.nz/) - a book by Grolemund and Wickham, which should be everyone's starting point with tidyverse  
[Solutions to exercises](https://jrnold.github.io/r4ds-exercise-solutions/)

[Hands-On Programming with R](https://rstudio-education.github.io/hopr/) - an introduction to programming with R by Grolemund  
[Advanced R](http://adv-r.had.co.nz/) - a book about advanced programming with R by Wickham  

---
### Base R

Data types
```R
# numerics are floating point numbers, stored as vectors
5
6.02e23
class(Inf)
2 + 2
(2 + 2) * 3
0 / 0                 # gives NaN
c(1,2,3) + c(1,2,3)   # c(2,4,6)
c(1,2,3) - 1          # c(0,1,2)

# characters (strings are also characters in R)
length(c('a', 'b', 'c'))   # 3
substr(c("Hello", 1, 3))   # "Hel"   # indexing from 1!
gsub('l', 'r', "Hello")    # "Herro"
as.character(c(6, 8))

# logicals are TRUE and False, but also NA (missing data)
# &, |, ==, !=, <, >, <=, >=
as.logical(c(1,0,1,1))

# factors - for categorical data, can be ordered or unordered
factor(c("female", "female", "male", NA, "female"))
```

Variables, functions, control flow
```R
# variable assignment
x <- 5

# function assignment
add_one <- function(x) {
    y <- x + 1
    return(y)
}

# for loop
for (i in 1:4) {
  print(i)
}

# while loop
a <- 10
while (a > 4) {
    cat(a, "...", sep = "")
    a <- a - 1
}

# if-else statement
if (4 > 3) {
    print("4 is greater than 3")
} else {
    print("4 is not greater than 3")
}
```

Vectors
```R
c(2, 4, 6)           # 2 4 6
2:6                  # 2 3 4 5 6
seq(2, 3, by=0.5)    # 2.0 2.5 3.0
rep(1:2, times=3)    # 1 2 1 2 1 2
rep(1:2, each=3)     # 1 1 1 2 2 2

x <- 6:10
x[3]                 # 8
x[-3]                # 6 7 9 10
x[2:4]               # 7 8 9
x[-(2:4)]            # 6 10
x[c(1,5)]            # 6 10
x[x == 9]            # 9
x[x > 8]             # 9 10
x[x %in% c(6, 7)]    # 6 7
```

Other
```R
?mean                # help for a specific function
help.search('mean')  # search help files

install.packages("tidyverse")
library(tidyverse)   # load the library
tidyverse_update()    
```

For more, please check the [base R cheatsheet](cheatsheets/base-r.pdf) and [Learn X in Y minutes](https://learnxinyminutes.com/docs/r/) (where some of the examples were taken from). In particular, matrices, data tables and plotting functions are very useful but are superseded by tidyverse package functionalities. Statistical methods are worth learning more about too.

---
### License

This material is released under a
[CC-BY-NC-SA license](https://creativecommons.org/licenses/by-nc-sa/4.0/) ![license](https://licensebuttons.net/l/by-nc-sa/3.0/88x31.png).
