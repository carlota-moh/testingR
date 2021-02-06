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

# We could also use which(). The result will be the same as if we did not use it in this context, so I personally find it pointless

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

# The next step is learning how to select data on bidimensional data structures like matrices and data frames (note that the dimensions are rows and columns). Because we have 2 dimensions, we will need 2 indices inside the brackets. Remember that ROW num comes first and COL num comes sec, separated by a comma.

metadata
metadata[1, 1] # Selects the first row, first column
# [1] "Wt"
metadata[1, 3] # Selects first row, third column
# [1] 1

# You could also select just the row or just the column by leaving a blank space. The key is to keep the comma placed correctly

metadata[3, ] # Will select the whole third row
#         genotype celltype replicate
# sample3       Wt    typeA         3
metadata[ , 3] # Will select the whole third col
#  [1] 1 2 3 1 2 3 1 2 3 1 2 3

# You can also seelct multiple rows/cols by using vectors as before

metadata[c(1, 3, 6), ] #Will select the first, third and sisth rows
metadata[ ,1:2] # Will select the first two cols

# You can also use col names instead of numbers to refer to them when selecting

metadata[1:3, 'celltype'] # Will select the first three rows in the column named 'celltype'

# By using the $ sign we can select an entire col in order to operate with it. Example: if we wanted to extract all genotypes from our metadata data frame, we would do:

metadata$genotype
#  [1] "Wt" "Wt" "Wt" "KO" "KO" "KO" "Wt" "Wt" "Wt" "KO" "KO" "KO"

# This is also useful to select values within a particular col

metadata$genotype[1:5]
#[1] "Wt" "Wt" "Wt" "KO" "KO"

#Note that this last operation is equivalent to this one:

metadata[1:5, 1]
# [1] "Wt" "Wt" "Wt" "KO" "KO"

# Or this one:

metadata[1:5, 'genotype']
# [1] "Wt" "Wt" "Wt" "KO" "KO"

# Note that there is no $ in rows, but you can used the other methods above explained to select them

# Use colnames() or names() in order to remind yourself of the col names in a data frame. To do so in rows, use rownames()

colnames(metadata)
# [1] "genotype"  "celltype"  "replicate"

rownames(metadata)
# [1] "sample1"  "sample2"  "sample3"  "sample4"  "sample5" 
# [6] "sample6"  "sample7"  "sample8"  "sample9"  "sample10"
# [11] "sample11" "sample12"

# In order to select multiple cols/rows you need to concatenate them inside a vector

metadata[ ,c('genotype', 'replicate')]
metadata[c('sample10', 'sample12'), ]

# We can also use variables and logical operations to select particular rows inside a col which have the value we want. Example: select all the samples whose cell type is A within the metadata data frame

idx <- metadata$celltype == 'typeA'
metadata[idx, ]

# We can also use the which() and the result will still be the exact same

idx <- which(metadata$celltype == 'typeA')
sub_meta <- metadata[idx, ]

# Exercise: Subset the metadata dataframe to return only the rows of data with a genotype of KO.

idx_1 <- metadata$genotype == 'KO'
sub_meta_1 <- metadata[idx_1, ]
sub_meta_1

# We have other options available for subsetting, such as the filter() and subset() functions.

subset(metadata, subset = metadata$genotype == 'KO') # Will create a subset of metadata in which we will have selected the rows that are TRUE for the established condition 

# When working with list, we need to use a double bracket notation [[]]

list1[[2]] # This selects the second element on the whole list. In this case, it corresponds to the data frame comprising the vectors species and glengths

# By using an additional bracket we can reference what's stored inside the list component. Example:

list1[[1]] # Will select the first component of the list
# [1] "e.coli" "human"  "corn" 
list1[[1]][1] # Will select the first element of the first component of the list
# [1] "e.coli"

# Same goes for elements of matrices and data frames stored inside a list, but it is advisable to store the component of the list in a variable and work with it:

comp1 <- list[2]

# Note that if we use a single bracket the original data structure is not retrieved, but rather the information as a list:

one_bracket <- list1[2]
class(one_bracket)
# [1] "list"
two_brackets <- list1[[2]]
class(two_brackets)
# [1] "data.frame"

# Exercises

# Lets practice inspecting lists. Create a list named random with the following components: metadata, age, list1, samplegroup, and number.

random <- list(metadata, age, list1, samplegroup, number)

# Print out the values stored in the samplegroup component

random[[4]]

# From the metadata component of the list, extract the celltype column. From the celltype values select only the last 5 values.

random[[1]][8:12, 'celltype']

# We can assign dif names to the components of the list and check them using names()

names(list1) <- c('species', 'df', 'number')
names(list1)

# We can use this to extract a particular component from a list using $ as we did before. This gives us three methods to access the same information:

list1$species
list1[[1]]
list1[['species']]

# Exercise:

# Set names for the random list you created in the last exercise

names(random) <-  c('metadata', 'age', 'list', 'samplegroup', 'number')

# Extract the third component of the age vector from the random list.

random[['age']][3]
# [1] 45

# Extract the genotype information from the metadata dataframe from the random list.

random$metadata$genotype
# [1] "Wt" "Wt" "Wt" "KO" "KO" "KO" "Wt" "Wt" "Wt" "KO" "KO" "KO"

# So far we haven't modified the files. In order to do this, we need to use the write function. It requires two arguments: the variable name of the data structure you are exporting and the path and filename you are exporting it to.

write.csv(sub_meta_1, file = 'data/subset_meta_1.csv')

# This will create a new file that stores the information we tell it to. Let's try and read the file

read.csv('data/subset_meta_1.csv')

# Sometimes when writing a data frame with row names to file, the column names will align starting with the row names column. To avoid this, you can include the argument col.names = NA when writing to file to ensure all of the column names line up with the correct column values.

# If we instead want to write a set of vectors to file use the write() function:

write(glengths, file="data/genome_lengths.txt", ncolumns=1)

read.table('data/genome_lengths.txt')

# The next thing we will work on is working with the RNAseq data. For this we need to open the counts.rpkm.csv file

rpkm_data <- read.csv('counts.rpkm.csv')

# We will take a look at the few first lines using head()

head(rpkm_data)

# Since the number of cols looks similar to the number or rows in metadata, we can check using ncol() and nrow() and see if they match

ncol(rpkm_data)
# [1] 12
nrow(metadata)
# [1] 12

# This does not mean that we have data for every sample we have metadata, so we need to check it out using %in%. It will take a vector c() to the left and evaluate if there is a match in the vector that follows on the right operator. The two vectors do not need to have the same size. The operation will return a logical vector with the size of vector1 whose values indicate whether or not there is a match. For example:

A <- c(1, 3, 5, 7, 9, 11)
B <- c(2, 4, 6, 8, 1, 5)

A %in% B
# [1]  TRUE FALSE  TRUE FALSE FALSE FALSE

# Once we have this information, we can recover only the TRUE values by indexing them and using the index as a selection within the vector as follows:

intersection <- A %in% B
A[intersection]
# [1] 1 5   

# Since the vectors used are small we can manage this information easily, but this is not feasible when working with larger datasets, in which case we shall use the functions any() or all()

any(A %in% B) # Tells us whether there is some value within A that is also inside B
# [1] TRUE
all(A %in% B) # Tells us whether all the values in A are contained in B
# [1] FALSE

# Exercise: Using the vectors A and B, evaluate the values in B to see if there is a match in A

any(B %in% A)
# [1] TRUE

# Or:

B %in% A

# [1] FALSE FALSE FALSE FALSE  TRUE  TRUE

# Subset the vector B to return only the values that are also in A

inter <- (B %in% A)
B[inter]
# [1] 1 5

# We could also use == to evaluate each position of the vector and test whether or not the values are in the same order. For his to work, the vectors need to have the same length.

C <- c(10, 20, 30, 40, 50)
D <- c(50, 40, 30, 20, 10)

C %in% D # To test if they have the same values regardless of their order
# [1] TRUE TRUE TRUE TRUE TRUE

C == D # To check if they are ordered in the same manner
# [1] FALSE FALSE  TRUE FALSE FALSE

all(C == D) # To check if they are a perfect match, without evaluating individual positions
# [1] FALSE

# Now we will try this on our data. We will start by crating two vectors containing rownames of metadata and colnames of data

x <- rownames(metadata)
y <- colnames(rpkm_data)

# Now check if all the components of x are present in y

all(x %in% y)
# [1] TRUE

# Now we must check for their order

all(x == y)
# [1] FALSE

# All of the samples are there, but they need to be reordered

# Exercise: We have a list of 6 marker genes that we are very interested in. Our goal is to extract count data for these genes using the %in% operator from the rpkm_data data frame, instead of scrolling through rpkm_data and finding them.

important_genes <- c("ENSMUSG00000083700", "ENSMUSG00000080990", "ENSMUSG00000065619", "ENSMUSG00000047945", "ENSMUSG00000081010", "ENSMUSG00000030970")

important_genes %in% rownames(rpkm_data)
# [1] TRUE TRUE TRUE TRUE TRUE TRUE

# Extract the rows from rpkm_data that correspond to these 6 genes using [] and the %in% operator. Double check the row names to ensure that you are extracting the correct rows.

sub_rpkm_data <- rpkm_data[important_genes, ]

# Now onto reordering data. This task can be accomplished using re-indexing. If we create a vector:

teaching_team <- c("Jihe", "Mary", "Meeta", "Radhika")

# We can extract values from it using []

teaching_team[c(2, 4)] # Will extract the values stored in the second and fourth position
# [1] "Mary"    "Radhika"

# We can also extract values and reorder them:

teaching_team[c(4, 2)] # Will extract the values stored in the defined position, but in another order without affecting the original vector

# If we wanted to reorder the vector itself, we need to store the change onto a variable. This variable can be the original vector itself or another one:

reorder_teach <- teaching_team[c(4, 2, 1, 3)]
teaching_team
# [1] "Jihe"    "Mary"    "Meeta"   "Radhika"
reorder_teach
# [1] "Radhika" "Mary"    "Jihe"    "Meeta" 

# The match() function is used to match the vales in two vectors. It takes at least two arguments: a vector of values in the order you want and a vector of values to e reordered. The function returns the position of the matches (indices) with respect to the second vector, which can be used to re-order it so that it matches the order in the first vector.

first <- c("A","B","C","D","E")
second <- c("B","D","E","A","C")

# If we want to re-order second so that it matches first, we use the match() function:

match(first, second)
# [1] 4 1 5 2 3

# The output of the function tells you the order in which you need to put the elements of the second vector for it o match the first vector. You can use this information to re-order the second vector.

reorder_sec <- match(first, second)
second_reord <- second[reorder_sec]

# Or:

second_reord <- second[match(first, second)]

# If we tried this operation with two vectors of different size, some values will not match,returning an NA value. You can specify what values you would have it assigned using nomatch argument. Also, if there is more than one matching value found only the first is reported.

first <- c("A","B","C","D","E")
second <- c("D","B","A")
match(first, second)
# [1]  3  2 NA  1 NA

# Lets apply this to our genomic data. We now would like to match the row names of our metadata to the column names of our expression data:

rows <- rownames(metadata)
cols <- colnames(rpkm_data)
order <- match(rows, cols)
rpkm_ordered <- rpkm_data[c(order)]
all(colnames(rpkm_ordered) == rownames(metadata)) # Check if the process worked

# Now we want to make plots to evaluate the average expression in each sample and its relationship with the age of the mouse. In order to do this we need to add some additional columns of information to the metadata data frame we used earlier. 

# The first thing we want to do is get the average expression level for each of our samples. We will do this by using the data in rpkm_data_ordered, in which each column corresponds to a sample. If we only wanted to do this for one sample, we will use mean():

mean(rpkm_data_ordered$sample1)

# But because we want to repeat this process across all columns, we would need to use some kind of loop (such as a for loop). Another way of doing this is by using the map() family of functions.

# First we have to load the purrr package, which contains the map() functions.

library(purrr)

# Each of the map() functions take a vector as an input and outputs a vector of a specified type. This helps us to execute a particular function on each of the elements in a vector, every column of a dataframe, every component of a list... The otuput you get may vary depending of the map() function you choose:

# map() creates a list.
# map_lgl() creates a logical vector.
# map_int() creates an integer vector.
# map_dbl() creates a “double” or numeric vector.
# map_chr() creates a character vector.

# The basic syntax is map(object, function_to_apply)

# So, back to our example, once we have loaded our library we want to apply the map_dbl() function to our rpkm_data_ordered dataframe so that we can apply the mean() function to each of the columns, thus creating a new vector containing this information.

sample_means <- map_dbl(rpkm_data_ordered, mean)

# Now we wan to create yet another vector with the information of the ages of the mice

age_in_days <- c(40, 32, 38, 35, 41, 32, 34, 26, 28, 28, 30, 32)

# Now we are ready to add this information to our metadata as new columns

new_metadata <- data.frame(metadata, sample_means, age_in_days)

# Once we are done with this we can move on to data visualization using ggplot2. Remember that it expects a data frame as input in order to work properly

# We will start with drawing a simple x-y scatterplot of samplemeans versus age_in_days from the new_metadata data frame. 

ggplot(new_metadata)

# The ggplot() function is used to initialize the basic graph structure, then we add to it. The basic idea is that you specify different parts of the plot using additional functions one after the other and combine them into a “code chunk” using the + operator; the functions in the resulting code chunk are called layers

# The geom (geometric) object is the layer that specifies what kind of plot we want to draw. A plot must have at least one geom; there is no upper limit. Examples:

# points (geom_point, geom_jitter for scatter plots, dot plots, etc)
# lines (geom_line, for time series, trend lines, etc)
# boxplot (geom_boxplot, for, well, boxplots!)

# In this example we want to create a scatter plot, so we will be using geom_point()

ggplot(new_metadata) +
  geom_point()
# Error: geom_point requires the following missing aesthetics: x and y

# We get an error because each type of geom usually has a required set of aesthetics to be set. “Aesthetics” are set with the aes() function and can be set either nested within geom_point() (applies only to that layer) or within ggplot() (applies to the whole plot)

# The aes() function has many different arguments, and all of those arguments take columns from the original data frame as input. It can be used to specify many plot elements (positions, color, fill, shape of points,linetype...)

ggplot(new_metadata) +
  geom_point(aes(x = age_in_days, y = sample_means))

# We can color the points on the plot based on the genotype column within aes().

ggplot(new_metadata) +
  geom_point(aes(x = age_in_days, y = sample_means, color = genotype))

# Let’s try to have both celltype and genotype represented on the plot. To do this we can assign the shape argument in aes() the celltype column, so that each celltype is plotted with a different shaped data point.

ggplot(new_metadata) +
  geom_point(aes(x = age_in_days, y = sample_means, color = genotype, shape = celltype))

# The data points are quite small. We can adjust the size of the data points within the geom_point() layer, but it should not be within aes() since we are not mapping it to a column in the input data frame, instead we are just specifying a number.

ggplot(new_metadata) +
  geom_point(aes(x = age_in_days, y = sample_means, color = genotype, shape = celltype), size = 2.25)

# The labels on the x- and y-axis are also quite small and hard to read. To change their size, we need to add an additional theme layer. The ggplot2 theme system handles non-data plot elements (legends, axis labels, plot background...)

# Lets add a layer theme_bw()

ggplot(new_metadata) +
  geom_point(aes(x = age_in_days, y = sample_means, color = genotype, shape = celltype), size = 3.0) +
  theme_bw()

# We can add arguments using theme() to change the size of axis labels ourselves. Here we’ll increase the size of the axes titles to be 1.5 times the default size. When modifying the size of text we often use the rel() function. In this way the size we specify is relative to the default.

ggplot(new_metadata) +
  geom_point(aes(x = age_in_days, y = sample_means, color = genotype, shape = celltype), size = 3.0) +
  theme_bw() +
  theme(axis.title = element_text(size = rel(1.5)))

# The current axis label text defaults to what we gave as input to geom_point (i.e the column headers). We can change this by adding additional layers called xlab() and ylab() for the x- and y-axis, respectively. Add these layers to the current plot such that the x-axis is labeled “Age (days)” and the y-axis is labeled “Mean expression”. Use the ggtitle layer to add a title to your plot.

ggplot(new_metadata) +
  geom_point(aes(x = age_in_days, y = sample_means, color = genotype, shape = celltype), size = 3.0) +
  theme_bw() +
  theme(axis.title = element_text(size = rel(1.5))) +
  xlab('Ages (days)') +
  ylab('Mean expression') +
  ggtitle('New metadata') +
  theme(plot.title=element_text(hjust=0.5))

# When publishing, it is helpful to ensure all plots have similar formatting. To do this we can create a custom function with our preferences for the theme.

personal_theme <- function() {
  theme_bw() +
    theme(axis.title = element_text(size = rel(1.5)),
          plot.title = element_text(size = rel(1.5), hjust = 0.5))
}

# Now to run our personal theme with any plot, we can use this function in place of the theme() code

ggplot(new_metadata) +
  geom_point(aes(x = age_in_days, y = sample_means, color = genotype, shape = celltype)) +
  xlab('Ages (days)') +
  ylab('Mean expression') +
  ggtitle('New metadata') +
  personal_theme()