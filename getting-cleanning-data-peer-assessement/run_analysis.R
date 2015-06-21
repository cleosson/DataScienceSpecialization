pre_setting = function() {    
    # Set the files name and URL
    file.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    zipfile.name <- paste0("dataset.zip")
    
    # If file does not exist, download it and unzip the file
    if (!file.exists(zipfile.name)) {
        download.file(file.url, destfile=zipfile.name, method="curl")
        unzip(zipfile.name, exdir=".")
    }
}


read_data = function(data.name) {
    if (data.name != "test" & data.name != "train") {
        stop('invalid data name')
    }

    # Set the auxiliary variables
    root.data.path <- paste0("UCI HAR Dataset/")
    data.path <- paste0("UCI HAR Dataset/", data.name, "/")
    
    # Get the activity labels
    # Step 3
    activity.labels.fn <- paste0(root.data.path, "activity_labels.txt")
    activity.labels.data = read.table(activity.labels.fn, header=FALSE, as.is=TRUE, col.names = c("ActivityId", "ActivityName"))
    # Coerce to factor
    activity.labels.data$ActivityName = as.factor(activity.labels.data$ActivityName)
    
    # Get the activities
    activities.fn <- paste0(data.path, "y_", data.name, ".txt")
    activities.data <- read.table(activities.fn, header=FALSE, col.names=c("ActivityId"))
    
    # Get the subject id
    subject.id.fn <- paste0(data.path, "subject_", data.name, ".txt")
    subject.id.data <- read.table(subject.id.fn, header=FALSE, col.names=c("SubjectId"))
    
    # Get the measures labels
    measures.labels.fn <- paste0(root.data.path, "features.txt")
    measures.labels.data <- read.table(measures.labels.fn, header=FALSE, col.names=c("MeasureId", "MeasureName"))
    
    # Get the measures
    measures.fn <- paste0(data.path, "X_", data.name, ".txt")
    # Step 4, use labels for variables
    measures.data <- read.table(measures.fn, header=FALSE, col.names=measures.labels.data$MeasureName)
    
    # Get only mean and standard deviation
    # Step 2
    measures.labels.data.subset = grep(".*mean\\(\\)|.*std\\(\\)", measures.labels.data$MeasureName)
    measures.data <- measures.data[, measures.labels.data.subset]
    
    # Merge them and create the train data set
    data.set <- data.frame(activities.data, subject.id.data, measures.data)
    # Use activity names
    # Step 3
    data.set <- select(merge(activity.labels.data, data.set), -ActivityId)
    data.set
}

merge_data = function() {
    # Merge train and test
    # Step 1
    train.data <- read_data("train")
    test.data <- read_data("test")
    merged.data <- rbind(train.data, test.data)
    col.names = colnames(merged.data)
    col.names = gsub("\\.+mean\\.+", col.names, replacement = "Mean")
    col.names = gsub("\\.+std\\.+", col.names, replacement = "Std")
    colnames(merged.data) = col.names
    merged.data
}

tidy_data = function(file.name) {
    library(dplyr)
    library(reshape2)
    
    merged.data <- merge_data()
    vars.id <- c("ActivityName", "SubjectId")
    vars.measure = setdiff(colnames(merged.data), vars.id)
    melted.data <- melt(merged.data, id=vars.id, measure.vars=vars.measure)

    # recast 
    tidy_data <- dcast(melted.data, ActivityName + SubjectId ~ variable, mean)
    
    write.table(tidy_data, file.name)
}

#pre_setting()
tidy_data("tidy_data.txt")