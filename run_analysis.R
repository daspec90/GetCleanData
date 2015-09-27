# Getting and Cleaning Data Course Project.
# Note: assume that working directory is "UCI HAR Dataset"

# Read in features file.
features <- read.csv("features.txt", sep = "", header = FALSE)

# Create list of names to be header of train and test data.frames
feature_names <- features[,2]

# Read in test data, and test subject and activity information.
test <- read.csv("test/X_test.txt", sep = "", header = FALSE)

# Add feature names to data.frame.
names(test) <- feature_names

subject_test <- read.csv("test/subject_test.txt", header = FALSE)
names(subject_test) <- c("subject")

activity_test <- read.csv("test/y_test.txt", sep = "", header = FALSE)
names(activity_test) <- c("activity")

# Add activity and subject variables to left side of data.frame.
test_df <- cbind(activity_test, test)
test_df <- cbind(subject_test, test_df)

# Repeat similar process for train data.frame.

train <- read.csv("train/X_train.txt", sep = "", header = FALSE)
names(train) <- feature_names

subject_train <- read.csv("train/subject_train.txt", header = FALSE)
names(subject_train) <- c("subject")

activity_train <- read.csv("train/y_train.txt", sep = "", header = FALSE)
names(activity_train) <- c("activity")

train_df <- cbind(activity_train, train)
train_df <- cbind(subject_train, train_df)

# Merge the two data.frames
merge_df <- rbind(test_df, train_df)

# Select mean() and std() variables
tidymean <- grep("mean()", names(merge_df), value = TRUE)
tidystd <-grep("std()", names(merge_df), value = TRUE)
headers <- c("subject", "activity")
tidycolumns <- c(headers, tidymean, tidystd)

# New data.frame with column names with mean() and std()
tidy_df <- merge_df[ ,tidycolumns]

# Add descriptive activity codes to data.frame
activity.code <- c(Walking = 1, Walking_Upstairs = 2, Walking_Downstairs = 3, Sitting = 4, Standing = 5, Laying = 6)
tidy_df$activity.str <- names(activity.code)[match(tidy_df$activity, activity.code)]

# Clean up variable names.
nodash <- gsub("-", "", names(tidy_df))
noparenth <- sub("\\()", "", nodash)
nobody <- sub("BodyBody", "Body", noparenth)

names(tidy_df) <- nobody

# Use dplyr package to compute average and create final data.frame
library(dplyr)
tidy_tbl <- tbl_df(tidy_df)

submit_df <-
tidy_tbl %>%
  group_by(subject, activity.str) %>%
  summarise_each(funs(mean)) %>%
  arrange(activity.str)

# Get rid of numeric activity column.

submit_df$activity <- NULL
names(submit_df)[names(submit_df) == 'activity.str'] <- 'activity'

# Write file for submission on course website.
write.table(submit_df, file = "tidydf.txt", row.names = FALSE)
