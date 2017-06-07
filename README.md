## Getting and Cleaning Data

This repository contains code for reading in the ["Human Activity Recognition Using Smartphones" data set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and performing a number of cleanup steps to output a tidy dataset.

In order for the script to work, the dataset must be available.

1. Clone this repository
2. Download the dataset from the URL above.
3. Extract the directory into the repository folder. The folder containing the dataset is assumed to be named `UCI HAR Dataset`
4. Run `source("run_analysis.R")` in R in the repository folder.

The data and the cleanup process are described in the [code book](CodeBook.md).
