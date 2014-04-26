# ProgrammingAssignment3 #


One of the most exciting areas in all of data science right now is wearable computing.  See for example this article:

[http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/)

Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Here are the data for the project: 

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )

To perform this project, one R script called run_analysis.R was created that does the following. 


1. Merges the training and the test sets to create one data set.


1. Extracts only the measurements on the mean and standard deviation for each measurement. 


1. Uses descriptive activity names to name the activities in the data set


1. Appropriately labels the data set with descriptive activity names. 


1. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


To get the final data set there are two ways of running the script described above:

- Run GettingAndCleaningDataPeerAssessment().  This function will call all the needed methods sequentially with defaults parameters.  The data set will be exported as two files: "DataSetTXT.txt" and "DataSetCSV.csv".  Default values are the following:

	- Train data set file:  "./UCI HAR Dataset/train/X_train.txt"
	- Test data set file: "./UCI HAR Dataset/test/X_test.txt"
	- Data set labels file:  "./UCI HAR Dataset/features.txt"
	- Activities train file: "./UCI HAR Dataset/train/y_train.txt"
	- Activities test file: "./UCI HAR Dataset/test/y_test.txt"
	- Activities labels file: "./UCI HAR Dataset/activity_labels.txt"
	- Subject train file: "./UCI HAR Dataset/train/subject_train.txt"
	- Subject test file: "./UCI HAR Dataset/test/subject_test.txt"
	- Output directory: "DATA"
	- Output text file: "DataSetTXT.txt"
	- Output csv file: "DataSetCSV.csv"



- Run each function sequentially on this way:

	1. Part1().  This function takes two files and merges them into a dataframe
	2. Part2().  This function extracts only the measurements on the mean and standard deviation for each measurement of the dataframe given
	3. Part3().  This function extracts the activity of the data set and their names
	4. Part4().  This function labels the data set with descriptive activity names
	5. Part5().  This function creates a second, independent tidy data set with the average of each variable for each activity and each subject
	6. ExportDataSet().  This function exports a dataframe to a text and csv file

		- To get more information about the arguments and returned values of each function please see the "CodeBook.md" on this repository

		- Example of use:<pre><code>mergedDataSet &lt;- Part1()
			mergedDataSet &lt;- Part2(mergedDataSet)
			mergedActivity &lt;- Part3()
			mergedDataSet &lt;- Part4(mergedDataSet, mergedActivity)
			newDataSet &lt;- Part5(mergedDataSet)
			ExportDataSet(newDataSet)</code></pre>


