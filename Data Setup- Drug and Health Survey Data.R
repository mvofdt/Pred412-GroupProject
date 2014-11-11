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
load("Drug and Health Survey Data- 2012.RDA")

# Rename the dataframe
raw.surveydf <- da34933.0001
rm(da34933.0001)

# Subset the dataframe with variables of interest.
# We will rename them later
surveydf <- raw.surveydf[, c(
     
     # Nictone 
     "IRCGIRTB", "IRCGCRV", "IRCGCRGP", "IRCGNCTL", "IRCGROUT", "IRCGINCR", 
     "IRCGSAT", "IRCGLMR", "IRCGRGDY", "IRCGRGWK", "IRCGRGNM", "IRCGNCG", 
     "IRCGSLHR", "IRCGAVD", "CIGFNLKE", "IRCGPLN", "CIGFNSMK", "IRCGINFL", 
     "IRCGNINF", "NDSSANSP", "FTNDDNSP", "GRSKPKCG",
     
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



