# Getting and Cleaning Data Course Project

We are analyzing raw data from accelerometers on Samsung Galaxy smartphones. A description of the dataset can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones )

The actual data files can be found [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), including an in-depth READ.ME on what and how data was collected, which will not be repeated here.

We began by assembling a large data frame by combining multiple files.

1. features.txt contains 180 variables that were measured or calculated from accelerometer data.
2. We then added numerical data from the test data set corresponding to each of the 180 variables from the features file. (This file begins with an "X")
3. Data about individual subjects and what the physical activity that they were performing was also appended to the data frame.
4. This process was repeated in the same manner for the training data set, then the two data frames were merged.

5. For this project, we were only interested in assembling data about the mean and std; therefore, we selected only those data for a tidy data set.
6. To make variable names easier to read, we removed parentheses, dashes, and duplicate words.
7. For the tidy data frame that was ultimately submitted, data was grouped by subject and activity and average values for each of the remaining 81 mean and std variables were calculated. Because there were 30 subjects and 6 activities, there are a total of 180 observations in this tidy data set.





