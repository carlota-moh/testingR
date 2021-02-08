# In this new file we will be learning how to work with tidyverse. First, lets load the library

library(tidyverse)

# In tidyverse, instead of stringing together many functions we use the pipe %>% (shift + control + M is a shortcut). For example:

round(sqrt(83), digit = 2) #R command
sqrt(83) %>% round(digit = 2) #Piping

# It's similar to saying "take the output from the previous function and use it as input for this one"

# Exercise: Extract the replicate column from the metadata data frame (use the $ notation) and save the values to a vector named rep_number.

rep_number <- c(metadata$replicate)

# Use the pipe to perform the following operations in a single line of code: Turn rep_number into a factor and use the head() function to return the first six values of the rep_number factor.

factor(rep_number) %>% head()

# Another component we will be looking into is tibbles, which are similar to data frames but with different rules. To create one, simply use the function tibble(). To convert a data.frame into a tibble, use as_tibble(name_of_data-frame)

# For this class we will be using some data and our goal is to compare the most significant biological processes (BP) based on the number of differentially expressed genes (gene ratios) and significance values by creating a plot. 

# First let's open the file an save the data to a varible using the read_delim() function:

functional_GO_results <- read_delim('data/gprofiler_results_Mov10oe.csv', delim = '\t')
functional_GO_results

# Note that the variable was automatically read as a tibble, also providing the number of rows and cols as well as the data type for each col. 

# Now that we have our data, we will need to wrangle it into a format ready for plotting. For all of our data wrangling steps we will be using tools from the dplyr package.

# To extract the biological processes of interest, we only want those rows where the domain is equal to BP, which we can do using the filter() function. To filter rows of a data frame/tibble based on values in different columns, we give a logical expression as input to the filter() function to return those rows for which the expression is TRUE.

bp_oe <- functional_GO_results %>% filter(domain == 'BP')
view(bp_oe)

# For bp_oe, use the filter() function to only keep those rows where the relative.depth is greater than 4. Save the output to overwrite our bp_oe variable

bp_oe <- bp_oe %>% filter(relative.depth > 4)

# For visualization purposes, we are only interested in the columns related to the GO terms, the significance of the terms, and information about the number of genes associated with the terms. In order to do this, we use the select() function. In this case, we do not need to put the names between '' in order to select the columns.

bp_oe <- bp_oe %>% select(term.id, term.name, p.value, query.size, term.size, overlap.size, intersection)

# The select() function also allows for negative selection. So we could have alternately removed columns with negative selection. Note that we need to put the column names inside of the combine (c()) function with a - preceding it for this functionality

# Now that we have only the rows and columns of interest, let’s arrange these by significance, which is denoted by the adjusted p-value. We will use the arrange() function.

bp_oe <- bp_oe %>% arrange(p.value)

# If we wanted to arrange with descending order, we could hae used arrange(desc(p.value)) instead

# While not necessary for our visualization, renaming columns more intuitively can help with our understanding of the data using the rename() function. The syntax is new_name = old_name

bp_oe <- bp_oe %>% rename(GO_term = term.name, GO_id = term.id, genes = intersection)

# Finally, before we plot our data, we need to create a couple of additional metrics. The mutate() function enables you to create a new column from an existing column. Let’s generate gene ratios to reflect the number of DE genes associated with each GO process relative to the total number of DE genes.

bp_oe <- bp_oe %>% mutate(gene_ratio = overlap.size/query.size)

# Create a column in bp_oe called term_percent to determine the percent of DE genes associated with the GO term relative to the total number of genes associated with the GO term (overlap.size / term.size)

bp_oe <- bp_oe %>% mutate(term_percent = overlap.size/term.size)

# Now that we have our results ready for plotting, we can use the ggplot2 package to plot our results.

