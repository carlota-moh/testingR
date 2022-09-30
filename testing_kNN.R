# In this code we are going to test how to perform k-nearest neighbor algorithm using the iris dataset (provided by R)

# First we load the data set onto a variable

iris <- iris
str(iris) # Have a look at the structure of the df
summary(iris) # Have a look at the variables in the df

# Our goal is to train the algorithm so that it is able to classify a random sample of iris flower into one of the 3 species (setosa, versicolor, virginica). 

# To do this, we may first mix up the data frame so that the samples belonging to each species are not clustered together. To do this, we generate random numbers with the runif() function and use them to set the order of the df rows.

ord <- runif(nrow(iris)) # Generate 50 random numbers
iris <- iris[order(ord),] # Order the rows according to the random numbers
head(iris) # Check if this worked

# If we take a look at the variables within the df, we notice that their respective scale is different (they have different mins and maxs)

summary(iris)

# To correct this, we must use normalization, so that within each variable min = 0 and max = 1. In order to do this, we can create a new function that applies the appropriate formula for min-max normalization:

norm <- function(x) {
  return((x-min(x))/(max(x)-min(x)))
}

iris_n <- as.data.frame(lapply(iris[, 1:4], FUN = norm))
str(iris_n) # Check that samples are still present
summary(iris_n) # Check if norm worked

# Notice that in iris_n we eliminated the species col

# Now we will create a training data set (to train the model to recognize the pattern) and a test data set (to test how well the algorithm predicts)

# Since we have 150 samples, we will use 80 % of them as a training cohort (n = 120) and leave the remaining 20 % as a testing cohort (n = 30).

iris_train <- iris_n[1:120, ]
iris_test <- iris_n[121:150, ]

# We also need to store the values for the variable that explains the categories (Species, in this case). We may store this data in a separate variable:

train_category <- iris[1:120, 5] 
test_category <- iris[121:150, 5]

# Note that in this case we selected the information from the original df, since the normalized one did not have information about the species. 

# Now we load knn from the 'class' package 

library(class)

m1 <- knn(train = iris_train, test = iris_test, cl = train_category, k = 13) 

# As a rule of thumb, use a value for k that is roughly the same as the sqrt of the obs. Try to use an odd number to avoid ties between categories

# The resulting factor contains ordered information about the categories the algorithm assigned to the testing cohort. To check how well the process went, we can create a confussion table comparing the results from this classification to the original classification (stored in test_category)

table(test_category, m1)

# Within this table, the diagonal represents the correctly classified samples, whereas the values for above and below it represent the mistakes the algorithm made. 

# Let's try again, but this time we will use a larger testing cohort (n = 130)

iris_train <- iris_n[1:130, ]
iris_test <- iris_n[131:150, ]
train_category <- iris[1:130, 5]
test_category <- iris[131:150, 5]

m2 <- knn(train = iris_train, test = iris_test, cl = train_category, k = 13)

table(test_category, m2)

# As we can see, the percentage of error did not change much compared to the previous example. Now we will play with the values of k and see how it affects the classification 

m3 <- knn(train = iris_train, test = iris_test, cl = train_category, k = 2)

table(test_category, m3)

m4 <- knn(train = iris_train, test = iris_test, cl = train_category, k = 25)

table(test_category, m4)

# As we can see, a larger k is not always the best idea.
