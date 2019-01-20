# Introduction to R - ANSWERS TO EXERCISES

## Contents

1. [Prerequisites](#prerequisites)
2. [Data visualisation](#data-visualisation)
3. [Data transformation](#data-transformation)

---
### Prerequisites

NA and logicals

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

2. What is the default geom associated with `stat_summary()`? How could you rewrite the previous plot (depth vs cut) to use that geom instead of the stat function?
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



---
### License

This material is released under a
[CC-BY-NC-SA license](https://creativecommons.org/licenses/by-nc-sa/4.0/) ![license](https://licensebuttons.net/l/by-nc-sa/3.0/88x31.png).
