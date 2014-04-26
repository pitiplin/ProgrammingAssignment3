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

<pre><code>
Part1 &lt;- function(trainFile="./UCI HAR Dataset/train/X_train.txt", testFile="./UCI HAR Dataset/test/X_test.txt", labelsFile="./UCI HAR Dataset/features.txt"){

				trainDataSet&lt;-read.table(trainFile)
				testDataSet&lt;-read.table(testFile)
				mergedDataSet&lt;-rbind(trainDataSet, testDataSet)
				labelsDataSetNames&lt;-as.character(read.table(labelsFile)[[2]])
				names(mergedDataSet) &lt;- labelsDataSetNames
				
				mergedDataSet
}
</code></code></pre>

This function takes two files and merges them into a dataframe

### Arguments ###
trainFile - character().  Path to the first file to merge.  Default: "./UCI HAR Dataset/train/X_train.txt"

testFile - character().  Path to the second file to merge.  Deafault: "./UCI HAR Dataset/test/X_test.txt"

labelsDataSetNames - character().  Path to file containing the names of the columns of the files to merge.  Default: "./UCI HAR Dataset/features.txt"


### Return ###
mergedDataSet	- data.frame().  Dataframe resulting of the two files given

### Explanation ###

<pre><code>trainDataSet&lt;-read.table(trainFile)</code></code></pre>
Converts the training data set text file into a dataframe
<pre><code>testDataSet&lt;-read.table(testFile)</code></code></pre>
Converts the test data set text file into a dataframe
<pre><code>mergedDataSet&lt;-rbind(trainDataSet, testDataSet)</code></code></pre>
Merges the two dataframes given above
<pre><code>labelsDataSetNames&lt;-as.character(read.table(labelsFile)[[2]])</code></code></pre>
Get the names of the colums of the data sets of the given file
<pre><code>names(mergedDataSet) &lt;- labelsDataSetNames</code></code></pre>
Set the names of the columns of the merged data set
<pre><code>mergedDataSet</code></code></pre>
Dataframe to return

## Part2 ##
<pre><code>
Part2 &lt;- function(mergedDataSet){

				mergedDataSet&lt;-mergedDataSet[c(grep("-mean()",names(mergedDataSet),fixed=T), grep("-std()",names(mergedDataSet),fixed=T))]
				
				mergedDataSet
}
</code></pre>

This function extracts only the measurements on the mean and standard deviation for each measurement of the dataframe given

### Arguments ###
mergedDataSet - data.frame().  Dataframe of wich columns wants to extract the information


### Return ###
mergedDataSet	- data.frame().  Dataframe resulting of the subset of the columns

### Explanation ###

<pre><code>mergedDataSet&lt;-mergedDataSet[c(grep("-mean()",names(mergedDataSet),fixed=T), grep("-std()",names(mergedDataSet),fixed=T))]</code></pre>
This line extracts only the columns that contain "-mean()" or "-std()" on its name.  fixed is set to TRUE to avoid names like "-meanFreq()"
<pre><code>mergedDataSet</code></pre>

Dataframe to return

## Part3 ##
<pre><code>
Part3 &lt;- function(trainFile="./UCI HAR Dataset/train/y_train.txt", testFile="./UCI HAR Dataset/test/y_test.txt", labelsFile="./UCI HAR Dataset/activity_labels.txt"){

				trainActivity&lt;-as.factor(readLines(trainFile))
				testActivity&lt;-as.factor(readLines(testFile))
				mergedActivity&lt;-as.factor(c(trainActivity, testActivity))
				
				descriptiveActivityNames&lt;-read.table(labelsFile)
				levels(mergedActivity)&lt;-descriptiveActivityNames[[2]]
				
				mergedActivity
}
</code></pre>

This function extracts the activity of the data set and their names

### Arguments ###
trainFile - character().  Path to the first file of activities to merge.  Default: "./UCI HAR Dataset/train/y_train.txt"

testFile - character().  Path to the second file of activities to merge.  Default: "./UCI HAR Dataset/test/y_test.txt"

labelsFile - character().  Path to the file containing the names of the activities.  Default: "./UCI HAR Dataset/activity_labels.txt"


### Return ###
mergedActivity	- character() vector.  Vector of the names of the activities resulting of the two files given

### Explanation ###

<pre><code>trainActivity&lt;-as.factor(readLines(trainFile))</code></pre>
Get the training activities and set them as a factor() vector
<pre><code>testActivity&lt;-as.factor(readLines(testFile))</code></pre>
Get the test activities and set them as a factor() vector
<pre><code>mergedActivity&lt;-as.factor(c(trainActivity, testActivity))</code></pre>
Merges the two vectors given above
<pre><code>descriptiveActivityNames&lt;-read.table(labelsFile)</code></pre>
Get the names of the activities of the given file
<pre><code>levels(mergedActivity)&lt;-descriptiveActivityNames[[2]]</code></pre>
Set the names of the activities of the merged vector
<pre><code>mergedActivity</code></pre>
Returned vector


## Part4 ##
<pre><code>
Part4 &lt;- function(mergedDataSet, mergedActivity){

				mergedDataSet["Activity"] &lt;- mergedActivity
				
				mergedDataSet
}
</code></pre>

This function labels the data set with descriptive activity names

### Arguments ###
mergedDataSet - data.frame().  Dataframe that results of the execution of Part2() function

mergedActivity - data.frame().  Dataframe that results of the execution of Part3() function

### Return ###
mergedDataSet	- data.frame().  Dataframe that results of the addition of the column "Activity"

### Explanation ###
<pre><code>mergedDataSet["Activity"] &lt;- mergedActivity</code></pre>
This line adds the column "Activity" to the given dataframe
<pre><code>mergedDataSet</code></pre>

Dataframe to return

## Part5 ##
<pre><code>
Part5 &lt;- function(mergedDataSet, trainFile="./UCI HAR Dataset/train/subject_train.txt", testFile="./UCI HAR Dataset/test/subject_test.txt"){
				
				trainSubject&lt;-as.factor(readLines(trainFile))
				testSubject&lt;-as.factor(readLines(testFile))
				mergedSubject&lt;-as.factor(c(trainSubject, testSubject))
				mergedDataSet["Subject"] &lt;- mergedSubject
				
				newDataSet&lt;-t(as.data.frame(lapply(split(mergedDataSet, interaction(mergedDataSet$Activity,mergedDataSet$Subject)), function(x) colMeans(x[, 1:(ncol(x)-2)]))))
}
}
</code></pre>

This function creates a second, independent tidy data set with the average of each variable for each activity and each subject

### Arguments ###
mergedDataSet - data.frame().  Dataframe that results of the execution of Part4() function

trainFile - character().  Path to the train file of subjects to merge.  Default: "./UCI HAR Dataset/train/subject_train.txt"

testFile - character().  Path to the test file of subjects to merge.  Default: "./UCI HAR Dataset/test/subject_test.txt"

### Return ###
mergedDataSet	- data.frame().  Dataframe with the average of each variable for each activity and each subject

### Explanation ###

<pre><code>trainSubject&lt;-as.factor(readLines(trainFile))</code></pre>
Get the training subjects and set them as a factor() vector
<pre><code>testSubject&lt;-as.factor(readLines(testFile))</code></pre>
Get the test subjects and set them as a factor() vector
<pre><code>mergedSubject&lt;-as.factor(c(trainSubject, testSubject))</code></pre>
Merges the two vectors given above
<pre><code>mergedDataSet["Subject"] &lt;- mergedSubject</code></pre>
This line adds the column "Subject" to the given dataframe
<pre><code>newDataSet&lt;-t(as.data.frame(lapply(split(mergedDataSet, interaction(mergedDataSet$Activity,mergedDataSet$Subject)), function(x) colMeans(x[, 1:(ncol(x)-2)]))))</code></pre>
1. <pre><code>interaction(mergedDataSet$Activity,mergedDataSet$Subject)</code></pre>
	Computes a factor which represents the interaction between the "Activity" & "Subject" columns

2. <pre><code>split(mergedDataSet, interaction ... )</code></pre>
	Subsetts the data set grouping by "Activity" & "Subject"

3. <pre><code>lapply(split ..., function(x) colMeans(x[, 1:(ncol(x)-2)]))</code></pre>
	Computes the mean of all columns (except "Activity" and "Subject") that results of grouping the data set

4. <pre><code>t(as.data.frame(lapply ... )</code></pre>
	Gives to the result the aspect of a table

## ExportDataSet ##
<pre><code>
ExportDataSet &lt;- function(newDataSet, path="DATA", textFileName="DataSetTXT", csvFileName="DataSetCSV"){

				if (!file.exists(path)){
								dir.create(path)
				}
				
				write.table(newDataSet, paste0(path, "/", textFileName, ".txt"))
				write.csv(newDataSet, paste0(path, "/", csvFileName, ".csv"))
}
</code></pre>

This function exports a dataframe to a text and csv file

### Arguments ###
mergedDataSet - data.frame()

path - character().  Output directory.  Default: "DATA"

textFileName - character().  Output text file name.  Default: "DataSetTXT"

csvFileName - character().  Output csv file name.  Default: "DataSetCSV"

### Return ###
Nothing

## GettingAndCleaningDataPeerAssessment ##
<pre><code>
GettingAndCleaningDataPeerAssessment &lt;- function(){	

				mergedDataSet &lt;- Part1()
				mergedDataSet &lt;- Part2(mergedDataSet)
				mergedActivity &lt;- Part3()
				mergedDataSet &lt;- Part4(mergedDataSet, mergedActivity)
				newDataSet &lt;- Part5(mergedDataSet)
				ExportDataSet(newDataSet)
}
</code></pre>

This function runs all scripts sequentially with default values

### Arguments ###
Nothing

### Return ###
Nothing