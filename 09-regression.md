---
layout: page
title: R for reproducible scientific analysis
subtitle: Statistical Models
minutes: 30
---



> ## Learning Objectives {.objectives}
>
> * Understand how to execute and interpret basic statistical models
> * Learn to querry and extract from lists
> * Use `broom` to work with models

### Linear models

This workshop can't and won't teach you statistical modeling, but here is the syntax you need to know to use R's basic statistical modeling infrastructure.

`lm` is the function for a linear model. `lm` expects a formula as its first argument. Formulas in R are specified with a tilde separating the left and right hand sides: `DV ~ IV1 + IV2 + ...`. The second argument to `lm` is the name of the data.frame in which the variables are to be found. For example, to model life expectancy as a function of gdp:


~~~{.r}
lm(lifeExp ~ gdpPercap, gapminder)
~~~



~~~{.output}

Call:
lm(formula = lifeExp ~ gdpPercap, data = gapminder)

Coefficients:
(Intercept)    gdpPercap  
  5.396e+01    7.649e-04  

~~~

We can include additional predictors by separating them with a `+`. Now we will assign the results of the model to a variable called `model` and then get a more detailed description of the results by calling the `summary` function.


~~~{.r}
model <- lm(lifeExp ~ gdpPercap + year, gapminder)
summary(model)
~~~



~~~{.output}

Call:
lm(formula = lifeExp ~ gdpPercap + year, data = gapminder)

Residuals:
    Min      1Q  Median      3Q     Max 
-67.262  -6.954   1.219   7.759  19.553 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept) -4.184e+02  2.762e+01  -15.15   <2e-16 ***
gdpPercap    6.697e-04  2.447e-05   27.37   <2e-16 ***
year         2.390e-01  1.397e-02   17.11   <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 9.694 on 1701 degrees of freedom
Multiple R-squared:  0.4375,	Adjusted R-squared:  0.4368 
F-statistic: 661.4 on 2 and 1701 DF,  p-value: < 2.2e-16

~~~

Notice that the same `summary` function gives summary information of a different type depending on whether its argument is a data.frame, a linear model, or something else. That's handy.

We can specify interaction effects by separating variables with `*`:


~~~{.r}
interaction_model <- lm(lifeExp ~ gdpPercap * continent, gapminder)
summary(interaction_model)
~~~



~~~{.output}

Call:
lm(formula = lifeExp ~ gdpPercap * continent, data = gapminder)

Residuals:
    Min      1Q  Median      3Q     Max 
-36.928  -4.312   0.308   5.042  21.202 

Coefficients:
                              Estimate Std. Error t value Pr(>|t|)    
(Intercept)                 45.8442668  0.4127085 111.081  < 2e-16 ***
gdpPercap                    0.0013771  0.0001154  11.937  < 2e-16 ***
continentAmericas           12.9933944  0.8169417  15.905  < 2e-16 ***
continentAsia               11.6704021  0.6252438  18.665  < 2e-16 ***
continentEurope             19.4982172  0.8924238  21.849  < 2e-16 ***
continentOceania            17.8506916  5.2591340   3.394 0.000704 ***
gdpPercap:continentAmericas -0.0005614  0.0001369  -4.102 4.29e-05 ***
gdpPercap:continentAsia     -0.0010544  0.0001190  -8.860  < 2e-16 ***
gdpPercap:continentEurope   -0.0009237  0.0001242  -7.438 1.61e-13 ***
gdpPercap:continentOceania  -0.0008062  0.0002909  -2.772 0.005639 ** 
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 8.143 on 1694 degrees of freedom
Multiple R-squared:  0.6047,	Adjusted R-squared:  0.6026 
F-statistic: 287.9 on 9 and 1694 DF,  p-value: < 2.2e-16

~~~

### Lists

Let's see what `model` really is. It's class is "lm" -- that's what R suggests we see it as. We can ask R, "Okay, but what do *you* see it as?" with the `typeof` function.


~~~{.r}
class(model)
~~~



~~~{.output}
[1] "lm"

~~~



~~~{.r}
typeof(model)
~~~



~~~{.output}
[1] "list"

~~~

Lists are the most flexible data structures in R. A list can have any number of entries, and each entry can be anything, even another list. In fact, it's common to deeply nested lists. Because of this flexibility, it is a useful format for complicated objects like a statistical model. Let's ask R how many entries are in the list, and what the name of each entry is.


~~~{.r}
length(model)
~~~



~~~{.output}
[1] 12

~~~



~~~{.r}
names(model)
~~~



~~~{.output}
 [1] "coefficients"  "residuals"     "effects"       "rank"         
 [5] "fitted.values" "assign"        "qr"            "df.residual"  
 [9] "xlevels"       "call"          "terms"         "model"        

~~~

You can probably guess what at least some of those entries are. We can extract a single item from a list using double square brackets.


~~~{.r}
model[[1]] 
~~~



~~~{.output}
  (Intercept)     gdpPercap          year 
-4.184243e+02  6.697323e-04  2.389828e-01 

~~~

To inspect any item, we could extract each of them using `[[`, but we can also "loop" over every item in a list and run a function on each. That's what `lapply` does. It takes a minimum of two arguments, a list and a function, and executes the function on each item in the list. And it always returns a list of the same length as the original list. Let's look at the class of each item in the model-list:


~~~{.r}
lapply(model, class)
~~~



~~~{.output}
$coefficients
[1] "numeric"

$residuals
[1] "numeric"

$effects
[1] "numeric"

$rank
[1] "integer"

$fitted.values
[1] "numeric"

$assign
[1] "integer"

$qr
[1] "qr"

$df.residual
[1] "integer"

$xlevels
[1] "list"

$call
[1] "call"

$terms
[1] "terms"   "formula"

$model
[1] "data.frame"

~~~


We can also extract items by name. Suppose we want the residuals, we can extract them by name, also with double square brackets. Since there are 1704 of them, we'll just look at a summary.


~~~{.r}
resid = model[["residuals"]]
summary(resid)
~~~



~~~{.output}
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
-67.260  -6.954   1.219   0.000   7.759  19.550 

~~~



But there is a better way to work with model objects like residuals...

### `broom`

The package `broom` is another `tidyverse`-family member. It is built to make working with models easier. Since you won't always be working with models, it doesn't load automatically with `tidyverse` (but does install with it), so we load it with library.


~~~{.r}
library(broom)
~~~

We can get a nice data.frame output of the model summary.


~~~{.r}
tidy(model)
~~~



~~~{.output}
         term      estimate    std.error statistic       p.value
1 (Intercept) -4.184243e+02 2.761714e+01 -15.15089  9.759589e-49
2   gdpPercap  6.697323e-04 2.447033e-05  27.36915 5.766430e-137
3        year  2.389828e-01 1.397107e-02  17.10554  1.184970e-60

~~~

We can create a data.frame that has the data that went into the model plus a bunch of new columns based on the model, such as residuals and predicted values. Note that all the newly added columns' names start with ".".


~~~{.r}
modelOut = augment(model)
head(modelOut)
~~~



~~~{.output}
  lifeExp gdpPercap year  .fitted   .se.fit    .resid         .hat
1  28.801  779.4453 1952 48.59210 0.4472722 -19.79110 0.0021289331
2  30.332  820.8530 1957 49.81474 0.3950734 -19.48274 0.0016610162
3  31.997  853.1007 1962 51.03125 0.3490783 -19.03425 0.0012967730
4  34.020  836.1971 1967 52.21485 0.3124381 -18.19485 0.0010388340
5  36.088  739.9811 1972 53.34532 0.2892826 -17.25732 0.0008905594
6  38.438  786.1134 1977 54.57113 0.2803902 -16.13313 0.0008366498
    .sigma      .cooksd .std.resid
1 9.684667 0.0029706383  -2.043816
2 9.685041 0.0022439588  -2.011501
3 9.685571 0.0016709354  -1.964838
4 9.686523 0.0012224824  -1.877946
5 9.687535 0.0009424980  -1.781049
6 9.688676 0.0007737577  -1.664982

~~~

This is useful for checking model assumptions, looking for anomalous points that may indicate omitted variables, etc. For example, it looks like our model underpredicts short life expectancies:


~~~{.r}
ggplot(modelOut, aes(lifeExp, .resid, color = year)) + 
  geom_point()
~~~

<img src="fig/unnamed-chunk-12-1.png" title="plot of chunk unnamed-chunk-12" alt="plot of chunk unnamed-chunk-12" style="display: block; margin: auto;" />


### glm and beyond

Finally, the specification of generalized linear models such as logistic or Poisson regressions is very similar via the `glm` command. See `?glm` and the web for help. Beyond glm's, the statistical capabilities of R are extensive. A Google search for whatever you are interested in will get you started.



> ## Challenge - A plot and a model {.challenge}
>
> - Make a scatterplot of gdpPercap versus year.  
> - Add a smoother and specify `method = lm` to get a linear fit.  
> - Run a linear regression of gpdPercap on year and use `tidy` to extract the model results.  
> - Do your plot and model point to the same conclusions? Which do you find easier to interpret?
>
> Advanced  
>
> - Does the change in gdpPercap over time vary across continents?  
>   - Hint: An interaction model can answer that question.


> ## Alternatve challenge - Stock prices {.challenge}
>
> - Using the stock data you tidy'd earlier, fit a simple linear model of stock performance.   
> - Extract the model coefficients into a data.frame.  
> - Fortify the data with residuals, predicted values, etc.  
> - Examine (however you wish) residuals by stock. Is the model particularly over or underpredicting any particular stock? How could you improve the model?  
> - **Advanced**: Build that better model.
