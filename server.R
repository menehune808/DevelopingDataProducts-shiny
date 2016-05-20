#
# file: server.R
#
# autor:  gilbert maerina
#
# date:   201-05-20
#
library(shiny)

# require the sleep depravation results that are in the package lme4
library(lme4)
# need other libraries to support other functions
library(caret)
library(ggplot2)
library(lattice)
library(kernlab)

#
# The predict algorithm that will be used is a quantification of the
# reaction time in milliseconds based on the number of days sleep
# deprevation. Although we could use a linear method to determine a 
# predicted reaction time based on sleep time value, we opt for
# using the linear model for our predictions based on emperical
# data. Data looked linear suring exploratory analysis
# 
# We will use the sleepstudy dataset and the linear algorithm 
# to develop a prediction function. The function will require the
# number of days of sleep depravation to determine a reaction time
# associated with the number of days awake
#

# basic procedures
data(sleepstudy)
whole_data<-sleepstudy
set.seed(123456)
#
## split the data 50 training/25 validation/25 test
train50pct<-createDataPartition(whole_data$Reaction, p=0.5, list=FALSE)
training_set<-whole_data[train50pct,]

## split the remaining data 50/50 which hould represent 25/25 of original
remain_set<-whole_data[-train50pct,]
validate25pct<-createDataPartition(remain_set$Reaction, p=0.5,list=FALSE)
## apply partitioned data separation or validation set
validation_set<-remain_set[validate25pct,]
## apply partitioned data separation for test set
test_set<-remain_set[-validate25pct,]

# validation_set<-whole_data[-60pct,]
#
#
## train the data
lm_model<-lm(Reaction ~ Days, data=training_set)
#
#predict_training<-predict(lm_model, training_set)
#print(confusionMatrix(predict_training, training_set))
#predict_test<-predict(lm_model, test_set)
#print(confusionMatrix(predict_test, test_set))
#
# apply to user input
## get user input and put into a table
# input_tbl<-cbind(0,user_input)
# colnames(input_tbl)<-c("Reaction","Days")
#
# run the prediction on the user input
# predict(lm_model, input_tbl)
#

#
# define our function to predict the sleep depravation time
#
getSleepDepravationReactionTime<-function(daysWithoutSleep){
  res<-predict(lm_model,data.frame(Days=c(daysWithoutSleep)))
  as.list(res)[1]
}

shinyServer(
  function(input,output){
    output$outputValue <- renderPrint({getSleepDepravationReactionTime(input$daysWithoutSleep)})
    output$inputValue  <- renderPrint({input$daysWithoutSleep})
  }
)