# EDA- Drug and Health Survey Data 
# 10/21/14
# Pred 412

# Clear the environment
rm(list = ls())

# Load the necessary libraries
library(ggplot2)

# Set the working directory 
# Note: This will need to change with each user. I'm not sure if we can set this
# to be the Github repo. 
setwd("/Users/kentm/Desktop/_NW MSPA/6- Fall 2014/Pred412-GroupProject")

# Load the data set
load("Drug and Health Survey Data- 2012.RDA")

# Rename the dataframe
surveydf <- da34933.0001
rm(da34933.0001)

# Understanding what variables are available and seem important
names(surveydf)

# Variables to identify usage
names(surveydf)[grep("EVER", names(surveydf))]

# Variables to identify age of first trying
names(surveydf)[grep("TRY", names(surveydf))]

# Respondent gender
table(surveydf$IRSEX)

# Respondent race
table(surveydf$NEWRACE2)

# Respondent age
str(surveydf$AGE2) # Raw age
table(surveydf$AGE2) # Raw age

str(surveydf$CATAGE) # Categorized Age
table(surveydf$CATAGE) # Categorized Age

# Respondent education
str(surveydf$EDUCATN2) # Raw education
table(surveydf$EDUCATN2) 

str(surveydf$EDUCCAT2) # Categorized Education
table(surveydf$EDUCCAT2) # Categorized Education

# Respondenthealth status
str(surveydf$HEALTH)
table(surveydf$HEALTH)

str(surveydf$HEALTH2) # Fair and poor health grouped together
table(surveydf$HEALTH2)





