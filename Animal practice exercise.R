speed <-c(40, 120, 0.1, 48, 80, 30)
color <- c('Gray', 'Tan', 'Green', 'Grey', 'Tan', 'White')
animals <- c('Elephant', 'Cheetah', 'Tortoise', 'Hare', 'Lion', 'Polar Bear')

animal_data <- data.frame(animals, speed, color)
animal_data

# Extract the speed of 40 km/h

speed_40 <- animal_data$speed == 40.0
animal_data[speed_40, ]

# Return the rows with color of Tan.

color_tan <- animal_data$color == 'Tan'
animal_data[color_tan, ]

# Return the rows with speed greater than 50 km/h and output only the color column. Keep the output as a data frame.

fast <- speed < 50
selection <- animal_data[fast, 'color']
as.data.frame(selection)

# Change the color of “Grey” to “Gray”.

animal_data[4, 3] <- 'Gray'
