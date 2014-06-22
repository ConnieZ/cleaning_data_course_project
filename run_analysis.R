##Script to clean up data in "Human Activity Recognition Using Smartphones Dataset"
#by Kanstantsyia (Connie) Zabarouskaya

##For this script to work properly, please place all the test and train files, 
# as well as features.txt and activity_labels.txt, in your working directory 
# before executing this script

# Create tables for the train data
xtrain <- read.table("X_train.txt")
ytrain <- read.table("y_train.txt")
subjecttrain <- read.table("subject_train.txt")
# Create tables for the test data
xtest <- read.table("X_test.txt")
ytest <- read.table("y_test.txt")
subjecttest <- read.table("subject_test.txt")

#Merge all the train data together
train <- cbind(subjecttrain, ytrain, xtrain)
#Merge all the test data together
test <- cbind(subjecttest, ytest, xtest)

## Merge the train and test data together
mergeddata <- rbind(train, test)

## Read the features.txt file with variable labels in it
featuresfile <- read.table("features.txt")
# convert the labels from features.txt file into a character vector and 
# save as part of labels we'll use
partoflabels <- as.character(featuresfile$V2)
# combine the var partoflabels with the labels for the first two columns
# which are as we know - subject and activity type (563 labels altogether)
alllabels <- c("Subject","Activity",partoflabels)
# reassign the current labels to the ones we just created
names(mergeddata) <- alllabels

## Get the indexes of the first 2 columns (subject, activity) and 
#columns where a mean or a standard deviation is contained
indexes <- c(1,2, grep("mean\\(\\)", names(mergeddata)),grep("std", names(mergeddata)))
#sort the indexes
indexes<-sort(indexes)
#get the columns with those indexes
finaldata <- mergeddata[,indexes]

## Read the activity_labels.txt file
activitylabelsfile <- read.table("activity_labels.txt")
activitylabels <- activitylabelsfile[,2]

## In activity column replace integer values by descriptive activity names
for (i in 1:6) {
	finaldata$Activity <- sub(i,activitylabels[i],finaldata$Activity)
	}

# Convert the activity column to a factor type (now it's a string)
finaldata$Activity <- as.factor(finaldata$Activity)

##Appropriately label the data set with descriptive variable names
# Have a quick look at the variable labels as they are currently.
names(finaldata)
# First split the labels on dashes
names(finaldata) <- gsub("-", " ", names(finaldata))
# Rename the labels appropriately
names(finaldata) <- sub("tBodyAcc","Body Acceleration ",names(finaldata))
names(finaldata) <- sub("fBodyAcc","FFT Body Acceleration ",names(finaldata))
names(finaldata) <- sub("tBodyGyro","Body Gyroscope Signal ",names(finaldata))
names(finaldata) <- sub("fBodyGyro","FFT Body Gyroscope Signal ",names(finaldata))
names(finaldata) <- sub("tGravityAcc","Gravity Acceleration ",names(finaldata))
names(finaldata) <- sub("Mag"," Magnitude",names(finaldata))
names(finaldata) <- sub("mean\\(\\)","Mean",names(finaldata))
names(finaldata) <- sub("std\\(\\)","Standard Deviation",names(finaldata))
names(finaldata) <- sub("fBodyBodyGyro","FFT Body Gyroscope Signal ",names(finaldata))
names(finaldata) <- sub("fBodyBodyAcc","FFT Body Acceleration ",names(finaldata))
names(finaldata) <- sub(" X", " on X-axis", names(finaldata))
names(finaldata) <- sub(" Y", " on Y-axis", names(finaldata))
names(finaldata) <- sub(" Z", " on Z-axis", names(finaldata))

##Create a second, independent tidy data set called tidydata
#with the average of each variable for each activity and each subject.
#we will run aggregate() function on all measurement columns (excluding the subject and activity columns)
#two new columns will be added called Subject and Activity (for purposes of aggregation)
tidydata <- aggregate(finaldata[,3:length(names(finaldata))], by=list(Subject=finaldata$Subject,Activity = finaldata$Activity),FUN=mean, na.rm=TRUE)

##This may not be required, but the last step is to export the tidy data set to the working directory
write.table(tidydata,"tidydata.txt", row.names=FALSE)