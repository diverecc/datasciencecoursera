##
##  The data linked to from the course website represent data collected from the accelerometers 
##  from the Samsung Galaxy S smartphone. A full description is available at the site where the 
##  data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
##
## The data for the project were downloaded on 4 September 2016 at
##  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## 
## This function must be run in the same directory as the unziped repository above. 
## It returns a independent tidy data set with the average of each variable for each activity and subject
##
run_analysis <- function () {
    library(dtplyr)

    ## Feature list for  "-mean(" and "-std()"
    feature<-read.table("features.txt",stringsAsFactors=FALSE)
    meanandstd<-feature[grep("-[ms][et][ad][n)][)(]",feature$V2), ] 
    
    ## Merges the training set for mean and std by column
    datatrain<-read.table("train/X_train.txt")
    datatrain<-datatrain[,meanandstd$V1]
    subjecttrain<-read.table("train/subject_train.txt")
    labeltrain<-read.table("train/y_train.txt")
    alltraindata <- cbind(subjecttrain,labeltrain,datatrain)
    
    ## Merges the test set for mean and std by column
    datatest<-read.table("test/X_test.txt")
    datatest<-datatest[,meanandstd$V1]
    subjecttest<-read.table("test/subject_test.txt")
    labeltest<-read.table("test/y_test.txt")
    alltestdata <- cbind(subjecttest,labeltest,datatest)
    
    ## Merges both test and train data set by row, clarify first and second column names
    ## Replaces activity ids by their names
    alldata <- rbind(alltraindata,alltestdata)
    colnames(alldata) <- c("subject_id","activity",meanandstd$V2)
    activityname<-read.table("activity_labels.txt",stringsAsFactors=FALSE)
    alldata<-mutate(alldata,activity=activityname$V2[activity])
    
    ## Creates a second, independent tidy data set with the average of each variable 
    ## for each activity and each subject.
    allname <- colnames(alldata)
    allmelt = melt(alldata, id=allname[1:2], measure.vars=allname[3:length(allname)])
    alltidy = dcast(allmelt, subject_id + activity ~ variable, mean)
    write.table(alltidy, file = "./alltidy.txt")
    alltidy
}
