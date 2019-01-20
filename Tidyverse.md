# Introduction to R - TIDYVERSE

## Contents

1. [Prerequisites](#prerequisites)
2. [Data visualisation](#data-visualisation)

---
### Prerequisites

Before we begin...
```R
# R is a calculator
2 + 2 * 3
# variables are assigned with <-
x <- 5
# main data types are numerics, characters and logicals
5
"Hello"
TRUE
FALSE
NA   # for missing data
# comparisons
5 == 5
5 != 5
6 > 5
6 <= 7
TRUE & FALSE
TRUE | FALSE
# vectors of values
c(1, 2, 3)
# function arguments
# function_name(arg1 = val1, arg2 = val2, ...)
seq(2, 3, by=0.5)
# help
?mean                # help for a specific function
help.search('mean')  # search help files
```

Check that everything we need is installed...
```R
# load the packages
library(tidyverse)
library(nycflights13)
# if not installed, install the required packages, then load
install.packages("tidyverse")
install.packages("nycflights13")
```

---
### Data visualisation

Experimenting with ggplot2
```R
# let's take a look at the car dataset
mpg
# plot highway fuel efficiency (miles per gallon) 'hwy' vs engine size (litres) 'displ'
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy))
# let's add the class variable using a different aesthetic
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, colour = class))
# you can experiment with other aesthetics: size, alpha, shape
# you can also control the properties of aesthetics
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy), colour = "blue")

# faceted plots
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~class, nrow = 2)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)

# let's try a different geom
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()
# you can experiment with other aesthetics for geom_smooth(): linetype, group, colour
```

Try exercise 1 from the [Data visualisation](exercises/data-visualisation) section.

---
### License

This material is released under a
[CC-BY-NC-SA license](https://creativecommons.org/licenses/by-nc-sa/4.0/) ![license](https://licensebuttons.net/l/by-nc-sa/3.0/88x31.png).
