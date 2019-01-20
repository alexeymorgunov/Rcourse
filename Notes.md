# Introduction to R - NOTES

## Contents

1. [Resources](#resources)
2. [Base R](#base-r)
3. [Tidyverse](#tidyverse)

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
0 / 0   # gives NaN
c(1,2,3) + c(1,2,3)   # c(2,4,6)
c(1,2,3) - 1   # c(0,1,2)

# characters (strings are also characters in R)
length(c("a", "b", "c"))   # 3
substr(c("Hello", 1, 3))   # "Hel"   # indexing from 1!
gsub("l", "r", "Hello")    # "Herro"
as.character(c(6, 8))

# logicals are TRUE and False, but also NA (missing data)
# &, |, ==, !=, <, >, <=, >=
as.logical(c(1,0,1,1))

# factors - for categorical data, can be ordered or unordered
factor(c("female", "female", "male", NA, "female"))
```



---
### tidyverse




---
### License

This material is released under a
[CC-BY-NC-SA license](https://creativecommons.org/licenses/by-nc-sa/4.0/) ![license](https://licensebuttons.net/l/by-nc-sa/3.0/88x31.png).
