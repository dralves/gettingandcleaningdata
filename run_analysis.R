library(dplyr)

# If the dataset file is not present in the current directory download and unzip it.
if (!file.exists("dataset.zip")) {
  file <- download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "dataset.zip")
  unzip("dataset.zip")
}

# Read the training data, activities and subjects
training_data <- read.table("UCI HAR Dataset/train/X_train.txt")
training_activities <- read.table("UCI HAR Dataset/train/y_train.txt")
training_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Read the test data, activities and subjects
test_data <- read.table("UCI HAR Dataset/test/X_test.txt")
test_activities <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Tidy the data, merging the training and test sets and giving proper names to the columns
data <- tbl_df(rbind(training_data, test_data))
feature_names<- read.table("UCI HAR Dataset/features.txt")[[2]]
colnames(data) <- feature_names
# Select only the columsn that correpond to the mean() or std() (standard deviation)
data <- data[,grep('mean()|std()',names(data))]


# Tidy the activities, merging the training and test sets, giving a proper name to the column
# and transforming the ids into the activity names
activities <- tbl_df(rbind(training_activities, test_activities))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")[,2]
activities <- tbl_df(as.data.frame(activity_labels[activities[[1]]]))
colnames(activities) <- c("activity")

# Tidy the subjects, giving a proper name to the column
subjects <- tbl_df(rbind(training_subject, test_subject))
colnames(subjects) <- c("subject")

#Now merge data, activities and subjects together to get the final tidy data set
tidy <- tbl_df(cbind(subjects, activities, data))

# Create a new dataset grouped by activity and subject, with the average of each variable
tidy_subset <- tidy %>%
  group_by(subject, activity) %>% # Group by subject anc activity
  summarise_each(funs(mean))      # Summarise all colums, calculating the mean for each one

write.table(tidy_subset, file = "tidy_subset.txt", row.name=FALSE)