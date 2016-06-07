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

# gapminder uses five continents -- get into that format. Probably messes up, e.g. 
# where NZ falls.
comb = grep('America', cont$continent)
cont = 
    cont[comb, -1] %>%
    colSums() %>%
    c('Americas', .) %>%
    rbind(cont, .) %>%
    .[-comb, ]

cont$continent[cont$continent == 'Australia'] = 'Oceania'
cont[, 2:ncol(cont)] = 
    sapply(cont[, 2:ncol(cont)], function(x) as.numeric(as.character(x)))

# Polish and save as RDA for easy loading
continents = cont
continents = continents[order(continents$continent), ]
continents = continents[, - which(names(continents) %in% c('percent_total_landmass', 'density_people_per_km2'))]
rownames(continents) = NULL
save(continents, file = 'data/continents.RDA')
