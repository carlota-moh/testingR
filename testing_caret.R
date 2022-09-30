# Hello! This file was created in order to get a grasp of working with caret for data processing. The materials I used are available in Github; https://github.com/datasciencedojo/meetup/tree/master/intro_to_ml_with_r_and_caret as well as the youtube video tutorial: https://www.youtube.com/watch?v=z8PRU46I3NY

# We will be working with the Titanic data set from Kaggle's website. Our goal is to predict the survival of the Titanic and get familiar with machine learning (ML) basics. Data available on: https://www.kaggle.com/c/titanic

# install.packages(c('e1071', 'caret', 'doSNOW', 'ipred', 'xgboost'))
library(caret)
library(doSNOW) # Allows training in parallel

# Load data

train <- read.csv('data/train.csv', stringsAsFactors = FALSE)
View(train)

# Some of the cols are useless (PassengerID, Name, Tciket & Cabin), either because the data the provide is too complicated, too confusing, messy or incomplete, so we will not work with them.

# First we will perform some data wrangling

table(train$Embarked) # When looking at the table, we can see that there are two blanks in the data, which we will replace with the most common value aka mode (in this case, 'S'). Otherwise, the model may center on this missing value and end up overfitting.

train$Embarked[train$Embarked == ''] <- 'S'

# Note that this is a simple model used in very rare occasions, when you have only a couple values missing and there is an overwhelming difference between the mode and the other values. 

# Now let's take a look at age

summary(train$Age)

# In this case we have a lot of missing data (NAs), which accounts for more that 20% of the data. Because of this, we will use a more sophisticated alg than using just the median value. But in order to do this, we need to keep track of the samples that were originally missing. We do this by creating a new column with this information

train$AgeMissing <- ifelse(is.na(train$Age), 'Y', 'N')

# Now we will add a feature for family size. We will use this feature later on for creating decision trees using xgboost. The reason behind this is that DTs usually prefer to use less but more powerful features

train$FamilySize <- 1 + train$SibSp + train$Parch

# Note that we are just adding features, but not getting rid off of the original ones.

# Feature engineering is super important and you want to spend quite a bit of time in it. Generally, the better features you create, the better your model will work, so make sure you are paying enough attention to that.

# Next we transform some of the data into categorical variables (factors). This will help tell the alg that we are facing a classification problem, not a regression problem

train$Survived <- as.factor(train$Survived)
train$Pclass <- as.factor(train$Pclass) # Since it is not ratio data (e.g: 3rd class is not 3 times 1st class)
train$Sex <- as.factor(train$Sex)
train$Embarked <- as.factor(train$Embarked)
train$AgeMissing <- as.factor(train$AgeMissing)

# Subset the data features we wish to keep, excluding the unnecessary ones 

features <- c('Survived', 'Pclass', 'Sex', 'Age', 'SibSp', 'Parch', 'Fare', 'Embarked', 'AgeMissing', 'FamilySize')
train <- train[, features]
str(train)

# Now we are going to use caret to automatically input the missing ages. Because the imputation (aka: replacing missing values) methods in caret only work with num data, we need to transform the df with factors into nums. This is what's called the 'dummy variables'

# First, we transform all feature to dummy variables. To do this, we will train a dummy variables model and then use it to make a prediction with it over the train df (aka: using the model we just trained)

dummy_vars <- dummyVars(~ ., data = train[ ,-1]) # We are substracting the survive variable, as we do not want to use it in order to make predictions about age. Note that caret does not work on variables that are already numerical, so it will not work on Survived.
train_dummy <- predict(dummy_vars, train[, -1]) # After training, we will obtain the tranformed version of the df with no factors, but instead nums

# Now each variable has become a binary indicator. Once this is done, we use caret to create an imputation model that replaces the missing values with the most accurate predictions it can do based on the rest of the data, which is far more accurate than using the global median.

# To do this, we use the preProcess() function, which can center, scale, pca... Remember to always train first and predict second

pre_process <- preProcess(train_dummy, method = 'bagImpute') # training the model
imputed_data <- predict(pre_process, train_dummy) # use the model
View(imputed_data)

# Be careful! caret will create an imputation model for each col you have, not just for the missing values you already know, so be aware of it if you have tons of data. 

# If you wanted to test the accuracy of the imputation model, you could use it to predict the values of the age col in the places where you already know the ages, so that you can compare how well it did. 

train$Age <- imputed_data[, 6] # Select the imputed age col and replace the original age with it.
View(train)

# Now our data is complete, so we are ready to split the data with createDataPartition

# If your data where evenly divided into two classes, you could simply use random sampling. When this is not the case (as in this example), you need to create an estratified data partition, making sure that the data you work with is representative of the population.

# Since we are going to use random sampling, we should set a seed for reproducibility

set.seed(2301)
idx <- createDataPartition(train$Survived, times = 1, p = .7, list = FALSE)

# Note that we pass the col that we want the partition to base the relative proportions off of.

titanic_train <- train[idx, ]
titanic_test <- train[-idx, ]

# Check whether it worked by examining the relative proportions of the Survived class lable across the datasets

prop.table(table(train$Survived))
prop.table(table(titanic_train$Survived))
prop.table(table(titanic_test$Survived))

# Set up caret to perform 10-fold CV (basically it performs the alg 10 times and each time it splits the data in a different way, leaving one of the subsets out for testing) and this process can be repeated multiple times (thats what we indicate in repeats). This is a way of estimating how well the model would work in the real world on brand new data.

# train_control <- trainControl(method = 'repeatedcv', number = 10, repeats = 3, search = 'grid')

# Now we leverage a grid search f hyperparameters for xgboost. The args dont really matter, just know that expand.grid() will create random permutations of all of them, creating a data frame with the information. 

# tune_grid <- expand.grid(eta = c(0.05, 0.075, 0.1), nrounds = c(50, 75, 100), max_depth = 6:8, min_child_weight = c(2.0, 2.25, 2.5), colsample_bytree = c(0.3, 0.4, 0.5), gamma = 0, subsample = 1)

# Esentially, you will be asking caret to run 10-fold CV 3 times with all the possibles values of this table... Its going to take a while. So in order to spee things up, we can use doSNOW, which allows working in parallel. Its similar to when you open 30 tabs in Chrome: yes, the computer will slow down, but hey, it will go through the iterations faster.

# Since I do not have a mighty computer, I reduced the number of CVs and clusters so that I could run this code in less than 5 years.

train_control <- trainControl(method = 'repeatedcv', number = 4, repeats = 2, search = 'grid') 

tune_grid <- expand.grid(eta = c(0.05, 0.075, 0.1), nrounds = c(50, 75, 100), max_depth = 6:8, min_child_weight = c(2.0, 2.25, 2.5), colsample_bytree = c(0.3, 0.4, 0.5), gamma = 0, subsample = 1)

cl <- makeCluster(2, type = 'SOCK')

registerDoSNOW(cl) # Tell caret that it can use the instances created

# Now we are ready to actually build the model (hooray!)

caret_cv <- train(Survived ~ ., data = titanic_train, method = 'xgbTree', tuneGrid = tune_grid, trControl = train_control)

stopCluster(cl) # Once you are done with the process, shut down the clusters, since we will not use them anymore. 

# Now that the model is trained we can use it to make some predictions

preds <- predict(caret_cv, titanic_test)

# Finally, build a confusion matrix to estimate the effectiveness of the model on unseen data (aka testing data)

confusionMatrix(preds, titanic_test$Survived)
