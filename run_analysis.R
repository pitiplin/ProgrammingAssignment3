Part1 <- function(trainfFile="./UCI HAR Dataset/train/X_train.txt", testFile="./UCI HAR Dataset/test/X_test.txt", labelsFile="./UCI HAR Dataset/features.txt"){

				trainDataSet<-read.table(trainfFile)
				testDataSet<-read.table(testFile)
				mergedDataSet<-rbind(trainDataSet, testDataSet)
				labelsDataSetNames<-as.character(read.table(labelsFile)[[2]])
				names(mergedDataSet) <- labelsDataSetNames
				
				mergedDataSet
}

Part2 <- function(mergedDataSet){

				mergedDataSet<-mergedDataSet[c(grep("-mean()",names(mergedDataSet),fixed=T), grep("-std()",names(mergedDataSet),fixed=T))]
				
				mergedDataSet
}

Part3 <- function(trainFile="./UCI HAR Dataset/train/y_train.txt", testFile="./UCI HAR Dataset/test/y_test.txt", labelsFile="./UCI HAR Dataset/activity_labels.txt"){

				trainActivity<-as.factor(readLines(trainFile))
				testActivity<-as.factor(readLines(testFile))
				mergedActivity<-as.factor(c(trainActivity, testActivity))
				
				descriptiveActivityNames<-read.table(labelsFile)
				levels(mergedActivity)<-descriptiveActivityNames[[2]]
				
				mergedActivity
}

Part4 <- function(mergedDataSet, mergedActivity){

				mergedDataSet["Activity"] <- mergedActivity
				
				mergedDataSet
}

Part5 <- function(mergedDataSet, trainFile="./UCI HAR Dataset/train/subject_train.txt", testFile="./UCI HAR Dataset/test/subject_test.txt"){
				
				trainSubject<-as.factor(readLines(trainFile))
				testSubject<-as.factor(readLines(testFile))
				mergedSubject<-as.factor(c(trainSubject, testSubject))
				mergedDataSet["Subject"] <- mergedSubject
				
				newDataSet<-t(as.data.frame(lapply(split(mergedDataSet, interaction(mergedDataSet$Activity,mergedDataSet$Subject)), function(x) colMeans(x[, 1:(ncol(x)-2)]))))
}

ExportDataSet <- function(newDataSet, path="DATA", textFileName="DataSetTXT", csvFileName="DataSetCSV"){

				if (!file.exists(path)){
								dir.create(path)
				}
				
				write.table(newDataSet, paste0(path, "/", textFileName, ".txt"))
				write.csv(newDataSet, paste0(path, "/", csvFileName, ".csv"))
}

GettingAndCleaningDataPeerAssessment <- function(){	

				mergedDataSet <- Part1()
				mergedDataSet <- Part2(mergedDataSet)
				mergedActivity <- Part3()
				mergedDataSet <- Part4(mergedDataSet, mergedActivity)
				newDataSet <- Part5(mergedDataSet)
				ExportDataSet(newDataSet)
}
