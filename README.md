R for Reproducible Scientific Analysis 
======================================

## Introduction to R for social scientists

The goal of this lesson is to introduce social scientists to scripting reproducable analyses using R. That means teaching R tools and syntax, as well as best practices in data management and analysis. The emphasis is on leaving attendees with a strong motivation to continue learning R, to introduce some common, powerful packages for data visualization, manipulation, and analysis, and to teach [good-enough practices in scientific computing](https://arxiv.org/abs/1609.00037). 

The lessons embrace [the tidyverse](https://blog.rstudio.org/2016/09/15/tidyverse-1-0-0/), particularly by teaching plotting with `ggplot` and data manipulation with `dplyr`. This is a reflection of prioritization of learner motivation and aquisition of skills that can be immediately used in applied social science research.

These lesson materials are adapted from the [R-novice-inflammation](http://swcarpentry.github.io/r-novice-inflammation) materials, which were translated from the Python materials, and materials from our [R Data Carpentry materials used at the Sydney bootcamp last year](https://dbarneche.github.io/2014-10-31-USyd/). 

There is a motivating introduction in `code/intro-demo.R`. It is an R script that demonstrates some of what will be learned during the workshop. It has been successful at capturing learners' interest, and is intended to be stepped through quickly (~10 minutes) after an introduction along the lines of, "You will learn to do these things over the coming days, for now don't worry about the details, just let it wash over you." The end of the script creates plots based on the participants' names. To make this work, ensure that the `participants` data frame imports data on the current participants (currently using `googlesheets` to demonstrate some web-interfacing with R, but this could use any import function) and has a column "FirstName" containing the first names of the learners.

## Contributing

Please see the current list of [issues][] for ideas for contributing to this repository, and the [Carpentry guidelines and instructions for contributing][contrib].

When editing topic pages, you should change the source R Markdown (.Rmd) file. Afterwards you can render the pages by running `make preview` from the base of the repository. Building the rendered page with the Makefile requires installing some dependencies first. In addition to the dependencies listed in the [lesson template documentation][dependencies], you also need to install the R package [knitr][].

Once you've made your edits and looked over the rendered html files, submit a pull request to the gh-pages branch including only the modified .Rmd files. 

## Getting Help

Please see [https://github.com/swcarpentry/lesson-example](https://github.com/swcarpentry/lesson-example) for instructions on formatting, building, and submitting lessons, or run `make` in this directory for a list of helpful commands.

If you have questions or proposals, please send them to the [r-discuss][] mailing list.

[contrib]: https://github.com/swcarpentry/r-novice-gapminder/blob/gh-pages/CONTRIBUTING.md
[dependencies]: https://github.com/swcarpentry/lesson-template#dependencies 
[design]: https://github.com/swcarpentry/lesson-template/blob/gh-pages/DESIGN.md
[issues]: https://github.com/data-lessons/gapminder-R/issues
[knitr]: http://cran.r-project.org/web/packages/knitr/index.html 
[r-discuss]: http://lists.software-carpentry.org/mailman/listinfo/r-discuss_lists.software-carpentry.org