---
layout: page
title: R for reproducible scientific analysis
subtitle: Statistical Models
minutes: 30
---



> ## Learning Objectives {.objectives}
>
> * Understand how to execute and interpret basic statistical models. 
> 

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
model2 <- lm(lifeExp ~ gdpPercap * continent, gapminder)
summary(model2)
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

### glm and beyond

Finally, the specification of generalized linear models such as logistic or Poisson regressions is very similar via the `glm` command. See `?glm` and the web for help. Beyond glm's, the statistical capabilities of R are extensive. A Google search for whatever you are interested in will get you started.



> ## Challenge - A plot and a model {.challenge}
>
> - Make a scatterplot of gdpPercap versus year.
> - Add a smoother and specify `method = lm` to get a linear fit.
> - Run a linear regression of gpdPercap on year.
> - Do your plot and model point to the same conclusions? Which do you find easier to interpret?
>
