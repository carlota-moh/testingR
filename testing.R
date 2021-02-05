# This is the document I used over several days to practice my lessons in R. The theory and exercises may be recovered from this workshop: https://hbctraining.github.io/Intro-to-R/schedules/1.5-day.html

# Let's start with variables. In order to assign a variable, use <- (Alt + - is a shortcut)

x <- 3
y <- 5
number <- x + y
x <- 5
number <- x+ y 

# Introducing vectors c(), which are a kind of data structure containing THE SAME data type

glengths <- c(4.6, 300, 3000)

# In order to add elements to the vector, use the following syntax

glengths <- c(glengths, 90) # This will add the element at the end
glenghts <- c(30, glengths) # This will add the element at the beginning

# You can call the variable in order to print it

glengths

# You can also combine different vectors as part of a larger vector using the same c() function

species <- c('e.coli', 'human', 'corn')
combined <- c(glengths, species)
combined

# Now onto factors, which are a dif type of data structure that allow you to assign categories (or factor levels) to a vector in this fashion

expression <- c('low', 'high', 'medium', 'high', 'low', 'medium', 'high')
expression <- factor(expression)
# [1] low    high   medium high   low    medium high  
# Levels: high low medium

samplegroup <- c('CTL', 'CTL', 'CTL', 'KO', 'KO', 'KO', 'OE', 'OE', 'OE')
samplegroup <- factor(samplegroup)
#[1] CTL CTL CTL KO  KO  KO  OE  OE  OE 
# Levels: CTL KO OE

#We also have data frames, which are an organized form of structuring data. It comprises dif vectors organized as column. These vectors may differ in data type among themselves, but they need to have the same length in order to form a data frame

df <- data.frame(species, glengths)
df
#   species glengths
# 1  e.coli      4.6
# 2   human    300.0
# 3    corn   3000.0

#lists are used to gather together dif data structures. While data frames require the data to be of the same length, lists are global clusters of info that do not require this feature.

list1 <- list(species, df, glengths)
list1
# [[1]]
# [1] "e.coli" "human"  "corn"  

# [[2]]
# species glengths
# 1  e.coli      4.6
# 2   human    300.0
# 3    corn   3000.0

# [[3]]
# [1]    4.6  300.0 3000.0   90.0

# Next are functions. They are comprised of a name and an argument in the following manner

sqrt(81)
sqrt(glengths)

round(3.141592)
?round # This is used to call for help on the use of the function

ceiling(3.141592)
args(round) # This is used if you have a general grasp of what the function does but need refreshment on the arguments it needs to pass

example('round') # This provides an example of the use of the function

?array
example('array')

mean(glengths)
?mean

mean(glengths, trim = 0.05)

# You can also design your own functions as follows

square_it <- function(x) {
  square <- x * x
  return(square)
}

square_it(2)

# Let's move on to packages, which are extra tools you can use to get access to more functionalities apart from the basic ones.

sessionInfo() # Use this command in order to get information of the packages you have installed

# First, you need to install the desired package as follows: 

install.packages('ggplot2')
install.packages('BiocManager')

# In order to execute a function belonging to a particular package, use this syntax 

# package::function_name() 

# install.packages("~/Downloads/ggplot2_1.0.1.tar.gz", type="source", repos=NULL) is used to install from source, a local directory, if you do not have internet access

# Once the package is install, you need to turn it on by using library(package_name) as follows:

library(ggplot2)

# Example:

install.packages('tidyverse')
library(tidyverse)

# Now we are going to cover how to read files. Most of the files we will encounter are .csv, so the function we will be using is read.csv() with the following syntax:

metadata <- read.csv(file = 'data/mouse_exp_design.csv', stringsAsFactors = FALSE)

# Note that this function automatically converts the characters in the names of the columns to factors, so if you do not want the function to do this you may use the argument stringAsFactors = FALSE.

# Other useful functions include:

head(metadata) # Retrieve the first 6 rows of the file, useful if you have way too many rowns and do not wish to show them all at once
str(metadata) # Used to get the structure of the data frame
summary(metadata) # Detailed display, including descriptive statistics, frequencies
dim(metadata) # Returns dimensions of the dataset
rownames(metadata) # Row names
colnames(metadata) # Column names

# Now we are going to practice selecting data

age <- c(15, 22, 45, 52, 73, 81)

# Remember that you use [] to select the position within the vector you wish to work with. The first position of the vector is 1, instead of 0 (as in Python)

age[5]
# [1] 73

# If we wanted all the values except the fifth one, we would use age[-5]

age[-5]
#[1] 15 22 45 52 81

# In order to select several values, pass them in the brackets as a vector

age[c(3, 5, 6)]
#[1] 45 73 81

# We could also create a variable to store this vector and pass it 

idx <- c(3, 5, 6)
age[idx]
# [1] 45 73 81

# To select a continuous sequence of values, use :

age[1:4] # Selects the first four values of the vector
# [1] 15 22 45 52

# Exercise: Create a vector called alphabets with the following letters, C, D, X, L, F.

alphabets <- c('C', 'D', 'X', 'L', 'F')

# Use the associated indices along with [ ] to do the following: 

# only display C, D and F

idx <- c(1, 2, 5)
alphabets[idx]
# [1] "C" "D" "F"

# display all except X

alphabets[-3]
# [1] "C" "D" "L" "F"

# display the letters in the opposite order (F, L, X, D, C)

alphabets[5:1]
# [1] "F" "L" "X" "D" "C"

# Let's study logical operators. They are used in order to assess whether a condition is true or not. Using the age vector, we could asses if each element is less than 50 or not in the following manner:

age < 50
# [1]  TRUE  TRUE  TRUE FALSE FALSE FALSE

age > 50 | age < 18 #This is the OR operator. It evaluates to TRUE if at least on of the conditions is true
# [1]  TRUE FALSE FALSE  TRUE  TRUE  TRUE

# We could also select the values that fulfill the condition using []

age[age > 50 | age < 18]
# [1] 15 52 73 81

# We could also use which(), a function that returns the INDEX of the elements that fulfill the condition

which(age > 50 | age < 18)
# [1] 1 4 5 6

age[which(age > 50 | age < 18)]
# [1] 15 52 73 81

# These rules also apply to factors. Exercise: extract those elements in samplegroup that equal KO

samplegroup[samplegroup == 'KO']
# [1] KO KO KO
# Levels: CTL KO OE
which(samplegroup == 'KO')
# [1] 4 5 6

# In order to relevel categories in a factor, you need to add the levels() argument within the factor, passing in a vector with the levels in the desired order. Let's do this with the expression vector 

expression <- factor(expression, levels=c('low', 'medium', 'high'))
expression
# [1] low    high   medium high   low    medium high  
# Levels: low medium high
str(expression)
# Factor w/ 3 levels "low","medium",..: 1 3 2 3 1 2 3

# Exercise: Use the samplegroup factor we created in a previous lesson, and relevel it such that KO is the first level followed by CTL and OE.

samplegroup <- factor(samplegroup, levels = c('KO', 'CTL', 'OE'))
str(samplegroup)
# Factor w/ 3 levels "KO","CTL","OE": 2 2 2 1 1 1 3 3 3