# ProgrammingAssignment3 #


## Introduction ##

run_analysis.R has seven different functions:

- Part1
- Part2
- Part3
- Part4
- Part5
- ExportDataSet()
- GettingAndCleaningDataPeerAssessment()

First five functions implement the five different questions of the assignment:



- Part1 - Merges the training and the test sets to create one data set
- Part2 - Extracts only the measurements on the mean and standard deviation for each measurement
- Part3 - Uses descriptive activity names to name the activities in the data set
- Part4 - Appropriately labels the data set with descriptive activity names
- Part5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject

ExportDataSet saves a data.frame to a text and csv file

GettingAndCleaningDataPeerAssessment runs all scripts sequentially with default values

## Part1 ##

<pre>
Part1 <- function(trainFile="./UCI HAR Dataset/train/X_train.txt", testFile="./UCI HAR Dataset/test/X_test.txt", labelsFile="./UCI HAR Dataset/features.txt"){

				trainDataSet<-read.table(trainFile)
				testDataSet<-read.table(testFile)
				mergedDataSet<-rbind(trainDataSet, testDataSet)
				labelsDataSetNames<-as.character(read.table(labelsFile)[[2]])
				names(mergedDataSet) <- labelsDataSetNames
				
				mergedDataSet
}
</pre>

This function takes two files and merges them into a dataframe

### Arguments ###
trainFile - character().  Path to the first file to merge

testFile - character().  Path to the second file to merge

labelsDataSetNames - character().  Path to file containing the names of the columns of the files to merge


### Return ###
mergedDataSet	- data.frame().  Dataframe resulting of the two files given

### Explanation ###

<pre>trainDataSet<-read.table(trainFile)</pre>
Converts the training data set text file into a dataframe
<pre>testDataSet<-read.table(testFile)</pre>
Converts the test data set text file into a dataframe
<pre>mergedDataSet<-rbind(trainDataSet, testDataSet)</pre>
Merges the two dataframes given above
<pre>labelsDataSetNames<-as.character(read.table(labelsFile)[[2]])</pre>
Get the names of the colums of the data sets of the given file
<pre>names(mergedDataSet) <- labelsDataSetNames</pre>
Set the names of the columns of the merged data set
<pre>mergedDataSet</pre>
Dataframe to return

## Part2 ##
<pre>
Part2 <- function(mergedDataSet){

				mergedDataSet<-mergedDataSet[c(grep("-mean()",names(mergedDataSet),fixed=T), grep("-std()",names(mergedDataSet),fixed=T))]
				
				mergedDataSet
}
</pre>

This function extracts only the measurements on the mean and standard deviation for each measurement of the dataframe given

### Arguments ###
mergedDataSet - data.frame().  Dataframe of wich columns wants to extract the information


### Return ###
mergedDataSet	- data.frame().  Dataframe resulting of the subset of the columns

### Explanation ###

<pre>mergedDataSet<-mergedDataSet[c(grep("-mean()",names(mergedDataSet),fixed=T), grep("-std()",names(mergedDataSet),fixed=T))]</pre>
This line extracts only the columns that contain "-mean()" or "-std()" on its name.  fixed is set to TRUE to avoid names like "-meanFreq()"
<pre>mergedDataSet</pre>

Dataframe to return

## Part3 ##
<pre>
Part3 <- function(trainFile="./UCI HAR Dataset/train/y_train.txt", testFile="./UCI HAR Dataset/test/y_test.txt", labelsFile="./UCI HAR Dataset/activity_labels.txt"){

				trainActivity<-as.factor(readLines(trainFile))
				testActivity<-as.factor(readLines(testFile))
				mergedActivity<-as.factor(c(trainActivity, testActivity))
				
				descriptiveActivityNames<-read.table(labelsFile)
				levels(mergedActivity)<-descriptiveActivityNames[[2]]
				
				mergedActivity
}
</pre>

This function extracts the activity of the data set and their names

### Arguments ###
trainFile - character().  Path to the first file of activities to merge

testFile - character().  Path to the second file of activities to merge

labelsFile - character().  Path to the file containing the names of the activities


### Return ###
mergedActivity	- character() vector.  Vector of the names of the activities resulting of the two files given

### Explanation ###

<pre>trainActivity<-as.factor(readLines(trainFile))</pre>
Get the training activities and set them as a factor() vector
<pre>testActivity<-as.factor(readLines(testFile))</pre>
Get the test activities and set them as a factor() vector
<pre>mergedActivity<-as.factor(c(trainActivity, testActivity))</pre>
Merges the two vectors given above
<pre>descriptiveActivityNames<-read.table(labelsFile)</pre>
Get the names of the activities of the given file
<pre>levels(mergedActivity)<-descriptiveActivityNames[[2]]</pre>
Set the names of the activities of the merged vector
<pre>mergedActivity</pre>
Returned vector


## Part4 ##
<pre>
Part4 <- function(mergedDataSet, mergedActivity){

				mergedDataSet["Activity"] <- mergedActivity
				
				mergedDataSet
}
</pre>

This function labels the data set with descriptive activity names

### Arguments ###
mergedDataSet - data.frame().  Dataframe that results of the execution of Part2() function

mergedActivity - data.frame().  Dataframe that results of the execution of Part3() function

### Return ###
mergedDataSet	- data.frame().  Dataframe that results of the addition of the column "Activity"

### Explanation ###
<pre>mergedDataSet["Activity"] <- mergedActivity</pre>
This line adds the column "Activity" to the given dataframe
<pre>mergedDataSet</pre>

Dataframe to return

## Part5 ##
<pre>
Part5 <- function(mergedDataSet, trainFile="./UCI HAR Dataset/train/subject_train.txt", testFile="./UCI HAR Dataset/test/subject_test.txt"){
				
				trainSubject<-as.factor(readLines(trainFile))
				testSubject<-as.factor(readLines(testFile))
				mergedSubject<-as.factor(c(trainSubject, testSubject))
				mergedDataSet["Subject"] <- mergedSubject
				
				newDataSet<-t(as.data.frame(lapply(split(mergedDataSet, interaction(mergedDataSet$Activity,mergedDataSet$Subject)), function(x) colMeans(x[, 1:(ncol(x)-2)]))))
}
}
</pre>

This function creates a second, independent tidy data set with the average of each variable for each activity and each subject

### Arguments ###
mergedDataSet - data.frame().  Dataframe that results of the execution of Part4() function

trainFile - character().  Path to the train file of subjects to merge

testFile - character().  Path to the test file of subjects to merge

### Return ###
mergedDataSet	- data.frame().  Dataframe with the average of each variable for each activity and each subject

### Explanation ###

<pre>trainSubject<-as.factor(readLines(trainFile))</pre>
Get the training subjects and set them as a factor() vector
<pre>testSubject<-as.factor(readLines(testFile))</pre>
Get the test subjects and set them as a factor() vector
<pre>mergedSubject<-as.factor(c(trainSubject, testSubject))</pre>
Merges the two vectors given above
<pre>mergedDataSet["Subject"] <- mergedSubject</pre>
This line adds the column "Subject" to the given dataframe
<pre>newDataSet<-t(as.data.frame(lapply(split(mergedDataSet, interaction(mergedDataSet$Activity,mergedDataSet$Subject)), function(x) colMeans(x[, 1:(ncol(x)-2)]))))</pre>
1. <pre>interaction(mergedDataSet$Activity,mergedDataSet$Subject)</pre>
	Computes a factor which represents the interaction of the "Activity" & "Subject" columns

2. <pre>split(mergedDataSet, interaction ... )</pre>
	Subsetts the data set grouping by "Activity" & "Subject"

3. <pre>lapply(split ..., function(x) colMeans(x[, 1:(ncol(x)-2)]))</pre>
	Computes the mean of all columns (except "Activity" and "Subject") that results of grouping the data set

4. <pre>t(as.data.frame(lapply ... )</pre>
	Gives to the result the aspect of a table

## ExportDataSet ##
<pre>
ExportDataSet <- function(newDataSet, path="DATA", textFileName="DataSetTXT", csvFileName="DataSetCSV"){

				if (!file.exists(path)){
								dir.create(path)
				}
				
				write.table(newDataSet, paste0(path, "/", textFileName, ".txt"))
				write.csv(newDataSet, paste0(path, "/", csvFileName, ".csv"))
}
</pre>

This function exports a dataframe to a text and csv file

### Arguments ###
mergedDataSet - data.frame()

path - character().  Output directory

textFileName - character().  Output text file name

csvFileName - character().  Output csv file name

### Return ###
Nothing

## GettingAndCleaningDataPeerAssessment ##
<pre>
GettingAndCleaningDataPeerAssessment <- function(){	

				mergedDataSet <- Part1()
				mergedDataSet <- Part2(mergedDataSet)
				mergedActivity <- Part3()
				mergedDataSet <- Part4(mergedDataSet, mergedActivity)
				newDataSet <- Part5(mergedDataSet)
				ExportDataSet(newDataSet)
}
</pre>

This function runs all scripts sequentially with default values

### Arguments ###
Nothing

### Return ###
Nothing



Edited with MarkdownPad (http://markdownpad.com)
