# filter() allows us to filter the data according to a specific parameter, but showing all of the cols

starwars %>% filter(species == 'Droid')

starwars %>% filter(species %in% c('Droid', 'Human'))

starwars %>% filter(species == 'Droid', height < 100)

# arrange() orders the data within the cols (it swaps the rows around)

starwars %>% arrange(desc(height))

starwars %>% arrange(mass, height)

# We can also combine functions

starwars %>% filter(species == 'Droid') %>% arrange(desc(height))

# select() allows us to choose certain cols

starwars %>% select(name, hair_color, skin_color, eye_color)

starwars %>% select(name, hair_color:eye_color)

starwars %>% select(ends_with('color'))

# We can also remove these cols

starwars %>% select(-c(hair_color, skin_color, eye_color))

# mutate() allows us to introduce new cols to the tibble. 

starwars %>% mutate(height_m = height / 100) %>% select(name,starts_with('height'), everything())

# Remember that in order to preserve the changes we must store them inside a new variable

starwars_bmi <- starwars %>% mutate(BMI = mass / (height / 100) ^ 2) %>% select(name, species, homeworld, sex, BMI)

starwars_bmi

# Count allows us to count elements

starwars %>% count(species)

starwars %>% count(species, sort = TRUE) # sort = TRUE will show the largest groups at the top

# Summarise() applies a function to all the values in a col

starwars %>% summarise(height = mean(height, na.rm = TRUE))

starwars %>% filter(species == 'Droid') %>% 
  summarise(Media = mean(height, na.rm = TRUE),
            Desviación = sd(height, na.rm = TRUE))

# Finally, group_by() groups the data according to a parameter

starwars %>% group_by(species) %>% summarise(Altura_media = mean(height, na.rm = TRUE))

starwars %>% group_by(species, sex) %>% summarise(Altura_media = mean(height, na.rm = TRUE)) %>% arrange(desc(Altura_media))

# Exercise

gapminder <- gapminder

gapminder %>% filter(year == 2007)

gapminder %>% filter(year == 2007, country == 'Spain') %>% select(lifeExp)

gapminder %>% filter(continent == 'Europe') %>% arrange(desc(gdpPercap))

gapminder %>% group_by(year,country) %>% summarise(PIB = gdpPercap * pop / 1e6) %>% ungroup()

gapminder %>% group_by(continent) %>% summarise(media = mean(lifeExp)) %>% ungroup()

gapminder %>% group_by(continent, year) %>% summarise(pop_tot = sum(pop))

gap_2007 <- gapminder %>% filter(year == 2007) %>% mutate(pop = pop / 1e6)
gap_2007
