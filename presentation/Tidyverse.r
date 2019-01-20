#### Before we begin...

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
TRUE & TRUE
TRUE | TRUE
# vectors of values
c(1, 2, 3)
# function arguments
# function_name(arg1 = val1, arg2 = val2, ...)
seq(2, 3, by=0.5)
# help
?mean                # help for a specific function
help.search('mean')  # search help files


Try exercise 1 from the Prerequisites section.

#### Check that everything we need is installed...

# load the packages
library(tidyverse)
library(nycflights13)
# if not installed, install the required packages, then load
install.packages("tidyverse")
install.packages("nycflights13")



### Data visualisation

#### Experimenting with ggplot2

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

Try exercise 1 from the Data visualisation section.

#### More examples of ggplot2 functionality

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

Try exercise 2 from the Data visualisation section.

#### More layers

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



### Data transformation

#### Filter rows

# let's take a look at the flights dataset
flights
# filter() subsets observations
filter(flights, month == 1, day == 1)
filter(flights, month == 11 | month == 12)
filter(flights, month %in% c(11, 12))
filter(flights, is.na(dep_delay))

Try exercise 1 from the Data transformation section.

#### Arrange rows

# arrange() changes the order of observations
arrange(flights, dep_time, arr_time)
arrange(flights, desc(dep_delay))
# note that NA are sorted to the end

Try exercise 2 from the Data transformation section.

#### Select columns

# select() subsets variables
select(flights, year, month, day)
select(flights, year:day)
select(flights, time_hour, air_time, everything())
# check other options in ?select: starts_with(), ends_with(), contains() etc.
# rename() renames variables, keeps those not mentioned

#### Create new columns

# let's make a smaller dataset
flights_sml <- select(flights, year:day, ends_with("delay"), distance, air_time)
# mutate() adds new variables
mutate(flights_sml, gain = dep_delay - arr_delay, speed = distance / air_time * 60)
# transmute() is a version that only keeps the new variables

Try exercise 3 from the Data transformation section.

#### Summaries

# summarise() collapses data frame to a single row
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))
# group_by() changes the unit of analysis from the full data frame to groups
by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))
# the pipe %>% provides an easier way to combine multiple operations
flights %>%
  group_by(year, month, day) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE))

# long example - plotting average delay vs distance
flights %>%
  group_by(dest) %>%
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>%
  filter(count > 20, dest != "HNL") %>%
  ggplot(aes(x = dist, y = delay)) +
    geom_point(aes(size = count), alpha = 1/3) +
    geom_smooth(se = FALSE)

# annoying to always remove NA, let's filter
not_cancelled <- flights %>% filter(!is.na(dep_delay), !is.na(arr_delay))

# count() is a shorthand for summarise+count
not_cancelled %>% count(dest)
not_cancelled %>% count(tailnum, wt = distance)

# there is also, naturally, ungroup()

# grouped mutates and filters standardise manipulation across groups
# proportion of flights delayed to popular destinations only
flights %>%
  group_by(dest) %>%
  filter(n() > 365) %>%
  filter(arr_delay > 0) %>%
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>%
  select(year:day, dest, arr_delay, prop_delay)

Try exercise 4 from the Data transformation section.

