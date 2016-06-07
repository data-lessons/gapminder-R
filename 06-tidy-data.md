---
layout: page
title: R for reproducible scientific analysis
subtitle: Managing & Manipulating Data
minutes: 20
---



> ## Learning objectives {.objectives}
>
> - Understand what it means for data to be tidy
>     - Each variable forms a column.
>     - Each observation forms a row.
>     - Each type of observational unit forms a table.
> - Be able to use `tidyr::gather` to make "wide" data "long"
> - By able to use `dplyr`'s join functions to merge tables
>

### Tidy data

Data can be organized many ways. While there may be times that call for other organizational schemes, this is the standard and generally-best way to organize data:

1. Each variable forms a column
1. Each observation forms a row
1. Each observational type forms a table

What exactly constitutes a variable can be difficult to define out of context, but as a general rule, if observations are measured in different units, they should be in different columns, and if they are measured in the same units, there is a good chance they should be in the same column.

An example will clarify. [Here is a dummy dataset](https://github.com/michaellevy/gapminder-R/raw/gh-pages/data/wide_eg.csv). Is this data in tidy format? Why not -- which of the three principles does it not satisfy?


~~~{.r}
eg <- read.csv('data/wide_eg.csv')
eg
~~~



~~~{.output}
  subject sex control treatment1 treatment2
1       1   M     7.9       12.3       10.7
2       2   F     6.3       10.6       11.1
3       3   F     9.5       13.1       13.8
4       4   M    11.5       13.4       12.9

~~~

It looks like we've got four individuals, each subjected to three conditions -- a control and two treatments. Each observation here is a person in a treatment (we don't know what the measured value is), so each row should be defined by a person-treatment; that is, we should have 12 rows with four columns: subject, sex, condition, and the measured value. 

#### `gather()` 

We can transform the data tidy form quite easily with the `gather` function from the `tidyr` package. Of course, if you haven't yet installed `tidyr`, you'll need to do that using `install.packages(tidyr)`, and we need to load it.

Arguments to `gather` include the data.frame you're gathering, which columns to gather, and names for two columns in the new data.frame: the key and the value. The key will consist of the old names of gathered columns, and the value will consist of the entries in those columns. The order of arguments is data.frame, key, value, columns-to-gather:


~~~{.r}
library(tidyr)
gather(eg, condition, value, control, treatment1, treatment2)
~~~



~~~{.output}
   subject sex  condition value
1        1   M    control   7.9
2        2   F    control   6.3
3        3   F    control   9.5
4        4   M    control  11.5
5        1   M treatment1  12.3
6        2   F treatment1  10.6
7        3   F treatment1  13.1
8        4   M treatment1  13.4
9        1   M treatment2  10.7
10       2   F treatment2  11.1
11       3   F treatment2  13.8
12       4   M treatment2  12.9

~~~

You can also tell `gather` which columns not to gather -- these are the "ID variables"; that is, they identify the unit of analysis on each row.


~~~{.r}
gather(eg, condition, value, -subject, -sex)
~~~



~~~{.output}
   subject sex  condition value
1        1   M    control   7.9
2        2   F    control   6.3
3        3   F    control   9.5
4        4   M    control  11.5
5        1   M treatment1  12.3
6        2   F treatment1  10.6
7        3   F treatment1  13.1
8        4   M treatment1  13.4
9        1   M treatment2  10.7
10       2   F treatment2  11.1
11       3   F treatment2  13.8
12       4   M treatment2  12.9

~~~



> #### Challenge -- Gather and plot {.challenge}
>
> The following code produces a data.frame with the annual relative standard deviation of income among countries, both by per-capita income and country-total income. Run the code. Is the resulting dataset in tidy form? 
> 
> ```
> gapminder %>%
>     mutate(gdpCountry = gdpPercap * pop) %>%
>     group_by(year) %>%
>     summarize(RSD_individual = sd(gdpPercap) / mean(gdpPercap),
>               RSD_country = sd(gdpCountry) / mean(gdpCountry))
> ```
>
> You could argue that it is or is not in tidy form, because you could see the two outcomes as different variables or two ways of measuring the same variable. For our purposes, consider them two ways of measuring the same variable and `gather` the data.frame so that there is only one measurement of RSD on each row.
> 
> Make a plot with two lines, one for each measure of RSD in income, by year. To make the plot black-and-white-printer friendly, distinguish the lines using the `linetype` **aes**thetic. Could you have made this plot without tidying the data? Why or why not?
>

### Joins

The third tidy data maxim states that each observation type gets its own table. The idea of multiple tables within a dataset will be familiar to anyone who has worked with a relational database but may seem foreign to those who have not. 

The idea is this: Suppose we conduct a behavioral experiment that puts individuals in groups, and we measure both individual- and group-level variables. We should have a table for the individual-level variables and a separate table for the group-level variables. Then, should we need to merge them, we can do so using the `join` functions of `dplyr`. 

The join functions are nicely illustrated in RStudio's [Data wrangling cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf). Each function takes two data.frames and, optionally, the name(s) of columns on which to match. If no column names are provided, the functions match on all shared column names.

The different join functions control what happens to rows that exist in one table but not the other. 

- `left_join` keeps all the entries that are present in the left (first) table and excludes any that are only in the right table. 
- `right_join` keeps all the entries that are present in the right table and excludes any that are only in the left table.
- `inner_join` keeps only the entries that are present in both tables. `inner_join` is the only function that guarantees you won't generate any missing entries.
- `full_join` keeps all of the entries in both tables, regardless of whether or not they appear in the other table.

![dplyr joins, via RStudio](fig/dplyr-joins.png)

We will practice on our continents data.frame from module 2 and the gapminder data.frame. Note how these are tidy data: We have observations at the level of continent and at the level of country, so they go in different tables. The continent column in the gapminder data.frame allows us to link them now. If continents data.frame isn't in your Environment, load it and recall what it consists of:


~~~{.r}
load('data/continents.RDA')
continents
~~~



~~~{.output}
   continent area_km2 population percent_total_pop
1     Africa 30370000 1022234000              15.0
2   Americas 42330000  934611000              14.0
3 Antarctica 13720000       4490               0.0
4       Asia 43820000 4164252000              60.0
5     Europe 10180000  738199000              11.0
6    Oceania  9008500   29127000               0.4

~~~

We can join the two data.frames using any of the `dplyr` functions. We will pass the results to `str` to avoid printing more than we can read, and to get more high-level information on the resulting data.frames.


~~~{.r}
library(dplyr)
left_join(gapminder, continents) %>%
    str()
~~~



~~~{.output}
'data.frame':	1704 obs. of  9 variables:
 $ country          : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ year             : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
 $ pop              : num  8425333 9240934 10267083 11537966 13079460 ...
 $ continent        : chr  "Asia" "Asia" "Asia" "Asia" ...
 $ lifeExp          : num  28.8 30.3 32 34 36.1 ...
 $ gdpPercap        : num  779 821 853 836 740 ...
 $ area_km2         : num  43820000 43820000 43820000 43820000 43820000 ...
 $ population       : num  4.16e+09 4.16e+09 4.16e+09 4.16e+09 4.16e+09 ...
 $ percent_total_pop: num  60 60 60 60 60 60 60 60 60 60 ...

~~~



~~~{.r}
right_join(gapminder, continents) %>% 
    str()
~~~



~~~{.output}
'data.frame':	1705 obs. of  9 variables:
 $ country          : Factor w/ 142 levels "Afghanistan",..: 3 3 3 3 3 3 3 3 3 3 ...
 $ year             : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
 $ pop              : num  9279525 10270856 11000948 12760499 14760787 ...
 $ continent        : chr  "Africa" "Africa" "Africa" "Africa" ...
 $ lifeExp          : num  43.1 45.7 48.3 51.4 54.5 ...
 $ gdpPercap        : num  2449 3014 2551 3247 4183 ...
 $ area_km2         : num  30370000 30370000 30370000 30370000 30370000 ...
 $ population       : num  1.02e+09 1.02e+09 1.02e+09 1.02e+09 1.02e+09 ...
 $ percent_total_pop: num  15 15 15 15 15 15 15 15 15 15 ...

~~~

These operations produce slightly different results, either 1704 or 1705 observations. Can you figure out why? Antarctica contains no countries so doesn't appear in the gapminder data.frame. When we use `left_join` it gets filtered from the results, but when we use `right_join` it appears, with missing values for all of the country-level variables:


~~~{.r}
right_join(gapminder, continents) %>% 
    filter(continent == "Antarctica")
~~~



~~~{.output}
  country year pop  continent lifeExp gdpPercap area_km2 population
1    <NA>   NA  NA Antarctica      NA        NA 13720000       4490
  percent_total_pop
1                 0

~~~

> #### Challenge -- Putting the pieces together {.challenge}
> 
> A colleague suggests that the more land area an individual has, the greater their income will be and that this relationship will be observable at any scale of observation. You chuckle and mutter "Not at the continental scale," but your colleague insists. Test your colleague's hypothesis by:
> 
> - Calculating the total GDP of each continent, 
>       - Hint: Use `dplyr`'s `group_by` and `summarize`
> - Joining the resulting data.frame to the `continents` data.frame, 
> - Calculating the per-capita GDP for each continent, and 
> - Plotting per-capita income versus population density. 
>

## Challenge solutions

> #### Solution to Challenge -- Putting the pieces together {.challenge}
>
>
> 
> ~~~{.r}
> library(ggplot2)
> 
> # Calculate country-level GDP
> mutate(gapminder, GDP = gdpPercap * pop) %>%  
> # Group by continent
>     group_by(continent) %>%  
> # Calculate continent-level GDP
>     summarize(cont_income = sum(GDP)) %>%  
> # Join the continent-GDP data.frame to the continents data.frame
>     left_join(continents) %>%  
> # Calculate continent-level per-capita GDP
>     mutate(per_cap = cont_income / population) %>%  
> # Plot income versus land area
>     ggplot(aes(x = area_km2, y = per_cap)) +  
> # Draw points
>     geom_point() +  
> # And label them
>     geom_text(aes(label = continent), nudge_y = 5e3)  
> ~~~
> 
> <img src="fig/Putting the pieces together - solution-1.png" title="plot of chunk Putting the pieces together - solution" alt="plot of chunk Putting the pieces together - solution" style="display: block; margin: auto;" />
>
