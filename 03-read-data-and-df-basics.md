---
layout: page
title: R for reproducible scientific analysis
subtitle: data.frame
minutes: 15
---




> ## Learning objectives {.objectives}
>
> - Be able to read a csv file and store it to a variable
> - Understand data.frame as foundational object
> - Be able to ask questions about the structure of a data.frame and its component parts.
>

### Read a csv

Data come in many forms, and we need to be able to load them in R. For our own use and with others who use R, there are R-specific data structures we can use, and we will see these later, but we need to be able to work with more general data types too. Comma-separated value (csv) tables are perhaps the most universal data structure. We can read csv's with the `read.csv` function:


~~~{.r}
read.csv('path/to/csv_file.csv')
~~~

Note that:

- `read.csv` is a function. That's how R works: everything is a function.
- Argument to `read.csv` is the location of the csv file, relative to the working directory
    - Point to the working directory above the console. Theirs should be the root of their project. 
    - File name goes in quotes. Otherwise R will look for a variable called `path/to/csv_file.csv` and get confused when it hits the `/`
    
Let's read the gapminder data we downloaded in the previous lesson:


~~~{.r}
read.csv('data/gapminder-FiveYearData.csv')
~~~

Whoa! What just happened? R executed the function and printed the result, just like when you enter `log(1)`. How do you store an object to a variable?


~~~{.r}
gapminder <- read.csv('data/gapminder-FiveYearData.csv')
~~~

### Data frame basics

Check the Environment tab -- gapminder has appeared. It is a `data.frame` with 1704 observations of 6 variables. *Click on it to show the data table format of a data.frame. Clarify variables versus observations.* 

It's nice to not have to point and click, and we'd like to get more information about our `data.frame`. There are many ways; `head`, `str`, and `summary` are very useful. 


~~~{.r}
head(gapminder)
~~~



~~~{.output}
      country year      pop continent lifeExp gdpPercap
1 Afghanistan 1952  8425333      Asia  28.801  779.4453
2 Afghanistan 1957  9240934      Asia  30.332  820.8530
3 Afghanistan 1962 10267083      Asia  31.997  853.1007
4 Afghanistan 1967 11537966      Asia  34.020  836.1971
5 Afghanistan 1972 13079460      Asia  36.088  739.9811
6 Afghanistan 1977 14880372      Asia  38.438  786.1134

~~~

`head` shows us a managable number of rows of what we saw in table form. 


~~~{.r}
str(gapminder)
~~~



~~~{.output}
'data.frame':	1704 obs. of  6 variables:
 $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
 $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
 $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
 $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
 $ gdpPercap: num  779 821 853 836 740 ...

~~~

`str` tells us what type of variable each is. We'll get into the details of variable types later, but for now, note that we have four numerical variables (one, year, is integer), and two character variables, which R interprets as factors. Levels are the possible values a factor can take; here, we have 142 possible countries and five possible continents.

> #### Challenge 1 {.challenge}
>
> There is another function like `head()` and `str()` that provides information on a `data.frame`: `summary()`  
> - Call the `summary` function on the `gapminder` data.  
> - What is the most recent year for which we have data?
>
