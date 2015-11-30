#This project is a re-creation of the Tutorial;
#https://github.com/wehrley/wehrley.github.io/blob/master/SOUPTONUTS.md
#This script cleans and sets up the environment.

#This is the kTitanic Project.


rm(list=ls())

setwd("C://Users//s0042767//Documents//R//kTitanic//kTitanic")

#Load required libraries
source("./requires.R")
#Load User defined functions
source("./functions.R")
#Get data.
# This loads train and test data.
source("./getData.R")

#Munge the Data

titles.na.train <- c("Dr", "Master", "Mrs", "Miss", "Mr")

## Title consolidation
df.train$Title <- getTitle(df.train)
#First impute Age
df.train$Age <- imputeMedian(df.train$Age, df.train$Title,titles.na.train)
#There are two NAs. Change to Southhampton
df.train$Embarked[which(is.na(df.train$Embarked))] <- 'S'



df.train$Title <- changeTitles(df.train, c("Capt", "Col", "Don", "Dr", "Jonkheer", "Lady", "Major", "Rev", "Sir"),"Noble")
df.train$Title <- changeTitles(df.train, c("the Countess", "Ms"), "Mrs")
df.train$Title <- changeTitles(df.train, c("Mlle", "Mme"), "Miss")
df.train$Title <- as.factor(df.train$Title)

## impute missings on Fare feature with median fare by Pclass
df.train$Fare[ which( df.train$Fare == 0 )] <- NA
df.train$Fare <- imputeMedian(df.train$Fare, df.train$Pclass, as.numeric(levels(df.train$Pclass)))



df.train <- featureEngrg(df.train)


train.keeps <- c("Fate", "Sex", "Boat.dibs", "Age", "Title","Class", "Deck", "Side", "Fare", "Fare.pp","Embarked", "Family")

df.train.munged <- df.train[train.keeps]

#



