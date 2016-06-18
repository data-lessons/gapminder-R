---
layout: page
title: R for reproducible scientific analysis
subtitle: Manipulating data.frames
minutes: 45
---



> ## Learning objectives {.objectives}
>
> - Be able to use the six major dplyr verbs (`filter`, `select`, `arrange`, `mutate`, `group_by`, `summarize`)
> - Be able to use and understand the advantages of the `magrittr` pipe: `%>%`
>

It is an often bemoaned fact that a data scientist spends much, and often most, of her time wrangling data: getting it organized and clean. In this lesson we will learn an efficient set of tools that can handle the vast majority of most data management tasks. 

If you didn't install the `dplyr` package during the last lesson, do so now:


~~~{.r}
install.packages('dplyr')
~~~

Remember that you only have to install each package once (per computer), but you have to load them for each R session in which you want to use them.

You also have to load any data you want to use each time you start a new R session. So, if it's not already loaded, read in the gapminder data.


~~~{.r}
library(dplyr)
gapminder <- read.csv('data/gapminder-FiveYearData.csv')
~~~

### The five tasks of `dplyr`

There are five actions we often want to apply to a tabular dataset:

- Filter rows
- Filter columns
- Arrange rows
- Make new columns
- Summarize groups

We are about to see how to do each of those things using the `dplyr` package. Everything we're going to learn to do can also be done using "base R", but `dplyr` makes it easier, and the syntax is consistent, and it actually makes the computations faster. 

#### `filter()`

Suppose we want to see just the gapminder data for the USA. First, we need to know how "USA" is written in the dataset: Is it USA or United States or what? We can see all the unique values of a variable with the `unique` function.


~~~{.r}
unique(gapminder$country)
~~~



~~~{.output}
  [1] Afghanistan              Albania                 
  [3] Algeria                  Angola                  
  [5] Argentina                Australia               
  [7] Austria                  Bahrain                 
  [9] Bangladesh               Belgium                 
 [11] Benin                    Bolivia                 
 [13] Bosnia and Herzegovina   Botswana                
 [15] Brazil                   Bulgaria                
 [17] Burkina Faso             Burundi                 
 [19] Cambodia                 Cameroon                
 [21] Canada                   Central African Republic
 [23] Chad                     Chile                   
 [25] China                    Colombia                
 [27] Comoros                  Congo Dem. Rep.         
 [29] Congo Rep.               Costa Rica              
 [31] Cote d'Ivoire            Croatia                 
 [33] Cuba                     Czech Republic          
 [35] Denmark                  Djibouti                
 [37] Dominican Republic       Ecuador                 
 [39] Egypt                    El Salvador             
 [41] Equatorial Guinea        Eritrea                 
 [43] Ethiopia                 Finland                 
 [45] France                   Gabon                   
 [47] Gambia                   Germany                 
 [49] Ghana                    Greece                  
 [51] Guatemala                Guinea                  
 [53] Guinea-Bissau            Haiti                   
 [55] Honduras                 Hong Kong China         
 [57] Hungary                  Iceland                 
 [59] India                    Indonesia               
 [61] Iran                     Iraq                    
 [63] Ireland                  Israel                  
 [65] Italy                    Jamaica                 
 [67] Japan                    Jordan                  
 [69] Kenya                    Korea Dem. Rep.         
 [71] Korea Rep.               Kuwait                  
 [73] Lebanon                  Lesotho                 
 [75] Liberia                  Libya                   
 [77] Madagascar               Malawi                  
 [79] Malaysia                 Mali                    
 [81] Mauritania               Mauritius               
 [83] Mexico                   Mongolia                
 [85] Montenegro               Morocco                 
 [87] Mozambique               Myanmar                 
 [89] Namibia                  Nepal                   
 [91] Netherlands              New Zealand             
 [93] Nicaragua                Niger                   
 [95] Nigeria                  Norway                  
 [97] Oman                     Pakistan                
 [99] Panama                   Paraguay                
[101] Peru                     Philippines             
[103] Poland                   Portugal                
[105] Puerto Rico              Reunion                 
[107] Romania                  Rwanda                  
[109] Sao Tome and Principe    Saudi Arabia            
[111] Senegal                  Serbia                  
[113] Sierra Leone             Singapore               
[115] Slovak Republic          Slovenia                
[117] Somalia                  South Africa            
[119] Spain                    Sri Lanka               
[121] Sudan                    Swaziland               
[123] Sweden                   Switzerland             
[125] Syria                    Taiwan                  
[127] Tanzania                 Thailand                
[129] Togo                     Trinidad and Tobago     
[131] Tunisia                  Turkey                  
[133] Uganda                   United Kingdom          
[135] United States            Uruguay                 
[137] Venezuela                Vietnam                 
[139] West Bank and Gaza       Yemen Rep.              
[141] Zambia                   Zimbabwe                
142 Levels: Afghanistan Albania Algeria Angola Argentina ... Zimbabwe

~~~

Okay, now we want to see just the rows of the data.frame where country is "United States". The syntax for all `dplyr` functions is the same: The first argument is the data.frame, the rest of the arguments are whatever you want to do in that data.frame. 


~~~{.r}
filter(gapminder, country == "United States")
~~~



~~~{.output}
         country year       pop continent lifeExp gdpPercap
1  United States 1952 157553000  Americas  68.440  13990.48
2  United States 1957 171984000  Americas  69.490  14847.13
3  United States 1962 186538000  Americas  70.210  16173.15
4  United States 1967 198712000  Americas  70.760  19530.37
5  United States 1972 209896000  Americas  71.340  21806.04
6  United States 1977 220239000  Americas  73.380  24072.63
7  United States 1982 232187835  Americas  74.650  25009.56
8  United States 1987 242803533  Americas  75.020  29884.35
9  United States 1992 256894189  Americas  76.090  32003.93
10 United States 1997 272911760  Americas  76.810  35767.43
11 United States 2002 287675526  Americas  77.310  39097.10
12 United States 2007 301139947  Americas  78.242  42951.65

~~~

We can also apply multiple conditions, e.g. the US after 2000:


~~~{.r}
filter(gapminder, country == "United States" & year > 2000)
~~~



~~~{.output}
        country year       pop continent lifeExp gdpPercap
1 United States 2002 287675526  Americas  77.310  39097.10
2 United States 2007 301139947  Americas  78.242  42951.65

~~~

We can also use "or" conditions with the vertical pipe: `|`. Notice that the variable (column) names don't go in quotes, but values of character variables do. 


~~~{.r}
filter(gapminder, country == "United States" | country == "Mexico")
~~~



~~~{.output}
         country year       pop continent lifeExp gdpPercap
1         Mexico 1952  30144317  Americas  50.789  3478.126
2         Mexico 1957  35015548  Americas  55.190  4131.547
3         Mexico 1962  41121485  Americas  58.299  4581.609
4         Mexico 1967  47995559  Americas  60.110  5754.734
5         Mexico 1972  55984294  Americas  62.361  6809.407
6         Mexico 1977  63759976  Americas  65.032  7674.929
7         Mexico 1982  71640904  Americas  67.405  9611.148
8         Mexico 1987  80122492  Americas  69.498  8688.156
9         Mexico 1992  88111030  Americas  71.455  9472.384
10        Mexico 1997  95895146  Americas  73.670  9767.298
11        Mexico 2002 102479927  Americas  74.902 10742.441
12        Mexico 2007 108700891  Americas  76.195 11977.575
13 United States 1952 157553000  Americas  68.440 13990.482
14 United States 1957 171984000  Americas  69.490 14847.127
15 United States 1962 186538000  Americas  70.210 16173.146
16 United States 1967 198712000  Americas  70.760 19530.366
17 United States 1972 209896000  Americas  71.340 21806.036
18 United States 1977 220239000  Americas  73.380 24072.632
19 United States 1982 232187835  Americas  74.650 25009.559
20 United States 1987 242803533  Americas  75.020 29884.350
21 United States 1992 256894189  Americas  76.090 32003.932
22 United States 1997 272911760  Americas  76.810 35767.433
23 United States 2002 287675526  Americas  77.310 39097.100
24 United States 2007 301139947  Americas  78.242 42951.653

~~~

#### `select()`

`filter` returned a subset of the data.frame's rows. `select` returns a subset of the data.frame's columns.

Suppose we only want to see country and life expectancy. 


~~~{.r}
select(gapminder, country, lifeExp)
~~~

Hmm, we can't really see all 1704 rows. We can just look at the top of the data.frame with the `head` function. We could assign the output of our `select` command to a new variable and display the head of that, or we can wrap our select function in `head`. Note that if we don't assign the output of a function to a variable, the output is printed, but nothing changes. E.g. the last command didn't remove the other columns from the gapminder data.frame, it just printed the results of that function call. Understand how the nesting functions works: `head` expects a data.frame as its argument, and `select` returns a data.frame. The output of `select` becomes the input to `head`.


~~~{.r}
gapCountryExp <- select(gapminder, country, lifeExp)
head(gapCountryExp)
~~~



~~~{.output}
      country lifeExp
1 Afghanistan  28.801
2 Afghanistan  30.332
3 Afghanistan  31.997
4 Afghanistan  34.020
5 Afghanistan  36.088
6 Afghanistan  38.438

~~~



~~~{.r}
head(select(gapminder, country, lifeExp))
~~~



~~~{.output}
      country lifeExp
1 Afghanistan  28.801
2 Afghanistan  30.332
3 Afghanistan  31.997
4 Afghanistan  34.020
5 Afghanistan  36.088
6 Afghanistan  38.438

~~~

#### `arrange()`

You can order the rows of a data.frame by a variable using `arrange`. Suppose we want to see the most populous countries. Again, we wrap the results in `head` to just print the first few rows: 


~~~{.r}
head(arrange(gapminder, pop))
~~~



~~~{.output}
                country year   pop continent lifeExp gdpPercap
1 Sao Tome and Principe 1952 60011    Africa  46.471  879.5836
2 Sao Tome and Principe 1957 61325    Africa  48.945  860.7369
3              Djibouti 1952 63149    Africa  34.812 2669.5295
4 Sao Tome and Principe 1962 65345    Africa  51.893 1071.5511
5 Sao Tome and Principe 1967 70787    Africa  54.425 1384.8406
6              Djibouti 1957 71851    Africa  37.328 2864.9691

~~~

Hmm, we didn't get the most populous countries. By default, `arrange` sorts the variable in *increasing* order. We could see the most populous countries by examining the `tail` of the last command, or we can sort the data.frame by descending population by wrapping the variable in `desc()`:


~~~{.r}
head(arrange(gapminder, desc(pop)))
~~~



~~~{.output}
  country year        pop continent lifeExp gdpPercap
1   China 2007 1318683096      Asia  72.961  4959.115
2   China 2002 1280400000      Asia  72.028  3119.281
3   China 1997 1230075000      Asia  70.426  2289.234
4   China 1992 1164970000      Asia  68.690  1655.784
5   India 2007 1110396331      Asia  64.698  2452.210
6   China 1987 1084035000      Asia  67.274  1378.904

~~~

`arrange` can also sort by multiple variables. It will sort the data.frame by the first variable, and if there are any ties in that variable, they will be sorted by the next variable, and so on. Here we sort from newest to oldest, and within year from richest to poorest:


~~~{.r}
head(arrange(gapminder, desc(year), desc(gdpPercap)))
~~~



~~~{.output}
          country year       pop continent lifeExp gdpPercap
1          Norway 2007   4627926    Europe  80.196  49357.19
2          Kuwait 2007   2505559      Asia  77.588  47306.99
3       Singapore 2007   4553009      Asia  79.972  47143.18
4   United States 2007 301139947  Americas  78.242  42951.65
5         Ireland 2007   4109086    Europe  78.885  40676.00
6 Hong Kong China 2007   6980412      Asia  82.208  39724.98

~~~

**Shoutout Q: Would we get the same output if we switched the order of `desc(year)` and `desc(gdpPercap)` in the last line?**

#### C'est ne pas une pipe

Suppose we want to look at all the countries where life expectancy is greater than 80 years, sorted from poorest to richest. First, we `filter`, then we `arrange`. Each function expects a data.frame as its first argument and returns a data.frame as its output. So we could wrap them like we did with `head(select( ... ))` above: 


~~~{.r}
arrange(filter(gapminder, lifeExp > 80), gdpPercap)
~~~



~~~{.output}
           country year       pop continent lifeExp gdpPercap
1      New Zealand 2007   4115771   Oceania  80.204  25185.01
2           Israel 2007   6426679      Asia  80.745  25523.28
3            Italy 2002  57926999    Europe  80.240  27968.10
4            Italy 2007  58147733    Europe  80.546  28569.72
5            Japan 2002 127065841      Asia  82.000  28604.59
6            Japan 1997 125956499      Asia  80.690  28816.58
7            Spain 2007  40448191    Europe  80.941  28821.06
8           Sweden 2002   8954175    Europe  80.040  29341.63
9  Hong Kong China 2002   6762476      Asia  81.495  30209.02
10          France 2007  61083916    Europe  80.657  30470.02
11       Australia 2002  19546792   Oceania  80.370  30687.75
12         Iceland 2002    288030    Europe  80.500  31163.20
13           Japan 2007 127467972      Asia  82.603  31656.07
14          Sweden 2007   9031088    Europe  80.884  33859.75
15       Australia 2007  20434176   Oceania  81.235  34435.37
16     Switzerland 2002   7361757    Europe  80.620  34480.96
17         Iceland 2007    301931    Europe  81.757  36180.79
18          Canada 2007  33390141  Americas  80.653  36319.24
19     Switzerland 2007   7554661    Europe  81.701  37506.42
20 Hong Kong China 2007   6980412      Asia  82.208  39724.98
21          Norway 2007   4627926    Europe  80.196  49357.19

~~~

Or, we could assign the intermediate data.frame to a variable:


~~~{.r}
lifeExpGreater80 <- filter(gapminder, lifeExp > 80)
arrange(lifeExpGreater80, gdpPercap)
~~~



~~~{.output}
           country year       pop continent lifeExp gdpPercap
1      New Zealand 2007   4115771   Oceania  80.204  25185.01
2           Israel 2007   6426679      Asia  80.745  25523.28
3            Italy 2002  57926999    Europe  80.240  27968.10
4            Italy 2007  58147733    Europe  80.546  28569.72
5            Japan 2002 127065841      Asia  82.000  28604.59
6            Japan 1997 125956499      Asia  80.690  28816.58
7            Spain 2007  40448191    Europe  80.941  28821.06
8           Sweden 2002   8954175    Europe  80.040  29341.63
9  Hong Kong China 2002   6762476      Asia  81.495  30209.02
10          France 2007  61083916    Europe  80.657  30470.02
11       Australia 2002  19546792   Oceania  80.370  30687.75
12         Iceland 2002    288030    Europe  80.500  31163.20
13           Japan 2007 127467972      Asia  82.603  31656.07
14          Sweden 2007   9031088    Europe  80.884  33859.75
15       Australia 2007  20434176   Oceania  81.235  34435.37
16     Switzerland 2002   7361757    Europe  80.620  34480.96
17         Iceland 2007    301931    Europe  81.757  36180.79
18          Canada 2007  33390141  Americas  80.653  36319.24
19     Switzerland 2007   7554661    Europe  81.701  37506.42
20 Hong Kong China 2007   6980412      Asia  82.208  39724.98
21          Norway 2007   4627926    Europe  80.196  49357.19

~~~

The first option is difficult to read, and the second option clutters our Environment with a data.frame that we will only use once. There is a better way, which makes both writing and reading the code easier. The pipe from the `magrittr` package (which is automatically installed and loaded with `dplyr`) takes the output of first line, and plugs it in as the first argument of the next line.


~~~{.r}
filter(gapminder, lifeExp > 80) %>%
    arrange(gdpPercap)
~~~



~~~{.output}
           country year       pop continent lifeExp gdpPercap
1      New Zealand 2007   4115771   Oceania  80.204  25185.01
2           Israel 2007   6426679      Asia  80.745  25523.28
3            Italy 2002  57926999    Europe  80.240  27968.10
4            Italy 2007  58147733    Europe  80.546  28569.72
5            Japan 2002 127065841      Asia  82.000  28604.59
6            Japan 1997 125956499      Asia  80.690  28816.58
7            Spain 2007  40448191    Europe  80.941  28821.06
8           Sweden 2002   8954175    Europe  80.040  29341.63
9  Hong Kong China 2002   6762476      Asia  81.495  30209.02
10          France 2007  61083916    Europe  80.657  30470.02
11       Australia 2002  19546792   Oceania  80.370  30687.75
12         Iceland 2002    288030    Europe  80.500  31163.20
13           Japan 2007 127467972      Asia  82.603  31656.07
14          Sweden 2007   9031088    Europe  80.884  33859.75
15       Australia 2007  20434176   Oceania  81.235  34435.37
16     Switzerland 2002   7361757    Europe  80.620  34480.96
17         Iceland 2007    301931    Europe  81.757  36180.79
18          Canada 2007  33390141  Americas  80.653  36319.24
19     Switzerland 2007   7554661    Europe  81.701  37506.42
20 Hong Kong China 2007   6980412      Asia  82.208  39724.98
21          Norway 2007   4627926    Europe  80.196  49357.19

~~~

To demonstrate how it works, here are some examples where it's unnecessary. 


~~~{.r}
4 %>% sqrt()
~~~



~~~{.output}
[1] 2

~~~



~~~{.r}
2 ^ 2 %>% sum(1)
~~~



~~~{.output}
[1] 5

~~~

Whatever goes through the pipe becomes the first argument of the function after the pipe. This is convenient, because all `dplyr` functions produce a data.frame as their output and take a data.frame as the first argument. Since R ignores white-space, we can put each function on a new line, which RStudio will automatically indent, making everything easy to read. Now each line represents a step in a sequential operation. You can read this as "Take the gapminder data.frame, filter to the rows where lifeExp is greater than 80, and arrange by gdpPercap." 



~~~{.r}
gapminder %>%
    filter(lifeExp > 80) %>%
    arrange(gdpPercap)
~~~



~~~{.output}
           country year       pop continent lifeExp gdpPercap
1      New Zealand 2007   4115771   Oceania  80.204  25185.01
2           Israel 2007   6426679      Asia  80.745  25523.28
3            Italy 2002  57926999    Europe  80.240  27968.10
4            Italy 2007  58147733    Europe  80.546  28569.72
5            Japan 2002 127065841      Asia  82.000  28604.59
6            Japan 1997 125956499      Asia  80.690  28816.58
7            Spain 2007  40448191    Europe  80.941  28821.06
8           Sweden 2002   8954175    Europe  80.040  29341.63
9  Hong Kong China 2002   6762476      Asia  81.495  30209.02
10          France 2007  61083916    Europe  80.657  30470.02
11       Australia 2002  19546792   Oceania  80.370  30687.75
12         Iceland 2002    288030    Europe  80.500  31163.20
13           Japan 2007 127467972      Asia  82.603  31656.07
14          Sweden 2007   9031088    Europe  80.884  33859.75
15       Australia 2007  20434176   Oceania  81.235  34435.37
16     Switzerland 2002   7361757    Europe  80.620  34480.96
17         Iceland 2007    301931    Europe  81.757  36180.79
18          Canada 2007  33390141  Americas  80.653  36319.24
19     Switzerland 2007   7554661    Europe  81.701  37506.42
20 Hong Kong China 2007   6980412      Asia  82.208  39724.98
21          Norway 2007   4627926    Europe  80.196  49357.19

~~~


Making your code easier for humans to read will save you lots of time. The human reading it is usually future-you, and operations that seem simple when you're writing them will look like gibberish when you're three weeks removed from them, let alone three months or three years or another person. Make your code as easy to read as possible by using the pipe where appropriate, leaving white space, using descriptive variable names, being consistent with spacing and naming, and liberally commenting code.


#### `mutate()`

We have learned how to drop rows, drop columns, and rearrange rows. To make a new column we use the `mutate` function. As usual, the first argument is a data.frame. The second argument is the name of the new column you want to create, followed by an equal sign, followed by what to put in that column. You can reference other variables in the data.frame, and `mutate` will treat each row independently. E.g. we can calculate the total GDP of each country in each year by multiplying the per-capita GDP by the population. We pass the output of `mutate` to `head` to keep the display under control. How would we view the highest-total-income countries?


~~~{.r}
mutate(gapminder, total_income = gdpPercap * pop) %>%
    head()
~~~



~~~{.output}
      country year      pop continent lifeExp gdpPercap total_income
1 Afghanistan 1952  8425333      Asia  28.801  779.4453   6567086330
2 Afghanistan 1957  9240934      Asia  30.332  820.8530   7585448670
3 Afghanistan 1962 10267083      Asia  31.997  853.1007   8758855797
4 Afghanistan 1967 11537966      Asia  34.020  836.1971   9648014150
5 Afghanistan 1972 13079460      Asia  36.088  739.9811   9678553274
6 Afghanistan 1977 14880372      Asia  38.438  786.1134  11697659231

~~~

You can create multiple columns in the same function call, separating them by commas. E.g. suppose we want the base-10 logarithm of each country's population and per-capita income:


~~~{.r}
gapminder %>%
    mutate(log_income = log10(gdpPercap), log_pop = log10(pop)) %>%
    arrange(desc(log_income)) %>%
    head()
~~~



~~~{.output}
  country year     pop continent lifeExp gdpPercap log_income  log_pop
1  Kuwait 1957  212846      Asia  58.033 113523.13   5.055084 5.328065
2  Kuwait 1972  841934      Asia  67.712 109347.87   5.038810 5.925278
3  Kuwait 1952  160000      Asia  55.565 108382.35   5.034959 5.204120
4  Kuwait 1962  358266      Asia  60.470  95458.11   4.979813 5.554206
5  Kuwait 1967  575003      Asia  64.624  80894.88   4.907921 5.759670
6  Kuwait 1977 1140357      Asia  69.343  59265.48   4.772802 6.057041

~~~


> #### MCQ: Data Reduction {.challenge}
>
> Produce a data.frame with only the names and years of countries where per capita income is less than a dollar a day sorted from most- to least-recent.
>
> - Tip: The `gdpPercap` variable is annual income. You'll need to adjust.
> - Tip: For complex tasks, it often helps to use pencil and paper to write/draw/map the various steps needed and how they fit together before writing any code.
> 
> What is the annual per-capita income, rounded to the nearest dollar, of the first row in the data.frame?
>
> a. $278
> b. $312
> c. $331
> d. $339

#### `summarize()`

Often we want to calculate a new variable, but rather than keeping each row as an independent observation, we want to group observations together to calculate some summary statistic. To do this we need two functions, one to do the grouping and one to calculate the summary statistic: `group_by` and `summarize`. By itself `group_by` doesn't change a data.frame; it just sets up the grouping. `summarize` then goes over each group in the data.frame and does whatever calculation you want. E.g. suppose we want the average global income for each year. While we're at it, let's calculate the mean and median and see how they differ. 


~~~{.r}
gapminder %>%
    group_by(year) %>%
    summarize(mean_income = mean(gdpPercap), median_income = median(gdpPercap))
~~~



~~~{.output}
Source: local data frame [12 x 3]

    year mean_income median_income
   (int)       (dbl)         (dbl)
1   1952    3725.276      1968.528
2   1957    4299.408      2173.220
3   1962    4725.812      2335.440
4   1967    5483.653      2678.335
5   1972    6770.083      3339.129
6   1977    7313.166      3798.609
7   1982    7518.902      4216.228
8   1987    7900.920      4280.300
9   1992    8158.609      4386.086
10  1997    9090.175      4781.825
11  2002    9917.848      5319.805
12  2007   11680.072      6124.371

~~~

Note that `summarize` eliminates any other columns. Why? What else can it do? E.g. What country should it list for the year 1952!?

We often want to calculate the number of entries within a group. E.g. we might wonder if our dataset is balanced by country. We can do this with the `n()` function, or `dplyr` provides a `count` function as a convenience:


~~~{.r}
gapminder %>%
    group_by(country) %>%
    summarize(number_entries = n())
~~~



~~~{.output}
Source: local data frame [142 x 2]

       country number_entries
        (fctr)          (int)
1  Afghanistan             12
2      Albania             12
3      Algeria             12
4       Angola             12
5    Argentina             12
6    Australia             12
7      Austria             12
8      Bahrain             12
9   Bangladesh             12
10     Belgium             12
..         ...            ...

~~~



~~~{.r}
count(gapminder, country)
~~~



~~~{.output}
Source: local data frame [142 x 2]

       country     n
        (fctr) (int)
1  Afghanistan    12
2      Albania    12
3      Algeria    12
4       Angola    12
5    Argentina    12
6    Australia    12
7      Austria    12
8      Bahrain    12
9   Bangladesh    12
10     Belgium    12
..         ...   ...

~~~

The highly observant will notice the output of this looks a little different than most of our data.frames -- why didn't it print out all 60 rows, and what's with that header info at the top? `dplyr` converted the data.frame to a table-data.frame, or `tbl_df` object. The most salient difference between them is that `tbl_df`s never print more than a few rows, which can be nice. If you like this behavior, you can convert any data.frame to a tbl_df like so. Now it prints nicely, so we don't need to use `head`.


~~~{.r}
gapminder <- tbl_df(gapminder)
gapminder
~~~



~~~{.output}
Source: local data frame [1,704 x 6]

       country  year      pop continent lifeExp gdpPercap
        (fctr) (int)    (dbl)    (fctr)   (dbl)     (dbl)
1  Afghanistan  1952  8425333      Asia  28.801  779.4453
2  Afghanistan  1957  9240934      Asia  30.332  820.8530
3  Afghanistan  1962 10267083      Asia  31.997  853.1007
4  Afghanistan  1967 11537966      Asia  34.020  836.1971
5  Afghanistan  1972 13079460      Asia  36.088  739.9811
6  Afghanistan  1977 14880372      Asia  38.438  786.1134
7  Afghanistan  1982 12881816      Asia  39.854  978.0114
8  Afghanistan  1987 13867957      Asia  40.822  852.3959
9  Afghanistan  1992 16317921      Asia  41.674  649.3414
10 Afghanistan  1997 22227415      Asia  41.763  635.3414
..         ...   ...      ...       ...     ...       ...

~~~

We can also do multiple groupings. Suppose we want the maximum life expectancy in each continent for each year. We group by continent and year and calculate the maximum with the `max` function:


~~~{.r}
gapminder %>%
    group_by(continent, year) %>%
    summarize(longest_life = max(lifeExp))
~~~



~~~{.output}
Source: local data frame [60 x 3]
Groups: continent [?]

   continent  year longest_life
      (fctr) (int)        (dbl)
1     Africa  1952       52.724
2     Africa  1957       58.089
3     Africa  1962       60.246
4     Africa  1967       61.557
5     Africa  1972       64.274
6     Africa  1977       67.064
7     Africa  1982       69.885
8     Africa  1987       71.913
9     Africa  1992       73.615
10    Africa  1997       74.772
..       ...   ...          ...

~~~

Hmm, we got the longest life expectancy for each continent-year, but we didn't get the country. To get the country, we have to ask R "Where lifeExp is at a maximum, what is the entry in country?" For that we use the `which.max` function. `max` returns the maximum value; `which.max` returns the location of the maximum value.


~~~{.r}
max(c(1, 7, 4))
~~~



~~~{.output}
[1] 7

~~~



~~~{.r}
which.max(c(1, 7, 4))
~~~



~~~{.output}
[1] 2

~~~

Now, back to the question: Where lifeExp is at a maximum, what is the entry in country? 


~~~{.r}
gapminder %>%
    group_by(continent, year) %>%
    summarize(longest_life = max(lifeExp), country = country[which.max(lifeExp)])
~~~



~~~{.output}
Source: local data frame [60 x 4]
Groups: continent [?]

   continent  year longest_life   country
      (fctr) (int)        (dbl)    (fctr)
1     Africa  1952       52.724   Reunion
2     Africa  1957       58.089 Mauritius
3     Africa  1962       60.246 Mauritius
4     Africa  1967       61.557 Mauritius
5     Africa  1972       64.274   Reunion
6     Africa  1977       67.064   Reunion
7     Africa  1982       69.885   Reunion
8     Africa  1987       71.913   Reunion
9     Africa  1992       73.615   Reunion
10    Africa  1997       74.772   Reunion
..       ...   ...          ...       ...

~~~




> #### Challenge -- Part 1 {.challenge}
>
> - Calculate a new column: the total GDP of each country in each year. 
> - Calculate the variance -- `var()` of countries' incomes in each year.
> - Is country-level GDP getting more or less equal over time?
> - Plot your findings.
> 

> #### Challenge -- Part 2 {.challenge}
> 
> - Modify the code you just wrote to calculate the variance in both country-level GDP and per-capita GDP.
> - Do both measures support the conclusion you arrived at above?
> 

> #### Challenge -- Part 3 (Advanced) {.challenge}
> 
> The above plotting exercise asked you to plot summarized information, but it is generally preferable to avoid summarizing before plotting. Can you generate a plot that shows the information you calculated in Part 1 without summarizing?  
>
> - Hint: `ggplot` interprets the `gapminder$year` as a numeric variable, which may be okay, but there are some plot types for which you need `ggplot` to see `gapminder$year` as a category. You can accomplish this by wrapping it in `factor` -- e.g. `ggplot(gapminder, aes(x = factor(year) ...`
>

#### Resources

That is the core of `dplyr`'s functionality, but it does more. RStudio makes a great [cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf) that covers all the `dplyr` functions we just learned, plus what we will learn in the next lesson: keeping data tidy.
