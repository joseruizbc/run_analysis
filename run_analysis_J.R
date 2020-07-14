#Getting and cleaning data Course project#
# Leer en los datos 'Caractyeristicas'
features <- read.table("D:/Users/Contingencia/Escritorio/Positiva 2020/Getting data/Home/UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("D:/Users/Contingencia/Escritorio/Positiva 2020/Getting data/Home/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
## Leer en los datos 'Asunto'
subject_test <- read.table("D:/Users/Contingencia/Escritorio/Positiva 2020/Getting data/Home/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("D:/Users/Contingencia/Escritorio/Positiva 2020/Getting data/Home/UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("D:/Users/Contingencia/Escritorio/Positiva 2020/Getting data/Home/UCI HAR Dataset/test/y_test.txt", col.names = "code")
### Leer en los datos 'Actividades'
subject_train <- read.table("D:/Users/Contingencia/Escritorio/Positiva 2020/Getting data/Home/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("D:/Users/Contingencia/Escritorio/Positiva 2020/Getting data/Home/UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("D:/Users/Contingencia/Escritorio/Positiva 2020/Getting data/Home/UCI HAR Dataset/train/y_train.txt", col.names = "code")

1.fusiona los temas de entrenamiento y prueba
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

2.Extraer la media y la desviacion estandar 
TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

3.usar los nombres de las actividades para el conjunto de datos
TidyData$code <- activities[TidyData$code, 2]

4.Labels para cada variables con descripcion.
names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))
5.  Del anteior conjunto de datos crear uno con promedio,de
cada variavle por cada actividad.
FinalData <- TidyData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)

