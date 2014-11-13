# Data Setup- Drug and Health Survey Data 
# 11/11/14
# Pred 412

# Clear the environment
rm(list = ls())

# Set the working directory 
# Note: This will need to change with each user. I'm not sure if we can set this
# to be the Github repo. 
setwd("/Users/kentm/Desktop/_NW MSPA/6- Fall 2014/Pred412-GroupProject")

# Load the data set
load("Data/Drug and Health Survey Data- 2012.RDA")

# Rename the dataframe
raw.surveydf <- da34933.0001
rm(da34933.0001)

# Subset the dataframe with variables of interest.
# We can rename them later
surveydf <- raw.surveydf[, c(
     
     # Nictone 
     "IRCGIRTB", "IRCGCRV", "IRCGCRGP", "IRCGNCTL", "IRCGROUT", "IRCGINCR", 
     "IRCGSAT", "IRCGLMR", "IRCGRGDY", "IRCGRGWK", "IRCGRGNM", "IRCGNCG", 
     "IRCGSLHR", "IRCGAVD", "CIGFNLKE", "IRCGPLN", "CIGFNSMK", "IRCGINFL", 
     "IRCGNINF", "NDSSANSP", "NDSSDNSP", "FTNDDNSP", "GRSKPKCG",
     
     # Alcohol
     "ALCLOTTM", "ALCGTOVR", "ALCKPLMT", "ALCNDMOR", "ALCLSEFX", "ALCCUTEV",
     "ALCEMCTD", "ALCPHCTD", "ALCLSACT", "ALCWDSMT", "DEPNDALC", "ALCSERPB",
     "ALCPDANG", "ALCLAWTR", "ALCFMFPB", "ALCFMCTD", "ABUSEALC", "GRSKD4_5",
     "GRSKD5WK",
     
     # Marijuana
     "MRJLOTTM", "MRJGTOVR", "MRJKPLMT", "MRJNDMOR", "MRJLSEFX", "MRJCUTEV",
     "MRJEMCTD", "MRJPHCTD", "MRJLSACT", "DEPNDMRJ", "MRJSERPB", "MRJPDANG",
     "MRJLAWTR", "MRJFMCTD", "ABUSEMRJ", "GRSKMOCC", "GRSKMREG",
     
     # Illicit Drug Recoded Variables
     "ABUSEILL", "ABUSEIEM", "ABILLALC", "ABILANAL", "DEPNDILL", "DEPNDIEM", 
     "DPILLALC", "DPILANAL", "TXILALEV", "ALCTRMT", "ILLTRMT", "TXILLALC", 
     "TXILANAL", "TXLTILL2",
     
     # Demographics
     "AMHTXRC3", "DRIVALD2", "PAROL", "PROB", "ANXDLIF", "DEPRSLIF", "AMDELT", 
     "CATAGE", "CATAG3", "EDUCCAT2", "POVERTY2", "GOVTPROG", "IRSEX", "IRMARIT", 
     "EMPSTATY", "COUTYP2", "BOOKED"  
)]

# Convert discrete data into factors
# Per the survey data codebook, the cigarette variables appear to have
# a weighted least squares regression imputation for missing values
# if the observation contains 16 of 17 variables with coded data
# As such, the cigarette variables have values that appear continuous
# versus ordinal.
col.index <- grep("^IRC", names(surveydf))
temp.mat <- as.matrix(surveydf[, col.index])
temp.mat[!temp.mat %in% c(1, 2, 3, 4, 5)] <- NA
surveydf[col.index] <- temp.mat

# Convert variables to factors
# Some go from 1-5
vars15 <- c("IRCGIRTB", "IRCGCRV", "IRCGCRGP", "IRCGAVD", "IRCGPLN",
          "IRCGROUT", "IRCGRGDY", "IRCGRGWK", "IRCGRGNM", "IRCGNINF", 
          "IRCGINCR", "IRCGSAT", "IRCGLMR")
surveydf[vars15] <- lapply(surveydf[vars15], factor, 
                         labels = c("Not at all true of me",
                                    "Sometiems true of me",
                                    "Moderately true of me",
                                    "Very true of me",
                                    "Extremely true of me"))

# The rest go from 5-1
vars51 <- c("IRCGNCTL", "IRCGNCG", "IRCGSLHR", "IRCGINFL")
surveydf[vars51] <- lapply(surveydf[vars51], factor, 
                         labels = c("Extremely true of me",
                                    "Very true of me",
                                    "Moderately true of me",
                                    "Sometiems true of me",
                                    "Not at all true of me"))

# Check the structure of the final data frame
#str(surveydf)

# Drop unneccesary objects
rm(raw.surveydf, temp.mat, col.index, vars15, vars51)

# Save the final data as a CSV and the workspace 
# Load the workspace for analyses so the data structure is retained
write.csv(surveydf, "Data/Final Data- Drug and Health Survey Data.csv")
save.image("Data/Final Data- Drug and Health Survey Data.RData")

