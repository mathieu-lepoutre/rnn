library(readr)
library(readr)
library(ggplot2)
library(keras)
library(tidyverse)
library(caret)



data <- read.csv("~/GitHub/rnn/DataShipPositions.csv")

 
 ## Why is the dataframe with characters not with numerics ?
 
 ##How do I make a rnn ?
 
 str(data)

 summary(data)
 
 ggplot(data, aes(x=1:nrow(data),y=AISTrajectPositionLongitude)) + geom_line()
 ggplot(data, aes(x=1:nrow(data),y=AISTrajectPositionLatitude)) + geom_line()
 
 data <- data.matrix(data[,-1])
 
 head(data)
 data
 
##RNN
 
 max_len <- 6
 batch_size <- 32
 
total_epochs <- 15

set.seed(123)

lat <- data$AISTrajectPositionLatitude
long <- data$AISTrajectPositionLongitude

##latitude
start_indexes <- seq(1, length(lat) - (max_len + 1), by = 3)

weather_matrix <- matrix(nrow = length(start_indexes), ncol = max_len + 1)

for (i in 1:length(start_indexes)){
  weather_matrix[i,] <- lat[start_indexes[i]:(start_indexes[i] + max_len)]
}


weather_matrix <- weather_matrix*1

if(anyNA(weather_matrix)){
  weather_matrix <- na.omit(weather_matrix)
}


X <- weather_matrix[,-ncol(weather_matrix)]
y <- weather_matrix[,ncol(weather_matrix)]


training_index <- createDataPartition(y, p = .9, 
                                      list = FALSE, 
                                      times = 1)

X_train <- array(X[training_index,], dim = c(length(training_index), max_len, 1))
y_train <- y[training_index]


X_test <- array(X[-training_index,], dim = c(length(y) - length(training_index), max_len, 1))
y_test <- y[-training_index]





model <- keras_model_sequential()
y

writeLines('PATH="${RTOOLS40_HOME}\\usr\\bin;${PATH}"', con = "~/.Renviron")



