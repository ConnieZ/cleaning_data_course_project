#Code Book File for Course Project for Getting and Cleaning Data Class
####by Kanstantsyia (Connie) Zabarouskaya

Please consult the README.md for more details about this project
##Tidy Data Set
The Tidy Data Set is in file called "tidydata.txt". 
To read the file into R, please use read.table() function.

##Explanation of the processes in run_analysis.R
This file contains the script to create the tidy data set
and it also contains comments, because comments make it more readable

For this script to work properly, please place all the test and train files, 
as well as features.txt and activity_labels.txt, in your working directory 
before executing this script.

Create tables for the train data (X_train.txt, y_train.txt, subject_train.txt) 
and for the test data (X_test.txt, y_test.txt, subject_test.txt), using read.table().

Merge all the train data (subject_train.txt, y_train.txt, X_train.txt) together with cbind().
Merge all the train data (subject_test.txt, y_test.txt, X_test.txt) together with cbind().
The order of merging matters: 1st - subject file, 2nd - y-file with activity type, last - measurements.
Merge the train data set and test data set together, using rbind(), saving it into mergeddata variable.

Read the features.txt file with variable labels in it, using read.table() into variable featuresfile.
Take only the second column of the featuresfile table, and convert the labels 
into a character vector, using as.character, and save in the variable partoflabels.

Combine the labels from partoflabels with the labels we'll create for the first two columns,
which are as we know - subject and activity type (563 labels altogether). The result is alllabels variable. 
The order here matters: 1st - subject, 2nd - activity, last - partoflabels variable.
Reassign the current labels in names(mergeddata) to the ones we just created in alllabels.

Get the indexes of the first 2 columns (subject, activity) and 
columns where a mean or a standard deviation is contained, using grep() to search for mean() and std().
Using this method to search for "mean\\(\\)" will allow us to exclude meanFreq() columns. 
Sort the indexes, using sort(), and then subset columns from mergeddata with those indexes
to save them in the variable finaldata, with dimensions: 10299 rows and 68 columns.

Read the activity_labels.txt file into variable activitylabelsfile, using read.table().
Then subset the second column of that table into activitylabels vector variable.
Next,using a for-loop, we will iterate through the types of activities in the second column of finaldata,
and substitute the integer type of 1 - 6 with a descriptive label from activitylabels vector (WALKING, STANDING, etc.)
Because now the values in the activity column of finaldata have strings, we need to 
convert the activity column into a factor type, using as.factor().

Now label the data set appropriately with descriptive variable names. 
After observing the column names, by calling names(finaldata), we can now see what steps need to be made 
to tidy up the column names.
First split the labels on all dashes (because they appear to separate the words), using gsub().
Rename the labels appropriately, using a number of consecutive sub() functions. 

To create a second, independent tidy data set called tidydata, 
with the average of each variable for each activity and each subject,
we will run aggregate() function on all measurement columns (excluding the subject and activity columns).
During that run, two new columns will be added called Subject and Activity (for purposes of aggregation)
This function will also reorder the rows so that they show all subjects with one activity type, 
going in ascending order of Subject column, then all subjects for the next activity type, etc.
The means for each measurement are aggregated in columns for those combinations of subject and activity type.
Altogether there's 180 rows and 68 columns. 

The last step (optional) is to export the second tidy data set into a text file as a table.
We use write.table() function with no row names parameter.

##Variables in the Tidy Data Set
All measurement variables below don't have a measurement unit, because
they are ratio variables (the data has been divided by its 
range (gyroscope, entropy, etc) to normalise it). 

NOTE: This tidy data set is an AGGREGATE DATA SET, which means that
ALL VALUES of measurements below are in fact MEAN VALUES ACROSS THE MEASUREMENT VALUES 
for a particular subject in a particular type of activity. So if it says in the label below it's a mean, 
then it's in fact a mean value of that mean. The same goes for Standard Deviation in the label, 
which represents in fact a mean value of that standard deviation original value.

##Variable labels:
"Subject" - variable identifying the volunteer who participated in the experiment
"Activity" - type of activity the subject performed
"Body Acceleration  Mean on X-axis" - Mean value of body acceleration signal on X-axis
"Body Acceleration  Mean on Y-axis" - Mean value of body acceleration signal on Y-axis
"Body Acceleration  Mean on Z-axis" - Mean value of body acceleration signal on Z-axis
"Body Acceleration  Standard Deviation on X-axis" - Standard Deviation value of body acceleration signal on X-axis
"Body Acceleration  Standard Deviation on Y-axis" - Standard Deviation value of body acceleration signal on Y-axis
"Body Acceleration  Standard Deviation on Z-axis" - Standard Deviation value of body acceleration signal on Z-axis
"Gravity Acceleration  Mean on X-axis" - Mean value of gravity acceleration signal on X-axis
"Gravity Acceleration  Mean on Y-axis" - Mean value of gravity acceleration signal on Y-axis
"Gravity Acceleration  Mean on Z-axis" - Mean value of gravity acceleration signal on Z-axis
"Gravity Acceleration  Standard Deviation on X-axis" - Standard Deviation value of gravity acceleration signal on X-axis
"Gravity Acceleration  Standard Deviation on Y-axis" - Standard Deviation value of gravity acceleration signal on Y-axis
"Gravity Acceleration  Standard Deviation on Z-axis" - Standard Deviation value of gravity acceleration signal on Z-axis
"Body Acceleration Jerk Mean on X-axis" - Mean value of Jerk signal on X-axis, a measurement derived from the body linear acceleration
"Body Acceleration Jerk Mean on Y-axis" - Mean value of Jerk signal on Y-axis, a measurement derived from the body linear acceleration
"Body Acceleration Jerk Mean on Z-axis" - Mean value of Jerk signal on Z-axis, a measurement derived from the body linear acceleration
"Body Acceleration Jerk Standard Deviation on X-axis" - Standard Deviation value of Jerk signal on X-axis, a measurement derived from the body linear acceleration
"Body Acceleration Jerk Standard Deviation on Y-axis" - Standard Deviation value of Jerk signal on Y-axis, a measurement derived from the body linear acceleration
"Body Acceleration Jerk Standard Deviation on Z-axis" - Standard Deviation value of Jerk signal on Z-axis, a measurement derived from the body linear acceleration
"Body Gyroscope Signal  Mean on X-axis" - Mean value of gyroscope signal of body angular velocity on X-axis
"Body Gyroscope Signal  Mean on Y-axis" - Mean value of gyroscope signal of body angular velocity on Y-axis
"Body Gyroscope Signal  Mean on Z-axis" - Mean value of gyroscope signal of body angular velocity on Z-axis
"Body Gyroscope Signal  Standard Deviation on X-axis" - Standard Deviation value of gyroscope signal of body angular velocity on X-axis
"Body Gyroscope Signal  Standard Deviation on Y-axis" - Standard Deviation value of gyroscope signal of body angular velocity on Y-axis
"Body Gyroscope Signal  Standard Deviation on Z-axis" - Standard Deviation value of gyroscope signal of body angular velocity on Z-axis
"Body Gyroscope Signal Jerk Mean on X-axis" - Mean value of Jerk signal on X-axis, a measurement derived from the body angular velocity (body gyroscope signal) 
"Body Gyroscope Signal Jerk Mean on Y-axis" - Mean value of Jerk signal on Y-axis, a measurement derived from the body angular velocity (body gyroscope signal)
"Body Gyroscope Signal Jerk Mean on Z-axis" - Mean value of Jerk signal on Z-axis, a measurement derived from the body angular velocity (body gyroscope signal)
"Body Gyroscope Signal Jerk Standard Deviation on X-axis" Standard Deviation value of Jerk signal on X-axis, a measurement derived from the body angular velocity (body gyroscope signal) 
"Body Gyroscope Signal Jerk Standard Deviation on Y-axis" Standard Deviation value of Jerk signal on Y-axis, a measurement derived from the body angular velocity (body gyroscope signal) 
"Body Gyroscope Signal Jerk Standard Deviation on Z-axis" Standard Deviation value of Jerk signal on Z-axis, a measurement derived from the body angular velocity (body gyroscope signal) 
"Body Acceleration  Magnitude Mean" - Mean value of magnitude of body acceleration signal calculated using the Euclidean norm 
"Body Acceleration  Magnitude Standard Deviation" - Standard Deviation value of magnitude of body acceleration signal calculated using the Euclidean norm
"Gravity Acceleration  Magnitude Mean" - Mean value of magnitude of gravity acceleration signal calculated using the Euclidean norm
"Gravity Acceleration  Magnitude Standard Deviation" - Standard Deviation value of magnitude of gravity acceleration signal calculated using the Euclidean norm
"Body Acceleration Jerk Magnitude Mean" - Mean value of Magnitude (calculated with Euclidean norm) of Jerk signal, a measurement derived from the body linear acceleration 
"Body Acceleration Jerk Magnitude Standard Deviation" - Standard Deviation value of Magnitude (calculated with Euclidean norm) of Jerk signal, a measurement derived from the body linear acceleration 
"Body Gyroscope Signal  Magnitude Mean" - Mean value of Magnitude (calculated with Euclidean norm) of gyroscope signal of body angular velocity
"Body Gyroscope Signal  Magnitude Standard Deviation" - Standard Deviation value of Magnitude (calculated with Euclidean norm) of gyroscope signal of body angular velocity
"Body Gyroscope Signal Jerk Magnitude Mean" - Mean value of Magnitude (calculated with Euclidean norm) of Jerk signal, a measurement derived from the body angular velocity
"Body Gyroscope Signal Jerk Magnitude Standard Deviation" - Standard Deviation value of Magnitude (calculated with Euclidean norm) of Jerk signal, a measurement derived from the body angular velocity
"FFT Body Acceleration  Mean on X-axis" - Mean value of the result of Fast Fourier Transform applied to body acceleration signal on X-axis
"FFT Body Acceleration  Mean on Y-axis" - Mean value of the result of Fast Fourier Transform applied to body acceleration signal on Y-axis
"FFT Body Acceleration  Mean on Z-axis" - Mean value of the result of Fast Fourier Transform applied to body acceleration signal on Z-axis
"FFT Body Acceleration  Standard Deviation on X-axis" - Standard Deviation value of the result of Fast Fourier Transform applied to body acceleration signal on X-axis
"FFT Body Acceleration  Standard Deviation on Y-axis" - Standard Deviation value of the result of Fast Fourier Transform applied to body acceleration signal on Y-axis
"FFT Body Acceleration  Standard Deviation on Z-axis" - Standard Deviation value of the result of Fast Fourier Transform applied to body acceleration signal on Z-axis
"FFT Body Acceleration Jerk Mean on X-axis" - Mean value of the result of Fast Fourier Transform applied to Jerk signal on X-axis, a measurement derived from the body linear acceleration
"FFT Body Acceleration Jerk Mean on Y-axis" - Mean value of the result of Fast Fourier Transform applied to Jerk signal on Y-axis, a measurement derived from the body linear acceleration
"FFT Body Acceleration Jerk Mean on Z-axis" - Mean value of the result of Fast Fourier Transform applied to Jerk signal on Z-axis, a measurement derived from the body linear acceleration
"FFT Body Acceleration Jerk Standard Deviation on X-axis" - Standard Deviation value of the result of Fast Fourier Transform applied to Jerk signal on X-axis, a measurement derived from the body linear acceleration
"FFT Body Acceleration Jerk Standard Deviation on Y-axis" - Standard Deviation value of the result of Fast Fourier Transform applied to Jerk signal on Y-axis, a measurement derived from the body linear acceleration
"FFT Body Acceleration Jerk Standard Deviation on Z-axis" - Standard Deviation value of the result of Fast Fourier Transform applied to Jerk signal on Z-axis, a measurement derived from the body linear acceleration
"FFT Body Gyroscope Signal  Mean on X-axis" - Mean value of the result of Fast Fourier Transform applied to gyroscope signal of body angular velocity on X-axis
"FFT Body Gyroscope Signal  Mean on Y-axis" - Mean value of the result of Fast Fourier Transform applied to gyroscope signal of body angular velocity on Y-axis
"FFT Body Gyroscope Signal  Mean on Z-axis" - Mean value of the result of Fast Fourier Transform applied to gyroscope signal of body angular velocity on Z-axis
"FFT Body Gyroscope Signal  Standard Deviation on X-axis" - Standard Deviation value of the result of Fast Fourier Transform applied to gyroscope signal of body angular velocity on X-axis
"FFT Body Gyroscope Signal  Standard Deviation on Y-axis" - Standard Deviation value of the result of Fast Fourier Transform applied to gyroscope signal of body angular velocity on Y-axis
"FFT Body Gyroscope Signal  Standard Deviation on Z-axis" - Standard Deviation value of the result of Fast Fourier Transform applied to gyroscope signal of body angular velocity on Z-axis
"FFT Body Acceleration  Magnitude Mean" - Mean value of the result of Fast Fourier Transform applied to magnitude of body acceleration signal calculated using the Euclidean norm 
"FFT Body Acceleration  Magnitude Standard Deviation" - Standard Deviation value of the result of Fast Fourier Transform applied to magnitude of body acceleration signal calculated using the Euclidean norm 
"FFT Body Acceleration Jerk Magnitude Mean" - Mean value of the result of Fast Fourier Transform applied to magnitude (calculated with Euclidean norm) of Jerk signal, a measurement derived from the body linear acceleration 
"FFT Body Acceleration Jerk Magnitude Standard Deviation" - Standard Deviation value of the result of Fast Fourier Transform applied to magnitude (calculated with Euclidean norm) of Jerk signal, a measurement derived from the body linear acceleration 
"FFT Body Gyroscope Signal  Magnitude Mean" - Mean value of the result of Fast Fourier Transform applied to magnitude (calculated with Euclidean norm) of gyroscope signal of body angular velocity
"FFT Body Gyroscope Signal  Magnitude Standard Deviation" - Standard Deviation value of the result of Fast Fourier Transform applied to magnitude (calculated with Euclidean norm) of gyroscope signal of body angular velocity
"FFT Body Gyroscope Signal Jerk Magnitude Mean" - Mean value of the result of Fast Fourier Transform applied to magnitude (calculated with Euclidean norm) of Jerk signal, a measurement derived from the body angular velocity
"FFT Body Gyroscope Signal Jerk Magnitude Standard Deviation" - Standard Deviation value of the result of Fast Fourier Transform applied to magnitude (calculated with Euclidean norm) of Jerk signal, a measurement derived from the body angular velocity
