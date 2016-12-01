---
layout: page
title: R for reproducible scientific analysis
subtitle: Capstone
minutes: 60
---



> ## Learning objectives {.objectives}
>
> - Practice and integrate the tools learned in preceeding lessons.
> - Be able to take a new dataset, understand it, conduct analyses, 
> visualize patterns, and write-up findings.
>

### Baseball

Install the "Lahman" package for R. This is primarily a data package: It contains comprehensive statistics for Major League Baseball dating back to the 19th century. More information is available at <http://lahman.r-forge.r-project.org/>.

You will be writing a report on some baseball statistics. Throughout, you will need to explore the dataset and figure out how to execute the desired analyses. It may be best to do exploratory work in a temporary .R file, and once you have a step figured out, to move the code into your .Rmd file along with a description of what you've done and found.

Create a new RMarkdown document to be rendered as html. Give it an appropriate title and save it as `baseball.Rmd` in the `papers/` directory of your project.

We will focus primarily on batting statistics and salaries. In a code-chunk at the beginning of your document, load the `Lahman` package, and load the batting dataset with `data("Batting")` and the salary dataset with `data("Salaries")`.

#### Getting acquanited

Explore the two data.frames. Write a short summary. What time periods do they cover? Is there much missing data? How many players are in the dataset? What is the maximum recorded salary?

#### Batting averages

A player's batting average is a key baseball statistic, but it is absent from this dataset. A simplified version of a player's batting average is the fraction of at-bats in which the player got a hit. Generate a new column in the `Batting` data.frame for the players' batting averages. A key to the variable names can be found in the [package documentation](http://lahman.r-forge.r-project.org/doc/).

**Advanced**: If you want to calculate players' actual batting averages, see the help file for the `battingStats` function in the Lahman package.

Plotting batting averages over time. Does it look like batters are getting better or worse over time?

#### Home run kings

Who has the most career home runs? How many seasons did they play?

What is the most home runs in a single season?

#### Batting & Salaries

We want to examine how batting ability relates to salaries earned. For only the entries where salary data is available, join the two data.frames.

*Joining data.frames is in a [lesson](http://data-lessons.github.io/gapminder-R/12-joins.html) that is not taught as part of the standard curriculum of this workshop, so here is a line of code you can copy and paste to do this operation. To learn more about joining tables in R, see the above-linked lesson or RStudio's cheatsheet. 

```
battingSalaries <- right_join(Batting, Salaries, "playerID", "yearID")
```

The three components of the batting triple crown are batting average, runs batted in (RBI), and home runs. Plot salary against each of the three statistics. Which appears to have the strongest relationship with a player's salary? 

Run a multiple linear regression of salary on the three batting statistics. Are the results of the model consistent with the conclusions from your plots?

#### Advanced: triple crown winners

To win the triple crown is to have the most home runs and RBI and the highest batting average in a league for a year. Since 1957, only batters with at least 502 at-bats are eligible for the highest batting average. There have been three triple crown winners since 1957 -- can you identify them?

- Note: One of the triple crown winners tied for the best in one of the three categories, so if you only find two winners, you're on the right track, but need to make an adjustment in how ties are handled.
