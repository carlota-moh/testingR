x <- 3
y <- 5
number <- x + y
x <- 5
number <- x+ y 
glengths <- c(4.6, 300, 3000)
glengths
species <- c('e.coli', 'human', 'corn')
combined <- c(glengths, species)
combined
expression <- c('low', 'high', 'medium', 'high', 'low', 'medium', 'high')
expression <- factor(expression)
samplegroup <- c('CTL', 'CTL', 'CTL', 'KO', 'KO', 'KO', 'OE', 'OE', 'OE')
samplegroup <- factor(samplegroup)
df <- data.frame(species, glengths)
df
list1 <- list(species, df, glengths)
list1
glengths <- c(glengths, 90)
glenghts <- c(30, glengths)
sqrt(81)
sqrt(glengths)
round(3.141592)
?round
ceiling(3.141592)
args(round)
example('round')
?array
example('array')
mean(glengths)
?mean
mean(glengths, trim = 0.05)
square_it <- function(x) {
  square <- x * x
  return(square)
}
square_it(2)
sessionInfo()
install.packages('ggplot2')
install.packages('RTools')
install.packages('BiocManager')
#BiocManager::('name_of_package)