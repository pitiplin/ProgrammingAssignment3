#Part 1
trainDataSet<-read.table("./UCI HAR Dataset/train/X_train.txt")
testDataSet<-read.table("./UCI HAR Dataset/test/X_test.txt")
mergedDataSet<-rbind(trainDataSet, testDataSet)
labelsDataSetNames<-as.character(read.table("./UCI HAR Dataset/features.txt")[[2]])
names(mergedDataSet) <- labelsDataSetNames

#Part 2
mergedDataSet<-mergedDataSet[c(grep("-mean()",names(mergedDataSet),fixed=T), grep("-std()",names(mergedDataSet),fixed=T))]

#Part 3
trainActivity<-as.factor(readLines("./UCI HAR Dataset/train/y_train.txt"))
testActivity<-as.factor(readLines("./UCI HAR Dataset/test/y_test.txt"))
mergedActivity<-as.factor(c(trainActivity, testActivity))

descriptiveActivityNames<-read.table("./UCI HAR Dataset/activity_labels.txt")
levels(mergedActivity)<-descriptiveActivityNames[[2]]

#Part 4
mergedDataSet["Activity"] <- mergedActivity

#Part 5
trainSubject<-as.factor(readLines("./UCI HAR Dataset/train/subject_train.txt"))
testSubject<-as.factor(readLines("./UCI HAR Dataset/test/subject_test.txt"))
mergedSubject<-as.factor(c(trainSubject, testSubject))
mergedDataSet["Subject"] <- mergedSubject

newDataSet<-t(as.data.frame(lapply(split(mergedDataSet, interaction(mergedDataSet$Activity,mergedDataSet$Subject)), function(x) colMeans(x[, 1:(ncol(x)-2)]))))
