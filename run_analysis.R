library(reshape2)

# Getting the data
filename <- 'har.zip'
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, filename)
}

if (!file.exists("UCI HAR Dataset")){
    unzip(filename)
}

# Load labels and featres
activityLabels <- read.table('UCI HAR Dataset/activity_labels.txt')
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character((features[,2]))

# Filter only mean and std features
relFeatures <- grep(".*mean.*|.*std.*", features[,2])
relFeatures.names <- features[relFeatures,2]
relFeatures.names <- gsub("[()]", "", relFeatures.names)

# Read train data
train <- read.table("UCI HAR Dataset/train/X_train.txt")[relFeatures]
trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

# Read test data
test <- read.table("UCI HAR Dataset/test/X_test.txt")[relFeatures]
testActivities <- read.table("UCI HAR Dataset/test/y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# Merge train and test datasets
data <- rbind(train, test)
colnames(data) <- c("subject", "activity", relFeatures.names)

# Create a tidy dataset
data$activity <- factor(data$activity, levels = activityLabels[,1], labels = activityLabels[,2])
data$subject <- as.factor(data$subject)

data.melted <- melt(data, id=c('subject', 'activity'))
data.mean <- dcast(data.melted, subject + activity ~ variable, mean)
write.table(data.mean, 'tidy.txt', row.names = FALSE, quote = FALSE)

