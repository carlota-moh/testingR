pca <- prcomp(iris[,-5], scale = TRUE) # The scale argument allows us to scale the values of the different components so that they can be compared to each other even if the units they have are different

# When we center the data it means that we reorder it so that the mean is 0. When we scale, we divide by the sdev so that each unit is a sdev change.

plot(iris$Sepal.Length, iris$Sepal.Width)
plot(scale(iris$Sepal.Length), scale(iris$Sepal.Width))

# We can see that the relationship between the data does not change, but we do get rid off of the units so they do not matter anymore

pca <- prcomp(iris[,-5], scale = TRUE) 
pca

# The output shows a section for sdev and another section for rotation

# First let's focus on rotation. We can see that we have 4 PCs (ordered by how much they contribute to the variability observed in the data). Below each one of them we can see a value for each variable that we entered. These are called the Eigen vectors. They correspond to the values by which the original variable is multiplied to calculate the PC for each particular observation. 

summary(pca)

# Standard deviation is the sdev of the data along a single PC (measures the variability across each PC)

# Proportion of variance is the proportion of all the variability in the original data that is explained by the PC (i.e.: 73% of the variability observed in the data is due to PC1)

# Cumulative proportion accumulates the values of the proportion of variance (i.e.: if we take only PC1 we account for the 73% of the variability, but if we take PC1 and PC2 we can study 95% of this variability)

plot(pca, type = 'b') # Creates a scree plot that helps us visualize the variance for each PC

# We can also use another function called biplot() in order to analyze each of the components and their respective contribution to PC1 & PC2

biplot(pca, scale = 0)

# The red arrows represent the Eigen vectors for each variable. In this example, if an observation has a high value for PC1 it will have a lower value for Seal.Width and higher values for the other variables. Alternatively, if an observation has a higher value for PC2 it will have lower value for Sepal.Width, slightly higher value for Sepal.Length but basically no difference between the other two variables.

# Now we are going to extract the values for PC1 and PC2, convert them into a data.frame and use ggplot2 to create a more aesthetical plot.

# Note that the values for the PCs are stored in x within pca, so in order to extract them:

pca_df <- data.frame(pca$x[,1], pca$x[,2])
colnames(pca_df) <- c('PC1', 'PC2')
iris2 <- data.frame(iris, pca_df)

ggplot(iris2, aes(PC1, PC2, col = Species, fill = Species)) +
    geom_point(shape = 21, col = 'black') +
  stat_ellipse(geom = 'polygon', col = 'black', alpha = 0.5) +
  scale_fill_manual(values = c('pink', 'orange', 'purple'))

# We can also try an look at the correlation that exists btw the original variables and the PCs (to look if a PC changes if one variable goes up or down). We do this by use cor()

cor(iris[, -5], iris2[, c('PC1', 'PC2')])

# The data provided is equivalent to the one obtained by interpreting the biplot() plot we did before