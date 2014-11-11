# Analyses- Drug and Health Survey Data 
# 11/11/14
# Pred 412

# Clear the environment
rm(list = ls())

# Set the working directory 
# Note: This will need to change with each user. I'm not sure if we can set this
# to be the Github repo. 
setwd("/Users/kentm/Desktop/_NW MSPA/6- Fall 2014/Pred412-GroupProject")

# Load the data set
load("Data/Final Data- Drug and Health Survey Data.RData")

# Create a simple logistic regression model with some demographics
illicit.drug.model <- glm(ABUSEILL ~ EDUCCAT2 + POVERTY2 +
                               GOVTPROG + IRSEX + IRMARIT + EMPSTATY,
                          data = surveydf,
                          family = binomial)

