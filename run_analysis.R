library(dplyr)
library(tidyr)

#Peer-graded Assignment: Getting and Cleaning Data Course Project
headers<-read.delim("features.txt", sep = "", header = FALSE)[,2]


#Load data, add column names, and merges the training and the test sets.
x_test<-read.delim("X_test.txt", sep = "", header = FALSE)
x_test<-x_test %>% rename_at(names(x_test), ~ headers)


x_train<-read.delim("X_train.txt", sep = "", header = FALSE)
x_train<-x_train %>% rename_at(names(x_train), ~ headers)

y_test<-read.delim("Y_test.txt", sep = "", header = FALSE)
y_test<-rename(y_test, activity = V1)

y_train<-read.delim("Y_train.txt", sep = "", header = FALSE)
y_train<-rename(y_train, activity = V1)

sub_test <- read.delim("subject_test.txt", sep = "", header = FALSE)
sub_test<-rename(sub_test, subject = V1)
sub_train <- read.delim("subject_train.txt", sep = "", header = FALSE)
sub_train<-rename(sub_train, subject = V1)

test<-cbind(sub_test,y_test, x_test)
train<-cbind(sub_train, y_train, x_train)
all_data<-as.data.frame(rbind(test,train))


#Extracts only the measurements on the mean and standard deviation for each measurement.
all_data<-all_data[,grep('mean()|std()|activity|subject', names(all_data), value=FALSE)]


#Use descriptive activity names to name the activities in the data set.
activity_labels<-read.delim("activity_labels.txt", sep = "", header = FALSE)
activity_labels$V1<-as.character(activity_labels$V1)
activity_labels$V2<-as.character(activity_labels$V2)

for (i in 1:nrow(activity_labels)){
all_data$activity[all_data$activity == activity_labels[i,1]] <- activity_labels[i,2]
}


#Appropriately labels the data set with descriptive variable names.
all_data<-all_data %>% rename_at(names(all_data), ~sub("^t", "Time", names(all_data)))
all_data<-all_data %>% rename_at(names(all_data), ~sub("^f", "Fourier", names(all_data)))
all_data<-all_data %>% rename_at(names(all_data), ~sub("Mag", "Magnitude", names(all_data)))
all_data<-all_data %>% rename_at(names(all_data), ~sub("()", "", names(all_data)))



#Creates an independent tidy data set with the average of each variable for each activity and each subject.
means<-all_data %>% group_by(subject, activity) %>% summarise_all(funs(mean)) %>% gather(measurement, mean, -(subject:activity))

write.table(means, file = 'means.txt', row.name=FALSE)
