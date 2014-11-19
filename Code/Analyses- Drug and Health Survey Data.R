# Analyses- Drug and Health Survey Data 
# 11/15/14
# Pred 412

# Test comment

library(MMST)
library(ROCR)
library(randomForest)
library(plyr)
library(rpart)

# Helper function

#' Plot a confusion matrix for a given prediction set, and return the table.
#'
#' @param dataframe data.frame. Must contain \code{score} and \code{dep_var}
#'    columns. The confusion matrix will be calculated for these values.
#'    The mentioned columns must both be numeric.
#' @param cutoff numeric. The cutoff at which to assign numbers greater a 1
#'    for prediction purposes, and 0 otherwise. The default is 0.5.
#' @param plot.it logical. Whether or not to plot the confusion matrix as a
#'    four fold diagram. The default is \code{TRUE}.
#' @param xlab character. The labels for the rows (\code{dep_var}). The default
#'    is \code{c("dep_var = 0", "dep_var = 1")}.
#' @param ylab character. The labels for the rows (\code{score}). The default
#'    is \code{c("score = 0", "score = 1")}.
#' @param title character. The title for the fourfoldplot, if it is graphed.
#' @return a table. The confusion matrix table.
confusion_matrix <- function(dataframe, cutoff = 0.2, plot.it = TRUE,
                             xlab = c("ILLICIT DRUG ABUSER = NO", "ILLICIT DRUG ABUSER = YES"),
                             ylab = c("Predicted = 0", "Predicted = 1"), title = NULL) {
  stopifnot(is.data.frame(dataframe) &&
              all(c('score', 'dep_var') %in% colnames(dataframe)))
  stopifnot(is.numeric(dataframe$score) && is.numeric(dataframe$dep_var))
  
  
  dataframe$score <- ifelse(dataframe$score <= cutoff, 0, 1)
  categories <- dataframe$score * 2 + dataframe$dep_var
  confusion <- matrix(tabulate(1 + categories, 4), nrow = 2)
  colnames(confusion) <- ylab
  rownames(confusion) <- xlab
  if (plot.it) fourfoldplot(confusion, color = c("#CC6666", "#99CC99"),
                            conf.level = 0, margin = 1, main = title)
  confusion
  
}

# Clear the environment
rm(list = ls())

# Set the working directory 
# Note: This will need to change with each user. I'm not sure if we can set this
# to be the Github repo. 
setwd("/Users/kentm/Desktop/_NW MSPA/6- Fall 2014/Pred412-GroupProject")

# Load the data set
load("Final Data- Drug and Health Survey Data.RData")

surveydf.clean<-subset(surveydf, select = c(ABUSEILL, EDUCCAT2, POVERTY2, GOVTPROG, IRSEX, IRMARIT, EMPSTATY))
surveydf.clean<-na.omit(surveydf.clean)

# Create a simple logistic regression model with some demographics
illicit.drug.model <- glm(ABUSEILL ~ EDUCCAT2 + POVERTY2 +
                               GOVTPROG + IRSEX + IRMARIT + EMPSTATY,
                          data = surveydf.clean,
                          family = binomial(link=logit))

# Summarize the model
summary(illicit.drug.model)

# Coefficients
round(exp(cbind(Estimate=coef(illicit.drug.model),confint(illicit.drug.model))),2)

#ANOVA
illicit.drug.model.2 <- update(illicit.drug.model, . ~ . - EDUCCAT2 - POVERTY2 - GOVTPROG - IRSEX - IRMARIT - EMPSTATY)
anova(illicit.drug.model.2, illicit.drug.model, test="Chisq")

# get predictions from model 
surveydf.clean$score <- predict(illicit.drug.model, data=surveydf.clean, type = "response")

# LR Confusion matrix
surveydf.clean$dep_var<-revalue(surveydf.clean$ABUSEILL, c("(1) Yes (Any source variable above=1 & DEPNDILL=0)"=1, "(0) No/Unknown (Otherwise)"=0))
surveydf.clean$dep_var<-as.numeric(as.character(surveydf.clean$dep_var))

confusion_matrix(surveydf.clean, cutoff=0.015) # lower cutoffs than default of .5 in response score

# TRAIN/TEST REGIMEN

#divide the data into training and test sets 70/30
set.seed(1234)
integer.splitter <- runif(nrow(surveydf.clean))
integer.splitter <- ifelse(integer.splitter <= 0.7,1,0) # split data 70/30 training test
train <- surveydf.clean[which(integer.splitter == 1),]
test <- surveydf.clean[which(integer.splitter == 0),]

# MAIN EFFECTS MODEL
MyModelSpec <- {ABUSEILL ~ EDUCCAT2 + POVERTY2 + GOVTPROG + IRSEX + IRMARIT + EMPSTATY}

# fit model logistic regression with a few of the explanatory variables for demo
model.logistic <- glm(MyModelSpec, 
                      family = binomial(link=logit), data = train)
print(summary(model.logistic))

# get predictions from model 
predict.train.logistic <- predict(model.logistic, type = "response")
predict.test.logistic <- predict(model.logistic, test, type = "response")

train.logistic.pred <- prediction(predict.train.logistic, train$ABUSEILL)
train.logistic.roc <- performance(train.logistic.pred, "tpr","fpr")
train.logistic.auc <- (performance(train.logistic.pred, "auc"))@y.values

test.logistic.pred <- prediction(predict.test.logistic, test$ABUSEILL)
test.logistic.roc <- performance(test.logistic.pred, "tpr","fpr")
test.logistic.auc <- (performance(test.logistic.pred, "auc"))@y.values

# plot the ROC curves
plot(train.logistic.roc, col = "darkgreen", main = "ROC Curves for Logistic Regression Model")
plot(test.logistic.roc, col = "red",  add = TRUE)
abline(c(0,1))
# Draw a legend.
train.legend <- paste("Train: AUC=", round(train.logistic.auc[[1]], digits=3))
test.legend <- paste("Test : AUC=", round(test.logistic.auc[[1]], digits=3))
legend(0.6, 0.5, c(train.legend,test.legend), c(3,2))

# Random Forest Method
set.seed(9999)  # for reproducibility


# Subset data frame for RF
surveydf.rf<-subset(surveydf, select = c(ABUSEILL, ABUSEALC, GRSKD4_5, GRSKD5WK, DEPNDMRJ, ABUSEMRJ, GRSKMOCC, GRSKMREG, ABUSEIEM, ABILLALC, ABILANAL, DEPNDILL, DEPNDIEM, DPILLALC, DPILANAL, TXILALEV, ALCTRMT, ILLTRMT, TXILLALC, TXILANAL, TXLTILL2, AMHTXRC3, DRIVALD2, PAROL, PROB, ANXDLIF, DEPRSLIF, AMDELT, CATAGE, CATAG3, EDUCCAT2, POVERTY2, GOVTPROG, IRSEX, IRMARIT, EMPSTATY, COUTYP2, BOOKED))
surveydf.rf<-na.omit(surveydf.rf)

# divide into test and train 
integer.splitter <- runif(nrow(surveydf.rf))
integer.splitter <- ifelse(integer.splitter <= 0.7,1,0) # split data 70/30 training test
train <- surveydf.rf[which(integer.splitter == 1),]
test <- surveydf.rf[which(integer.splitter == 0),]

#MyModelRFSpec = {ABUSEILL~ABUSEALC+GRSKD4_5+GRSKD5WK+DEPNDMRJ+ABUSEMRJ+GRSKMOCC+GRSKMREG+ABUSEIEM+ABILLALC+ABILANAL+DEPNDILL+DEPNDIEM+DPILLALC+DPILANAL+TXILALEV+ALCTRMT+ILLTRMT+TXILLALC+TXILANAL+TXLTILL2+AMHTXRC3+DRIVALD2+PAROL+PROB+ANXDLIF+DEPRSLIF+AMDELT+CATAGE+CATAG3+EDUCCAT2+POVERTY2+GOVTPROG+IRSEX+IRMARIT+EMPSTATY+COUTYP2+BOOKED}
#MyModelRFSpec = {ABUSEILL~ABUSEALC+ABUSEMRJ+ABUSEIEM+ABILLALC+ABILANAL+DEPNDILL+EDUCCAT2+EMPSTATY}
MyModelRFSpec = {ABUSEILL~ABUSEIEM+ABILLALC+ABILANAL+EDUCCAT2+EMPSTATY}

model.rf <- randomForest(MyModelRFSpec, mtry = 3, data = train)
print(summary(model.rf))
print(model.rf$importance)

predict.train.rf <- predict(model.rf, type = "prob")[,2]
predict.test.rf <- predict(model.rf, test, type = "prob")[,2]

train.rf.pred <- prediction(predict.train.rf, train$ABUSEILL)
train.rf.roc <- performance(train.rf.pred, "tpr","fpr")
train.rf.auc <- (performance(train.rf.pred, "auc"))@y.values

test.rf.pred <- prediction(predict.test.rf, test$ABUSEILL)
test.rf.roc <- performance(test.rf.pred, "tpr","fpr")
test.rf.auc <- (performance(test.rf.pred, "auc"))@y.values

# plot the ROC curves
plot(train.rf.roc, col = "darkgreen", main = "ROC Curves for Random Forest Model")
plot(test.rf.roc, col = "red",  add = TRUE)
abline(c(0,1))
# Draw a legend.
train.legend <- paste("Train: AUC=", round(train.rf.auc[[1]], digits=3))
test.legend <- paste("Test : AUC=", round(test.rf.auc[[1]], digits=3))
legend(0.6, 0.5, c(train.legend,test.legend), c(3,2))

# RF Confusion matrix

train$dep_var<-revalue(train$ABUSEILL, c("(1) Yes (Any source variable above=1 & DEPNDILL=0)"=1, "(0) No/Unknown (Otherwise)"=0))
train$dep_var<-as.numeric(as.character(train$dep_var))
train$score <- predict(model.rf, type = "prob")[,2]

confusion_matrix(train, cutoff=0.5) # higher cutoffs than default of .5 in response score

# Logistic Regression with RF variables

# fit model logistic regression with a few of the explanatory variables for demo
model.logistic.2 <- glm(MyModelRFSpec, 
                      family = binomial(link=logit), data = train)
print(summary(model.logistic.2))

# Coefficients
round(exp(cbind(Estimate=coef(model.logistic.2),confint(model.logistic.2))),2)

# get predictions from model 
predict.train.logistic <- predict(model.logistic, type = "response")
predict.test.logistic <- predict(model.logistic, test, type = "response")

train.logistic.pred <- prediction(predict.train.logistic, train$ABUSEILL)
train.logistic.roc <- performance(train.logistic.pred, "tpr","fpr")
train.logistic.auc <- (performance(train.logistic.pred, "auc"))@y.values

test.logistic.pred <- prediction(predict.test.logistic, test$ABUSEILL)
test.logistic.roc <- performance(test.logistic.pred, "tpr","fpr")
test.logistic.auc <- (performance(test.logistic.pred, "auc"))@y.values

# plot the ROC curves
plot(train.logistic.roc, col = "darkgreen", main = "ROC Curves for Logistic Regression Model")
plot(test.logistic.roc, col = "red",  add = TRUE)
abline(c(0,1))
# Draw a legend.
train.legend <- paste("Train: AUC=", round(train.logistic.auc[[1]], digits=3))
test.legend <- paste("Test : AUC=", round(test.logistic.auc[[1]], digits=3))
legend(0.6, 0.5, c(train.legend,test.legend), c(3,2))



