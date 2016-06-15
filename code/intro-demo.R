# Author: Michael Levy
# Date: 2016-06-15
# To use: Update the import of learners' names.
# Purpose: Introduce the power of R and preview what's in store for learners.
# Don't teach from it. Walk through quickly, explaining in broad strokes.

library(googlesheets)
library(dplyr)
library(babynames)
library(ggplot2)

babynames

# What were the most popular names for boys and girls in the 1980s?
babynames %>%
    filter(year >= 1980 & year < 1990) %>%
    group_by(sex, name) %>%
    summarize(count = sum(n)) %>%
    arrange(sex, -count) %>%
    slice(1:5)

# How has the popularity of "Sophia" changed over the years?
babynames %>%
   filter(name == "Sophia") %>%
   ggplot(aes(x = year, y = prop, color = sex)) +
   geom_line(size = 1)

# How about for any name?
plotTheName = function(theName) {
   babynames %>%
      filter(name == theName) %>%
      ggplot(aes(x = year, y = prop, color = sex)) +
         geom_line(size = 1) +
         ggtitle(theName)
}

plotTheName(theName = "Michael")

sample(babynames$name, 1) %>%
    plotTheName()

# How about for everyone who registered for this class?
participants = gs_title('DC-participants-2016-06-16') %>% gs_read()

## Keep only the names that are in the babynames dataset
names = participants$FirstName[participants$FirstName %in% babynames$name] %>% 
    unique() %>% sort()

## Save all plots to one file
cowplot::save_plot('~/Desktop/nameplots.png', 
          cowplot::plot_grid(plotlist = lapply(names, plotTheName)),
          base_height = 20)

## Or, make a new folder and save each name as a separate file
location = '~/Desktop/namePlots/'
dir.create(location)
lapply(names, function(name) {
    ggsave(filename = paste0(location, name, '.png'), 
           plot = plotTheName(name))
    cat('Done with', name)
})