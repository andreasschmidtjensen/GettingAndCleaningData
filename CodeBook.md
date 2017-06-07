## Code Book

The code book describes the data that is being processed (cleaned) and in some detail, the processing steps required to create the tidy dataset. The resulting dataset contains the average of each variable for each activity and each subject.

### Background

The data comes from an experiment with 30 volunteers who performed 6 different activities while wearing a smartphone that captured data about their movement.
More information about the experiment can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Files

#### Metadata
The following files are used to create the tidy dataset.
* `features.txt`: Name for each of the 561 features.
* `activity_labels.txt`: ID and name for each activity.

#### Training data
21 of the 30 volunteers contributed to the training data. This resulted in 7352 observations.

* `X_train.txt`: A table containing the training observations of the features.
* `y_train.txt`: A vector containing for each observation in `X_train.txt`, the ID of the activity related to that observation.
* `subject_train.txt`: A vector containing for each observation in `X_train.txt`, the ID of the volunteer related to that observations.

#### Test data
9 of the 30 volunteers contributed to the testing data. This resulted in 2947 observations.

* `X_test.txt`: A table containing the test observations of the features.
* `y_test.txt`: A vector containing for each observation in `X_test.txt`, the ID of the activity related to that observation.
* `subject_test.txt`: A vector containing for each observation in `X_test.txt`, the ID of the volunteer related to that observations.

The features are described in more detail in the `features_info.txt` file of the dataset.

### Processing steps

In order to create a tidy dataset, the following steps are taken:

1. All features (the `X`) are read into memory and are stacked together to form a single table with training features first, and then test features.
2. The columns of the feature table are given names based on the metadata file, `features.txt`.
3. All labels for the observations (the `y`) are read into memory and stacked together to form a single vertical vector with training labels first and then test labels.
4. All feature columns that do not measure standard-deviation or mean (containing "std()" or "mean()" in the name) are removed.
5. We bind the (vertical) vector of activities for each activity to the feature table.
5. We create a vector containing the subject for each observation (again, stacking training and test datasets).
6. We bind the (vertical) subject-vector to the feature table.
7. The activity IDs are replaced with activity names by merging the `activity_labels.txt` with the feature table.
8. We 'melt' all the measurements of the experiment into a single column, `variable`, giving us a tall and skinny dataset.
9. The final, tidy, dataset is created by calculating the mean for each measurement variable, for each pair of subject and activity. This leaves us a table with 180 rows, 6 rows for each subject.
