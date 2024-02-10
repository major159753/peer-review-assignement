##peer-grad assignement##
library(tidyverse)

## import datasets

x_test <- read_table("C:/Users/Owner/Desktop/coursera/datasciencecoursera/data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", col_names = FALSE)
y_test <- read_table("C:/Users/Owner/Desktop/coursera/datasciencecoursera/data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", col_names = FALSE)
subject_test <- read_table("C:/Users/Owner/Desktop/coursera/datasciencecoursera/data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", col_names = FALSE)

x_train <- read_table("C:/Users/Owner/Desktop/coursera/datasciencecoursera/data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", col_names = FALSE)
y_train <- read_table("C:/Users/Owner/Desktop/coursera/datasciencecoursera/data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", col_names = FALSE)
subject_train <- read_table("C:/Users/Owner/Desktop/coursera/datasciencecoursera/data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", col_names = FALSE)

### binding test and train ###

y_test <- y_test %>% 
  rename(activity = X1)

subject_test <- subject_test %>% 
  rename(subject = X1)

y_train <- y_train %>% 
  rename(activity = X1)

subject_train <- subject_train %>% 
  rename(subject = X1)

test_data <- subject_test %>% 
  cbind(y_test) %>% 
  cbind(x_test) %>% 
  as_tibble() ##combine columns of the test data

train_data <- subject_train %>% 
  cbind(y_train) %>% 
  cbind(x_train) %>% 
  as_tibble() ##combine columns of the train data

all_data <- test_data %>% 
rbind(train_data)  ##combine both data into one 

### import name vector ###

names <- read_table("C:/Users/Owner/Desktop/coursera/datasciencecoursera/data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt", col_names = FALSE)

### add the names to the table
vec_name <- names %>% 
  select(X2) %>% 
  add_row(X2 = "activity",.before = 1) %>% 
  add_row(X2 = "subject",.before = 1) %>%
  deframe() ## create a vector of features name

all_data_2 <- set_names(head(all_data, n= 10301), vec_name ) ### add it to the dataset

### update activity names

activity_name <- c("walking","walking_up","walking_down", "sitting", "standing", "laying")

all_data_2 <- all_data_2 %>% 
  select(1:2,matches("std\\()|mean\\()")) %>% 
mutate(activity = activity_name[all_data_2$activity]) ## select the columns containing mean and sd

## make new tidy data
final_tidy_data <- all_data_2 %>% 
  group_by(subject, activity) %>% 
  summarise(across(1:66, ~ mean(.x)))

final_tidy_data %>% 
  write.csv("tidydata.csv") ## make csv file


getwd()















