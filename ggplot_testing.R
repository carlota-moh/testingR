ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, colour = Species)) +
  geom_point(position = 'identity') +
  theme_classic() +
  labs(x = 'Longitud del sépalo (cm)', y = 'Anchura del sépalo (cm)') +
  ggtitle('Iris') +
  theme(plot.title = element_text(size = rel(1.5), hjust = 0.5), axis.title = element_text(size = rel(1.5))) +
  scale_colour_manual(values =c('pink', 'orange', 'purple'))
    
iris_sum <- iris %>% group_by(Species) %>% summarise_all(mean) 
iris_sum

ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point() +
  geom_point(data = iris_sum, size = 5)

ggplot(iris, aes(x = Sepal.Width, fill = Species)) +
  geom_histogram(binwidth = 0.1, position = 'dodge', alpha = 0.5) +
  scale_fill_manual(values = c('pink', 'orange', 'purple'))

ggplot(iris, aes(Species, fill = Species)) +
  geom_bar(alpha = 0.5) +
  scale_fill_manual(values = c('pink', 'orange', 'purple'))

iris_sum <- iris %>% group_by(Species) %>% summarise(avg = mean(Sepal.Width), std = sd(Sepal.Width))
iris_sum

ggplot(iris_sum, aes(x = Species, y = avg)) +
  geom_col() +
  geom_errorbar(aes(ymin = avg - std, ymax = avg + std), width = 0.1)

gapminder %>% filter(country == 'Spain') %>% mutate(pop = pop / 1e6) %>% 
  ggplot(aes(x = year, y = pop)) +
  geom_line() +
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(x = 'Year', y = 'Population (millions)') +
  ggtitle('Evolution of Spanish population')
  


        