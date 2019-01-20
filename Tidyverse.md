# Introduction to R - TIDYVERSE

## Contents

1. [Prerequisites](#prerequisites)
2. [Data visualisation](#data-visualisation)
3. [Data transformation](#data-transformation)

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

Try exercise 1 from the [Data visualisation](Exercises.md#data-visualisation) section.

More examples of ggplot2 functionality
```R
# let's take a look at the diamonds dataset
diamonds
ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut))
ggplot(data = diamonds) + stat_count(mapping = aes(x = cut))
# every geom has a default stat and vice versa, but these can be changed

demo <- diamonds %>% count(cut)
ggplot(data = demo) + geom_bar(mapping = aes(x = cut, y = n), stat = "identity")
ggplot(data = demo) + geom_col(mapping = aes(x = cut, y = n))
ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))
ggplot(data = diamonds) +
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )
```

Try exercise 2 from the [Data visualisation](Exercises.md#data-visualisation) section.

More layers
```R
# bar chart position adjustments
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) +
  geom_bar()
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) +
  geom_bar(position = "fill")
  ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) +
    geom_bar(position = "dodge")

# scatter plot position adjustments
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point()
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(position = "jitter")
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_jitter()

# coordinate system
ggplot(data = mpg, mapping = aes(x = drv, y = hwy, colour = class)) +
  geom_boxplot()
ggplot(data = mpg, mapping = aes(x = drv, y = hwy, colour = class)) +
  geom_boxplot() + coord_flip()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() + geom_abline()
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() + geom_abline() + coord_fixed()

# labels
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot() +
  coord_flip() +
  labs(
    y = "Highway MPG",
    x = "Year",
    title = "Highway MPG by car class",
    subtitle = "1999-2008",
    caption = "Source: http://fueleconomy.gov"
  )
```

---
### Data transformation



---
### License

This material is released under a
[CC-BY-NC-SA license](https://creativecommons.org/licenses/by-nc-sa/4.0/) ![license](https://licensebuttons.net/l/by-nc-sa/3.0/88x31.png).
