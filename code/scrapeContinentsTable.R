library(rvest)
html = read_html('https://en.wikipedia.org/wiki/Continent')

# Population table, scraped 2016-06-04:
cont = 
    html_nodes(html, '#mw-content-text > table:nth-child(34)') %>%
    html_table(fill = TRUE)
cont = cont[[1]][, c(1:2, 4:7)]

# Cleanup
names(cont) = 
    gsub('(\n)|(\\s)', '_', names(cont)) %>%
    gsub('km²', 'km2', .) %>%
    gsub(':|\\.|\\(|\\)', '', .) %>%
    tolower()
cont = 
    sapply(cont, function(col) 
        gsub('\\[[0-9]+\\]', '', col) %>%
            gsub('%|,', '', .)) %>%
    as.data.frame(stringsAsFactors = FALSE)
cont[, 2:ncol(cont)] = 
    sapply(cont[, 2:ncol(cont)], function(x) as.numeric(as.character(x)))
cont$area_km2 = as.integer(cont$area_km2)

# gapminder uses five continents -- get into that format. Probably messes up, e.g. 
# where NZ falls.
unique(gapminder$continent)
comb = grep('America', cont$continent)
cont = 
    cont[comb, -1] %>%
    colSums() %>%
    c('Americas', .) %>%
    rbind(cont, .) %>%
    .[-comb, ]
cont$continent[cont$continent == 'Australia'] = 'Oceania'
continents = cont
save(continents, file = '~/Dropbox/Teaching/SWC/DC_Davis_2016-06-16/gapminder-R/data/continents.RDA')
