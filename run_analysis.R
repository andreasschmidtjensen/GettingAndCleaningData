library("data.table")
library("reshape")
library("dplyr")

# read test and training features and combine into one table
training_set <- fread("./UCI HAR Dataset/train/X_train.txt")
test_set <- fread("./UCI HAR Dataset/test/X_test.txt")
dataset <- rbind(training_set, test_set)

# load feature list to use a column names, don't cast strings as factors since we need the actual strings for names (not the underlying factor ints)
features <- read.table("./UCI HAR Dataset/features.txt", sep = " ", header = F, col.names = c("identifier", "feature"), stringsAsFactors = F)
names(dataset) <- features$feature

# read test and training labels and combine into one table
training_labels <- fread("./UCI HAR Dataset/train/y_train.txt")
test_labels <- fread("./UCI HAR Dataset/test/y_test.txt")
labels <- rbind(training_labels, test_labels)
names(labels) <- "label"

# select only std and mean columns
subset <- subset(dataset, select = grep("(std|mean)\\(\\)", names(dataset)))
labelled_subset <- cbind(subset, labels)

# get subjects for training and test sets
subject_train <- fread("./UCI HAR Dataset/train/subject_train.txt")
subject_test <- fread("./UCI HAR Dataset/test/subject_test.txt")
subjects <- rbind(subject_train, subject_test)
names(subjects) <- "subject"

# column-bind subjects to full dataset
subject_activity <- cbind(labelled_subset, subjects)

# read activity labels to show descriptive activity name
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", sep = " ", header = F, col.names = c("identifier", "activity"))

# merge dataset with activity labels 
activity_dataset <- 
  subject_activity %>%
  merge(activity_labels, by.x = "label", by.y = "identifier") %>%
  select(-label) # remove the label identifier, so only the name is kept

# put all the measuremens into a single 'variable' column using melt. 
# Note: we need not specify measure.vars as all remaing variables are the same type
melted <- melt(activity_dataset, id.vars = c("subject", "activity")) 

# create final dataset by applying mean in the cast function
tidy_data <- cast(melted, subject+activity~variable, mean) 

# save the tidy data file.
write.table(tidy_data, file = "tidydata.txt", row.names = F)
