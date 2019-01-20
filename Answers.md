# Introduction to R - ANSWERS TO EXERCISES

## Contents

1. [Prerequisites](#prerequisites)
2. [Data visualisation](#data-visualisation)
3. [Data transformation](#data-transformation)

---
### Prerequisites

1. Try to predict what logical (TRUE, FALSE or NA) the following expressions return, and explain why.
```R
FALSE == FALSE       # TRUE
FALSE != TRUE        # TRUE
TRUE & FALSE         # FALSE
TRUE | FALSE         # TRUE

NA > 5               # NA
10 == NA             # NA
NA + 10              # NA
NA ^ 0               # 1
NA * 0               # NA  (Inf * 0 = NaN)

NA == NA             # NA
NA | TRUE            # TRUE
NA | FALSE           # NA
NA & TRUE            # NA
NA & FALSE           # FALSE

sqrt(2) ^ 2 == 2     # FALSE
1 / 49 * 49 == 1     # FALSE
near(sqrt(2) ^ 2, 2) # TRUE
```

---
### Data visualisation

1. Recreate the R code necessary to generate the following graphs.

(Going by rows first)
```R
# 1
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(se = FALSE)
# 2
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(aes(group = drv), se = FALSE)
# 3
ggplot(mpg, aes(x = displ, y = hwy, colour = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)
# 4
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = drv)) +
  geom_smooth(se = FALSE)
# 5
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = drv)) +
  geom_smooth(aes(linetype = drv), se = FALSE)
# 6
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(size = 4, colour = "white") +
  geom_point(aes(colour = drv))
```

2. What is the default geom associated with `stat_summary()`? How could you rewrite the [previous plot](Tidyverse.md#data-visualisation) (depth vs cut) to use that geom instead of the stat function?
```R
ggplot(data = diamonds) +
  geom_pointrange(
    mapping = aes(x = cut, y = depth),
    stat = "summary",
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )
```

---
### Data transformation

1. Find all flights that
  a) Had an arrival delay of two or more hours.
  b) Flew to Houston (IAH or HOU).
  c) Were operated by United, American or Delta.
  d) Departed in summer (June, July and August).
  e) Arrived more than two hours late, but didn't leave late.
  f) Were delayed by at least an hour, but made up over 30 minutes in flight.
  g) Departed between midnight and 6am (inclusive).
```R
# a)
filter(flights, arr_delay >= 120)
# b)
filter(flights, dest == "IAH" | dest == "HOU")
filter(flights, dest %in% c("IAH", "HOU"))
# c)
airlines   # use this to look up the codes (?flights would reveal this)
filter(flights, carrier %in% c("AA", "DL", "UA"))
# d)
filter(flights, month >= 6, month <= 8)
filter(flights, month %in% c(6, 7, 8))
filter(flights, between(month, 6, 8))
# e)
filter(flights, dep_delay <= 0, arr_delay > 120)
# f)
filter(flights, dep_delay >= 60, dep_delay - arr_delay > 30)
# g)
filter(flights, dep_time <= 600 | dep_time == 2400)
filter(flights, dep_time %% 2400 <= 600)    # check out modular arithmetic
```

2. a) How would you sort all missing values in `dep_time` to the start?
   b) Sort flights to find the most delayed flights.
   c) Find the flights that left the earliest.
   d) Find the fastest flights (by average air speed).
```R
# a)
arrange(flights, desc(is.na(dep_time)), dep_time)
# b)
arrange(flights, desc(dep_delay))
# c)
arrange(flights, dep_delay)
# d)
arrange(flights, distance / air_time * 60)
```

3. a) Convert `dep_time` and `sched_dep_time` to number of minutes since midnight, which is an easier representation to compute with.
   b) EXTRA (hard). How would you expect `dep_time`, `sched_dep_time` and `dep_delay` to be related? Show it for all cases.
   c) EXTRA (very hard and long). How would you expect `air_time`, `arr_time` and `dep_time` to be related? Show it for all cases, if possible.
```R
# a)
mutate(flights,
  dep_time_min = (dep_time %/% 100 * 60 +
    dep_time %% 100) %% 1440,
  sched_dep_time_min = (sched_dep_time %/% 100 * 60 +
    sched_dep_time %% 100) %% 1440
)

# b)
# "dep_delay = dep_time - sched_dep_time" is a reasonable assumption?
flights_deptime <- mutate(flights,
  dep_time_min = (dep_time %/% 100 * 60 +
    dep_time %% 100) %% 1440,
  sched_dep_time_min = (sched_dep_time %/% 100 * 60 +
    sched_dep_time %% 100) %% 1440
  dep_delay_diff = dep_delay - dep_time_min + sched_dep_time_min
)
filter(flights_deptime, dep_delay_diff != 0)
# Discrepancies because a flight departs the day after it is scheduled for,
# i.e. midnight passes in between?
ggplot(filter(flights_deptime, dep_delay_diff > 0),
  aes(x = dep_delay_diff, y = sched_dep_time_min)) + geom_point()
# Indeed, those are the only discrepancies.

# c)
# "air_time = arr_time - dep_time" is a reasonable assumption?
flights_airtime <- mutate(flights,
  dep_time_min = (dep_time %/% 100 * 60 + dep_time %% 100) %% 1440,
  arr_time_min = (arr_time %/% 100 * 60 + arr_time %% 100) %% 1440,
  air_time_diff = air_time - arr_time_min + dep_time_min
)
filter(flights_airtime, air_time_diff != 0)
# Again, midnight in between? But also time zone differences are possible
# between departure and destination.
# In both cases, the differences should be divisible by 60?
filter(flights_airtime, air_time_diff %% 60 == 0)
# Hmm.. Something else is going on.
ggplot(flights_airtime, aes(x = air_time_diff)) + geom_histogram(bindwidth = 1)
# Bimodal distribution but not all are divisible by 60!
# Turns out, it is a problem with data. air_time = wheels_off - wheels_in.
# But that is missing from this reduced dataset.
```

4. a) Plot the distribution of average delays by individual planes (identified by their tail number). Compare doing so with `geom_freqpoly()` and `geom_point()`.
   b) Look at the number of cancelled flights per day. Is there a pattern? Is the proportion of cancelled flights related to the average delay?
   c) Which plane has the worst on-time record? (Delayed the most.)
   d) At what hour of day should you fly if you want to avoid delays as much as possible?
   e) Delays are typically temporally correlated: even once the problem that caused the initial delay has been resolved, later flights are delayed to allow earlier flights to leave. Using `lag()`, explore how the delay of a flight is related to the delay of the immediately preceding flight.
   f) Find all destinations that are flown by at least two carriers. Use that list of destinations to rank the carriers by the number of destinations they serve.
   g) For each plane, count the number of flights before the first delay of greater than 1 hour.
```R
# a)
not_cancelled %>% group_by(tailnum) %>% summarise(delay = mean(arr_delay)) %>%
  ggplot(aes(x = delay)) + geom_freqpoly(binwidth = 10)
not_cancelled %>% group_by(tailnum) %>%
  summarise(delay = mean(arr_delay), n = n()) %>%
  ggplot(aes(x = n, y = delay)) + geom_point(alpha = 1/10)

# b)
flights %>%
  mutate(cancelled = (is.na(arr_delay) | is.na(dep_delay))) %>%
  group_by(year, month, day) %>%
  summarise(
    prop_cancelled = mean(cancelled),
    avg_dep_delay = mean(dep_delay, na.rm = TRUE)
  ) %>%
  ggplot(aes(x = avg_dep_delay, y = prop_cancelled)) +
    geom_point() +
    geom_smooth()

# c)
flights %>%
  group_by(tailnum) %>%
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE)) %>%
  arrange(desc(avg_delay))

# d)
flights %>%
  group_by(hour) %>%
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = hour, y = avg_delay)) +
    geom_point() +
    geom_smooth(se = FALSE)

# e)
flights %>%
  group_by(origin) %>%
  mutate(dep_delay_lag = lag(dep_delay)) %>%
  filter(!is.na(dep_delay), !is.na(dep_delay_lag)) %>%
  group_by(dep_delay_lag) %>%
  summarise(dep_delay_mean = mean(dep_delay)) %>%
  ggplot(aes(x = dep_delay_lag, y = dep_delay_mean)) +
    geom_point(alpha = 1/4) +
    geom_smooth()

# f)
flights %>%
  select(dest, carrier) %>%
  group_by(dest, carrier) %>%
  filter(row_number() == 1) %>%
  group_by(dest) %>%
  mutate(n_carrier = n_distinct(carrier)) %>%
  filter(n_carrier > 1) %>%
  group_by(carrier) %>%
  summarise(n_dest = n()) %>%
  arrange(desc(n_dest))

g)
flights %>%
  group_by(tailnum) %>%
  filter(cumall(dep_delay <= 60)) %>%
  count(sort = TRUE)
```

---
### License

This material is released under a
[CC-BY-NC-SA license](https://creativecommons.org/licenses/by-nc-sa/4.0/) ![license](https://licensebuttons.net/l/by-nc-sa/3.0/88x31.png).
