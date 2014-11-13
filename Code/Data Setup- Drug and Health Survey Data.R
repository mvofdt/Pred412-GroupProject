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

# Drop the raw data set
rm(raw.surveydf)

# Save the final data as a CSV and the workspace 
# Load the workspace for analyses so the data structure is retained
write.csv(surveydf, "Data/Final Data- Drug and Health Survey Data.csv")
save.image("Data/Final Data- Drug and Health Survey Data.RData")

# Convert discrete data into factors
surveydf.clean<-transform(surveydf,
                          IRCGIRTB = as.factor(IRCGIRTB),
                          IRCGCRV  = as.factor(IRCGCRV ),
                          IRCGCRGP = as.factor(IRCGCRGP),
                          IRCGNCTL = as.factor(IRCGNCTL),
                          IRCGROUT = as.factor(IRCGROUT),
                          IRCGINCR = as.factor(IRCGINCR),
                          IRCGSAT  = as.factor(IRCGSAT ),
                          IRCGLMR  = as.factor(IRCGLMR ),
                          IRCGRGDY = as.factor(IRCGRGDY),
                          IRCGRGWK = as.factor(IRCGRGWK),
                          IRCGRGNM = as.factor(IRCGRGNM),
                          IRCGNCG  = as.factor(IRCGNCG ),
                          IRCGSLHR = as.factor(IRCGSLHR),
                          IRCGAVD  = as.factor(IRCGAVD ),
                          IRCGPLN  = as.factor(IRCGPLN ),
                          IRCGINFL = as.factor(IRCGINFL),
                          IRCGNINF = as.factor(IRCGNINF),
                          CIGFNLKE = as.factor(CIGFNLKE),
                          CIGFNSMK = as.factor(CIGFNSMK),
                          FTNDDNSP = as.factor(FTNDDNSP),
                          GRSKPKCG = as.factor(GRSKPKCG),
                          ALCLOTTM = as.factor(ALCLOTTM),
                          ALCGTOVR = as.factor(ALCGTOVR),
                          ALCKPLMT = as.factor(ALCKPLMT),
                          ALCNDMOR = as.factor(ALCNDMOR),
                          ALCLSEFX = as.factor(ALCLSEFX),
                          ALCCUTEV = as.factor(ALCCUTEV),
                          ALCEMCTD = as.factor(ALCEMCTD),
                          ALCPHCTD = as.factor(ALCPHCTD),
                          ALCLSACT = as.factor(ALCLSACT),
                          ALCWDSMT = as.factor(ALCWDSMT),
                          DEPNDALC = as.factor(DEPNDALC),
                          ALCSERPB = as.factor(ALCSERPB),
                          ALCPDANG = as.factor(ALCPDANG),
                          ALCLAWTR = as.factor(ALCLAWTR),
                          ALCFMFPB = as.factor(ALCFMFPB),
                          ALCFMCTD = as.factor(ALCFMCTD),
                          ABUSEALC = as.factor(ABUSEALC),
                          GRSKD4_5 = as.factor(GRSKD4_5),
                          GRSKD5WK = as.factor(GRSKD5WK),
                          MRJLOTTM = as.factor(MRJLOTTM),
                          MRJGTOVR = as.factor(MRJGTOVR),
                          MRJKPLMT = as.factor(MRJKPLMT),
                          MRJNDMOR = as.factor(MRJNDMOR),
                          MRJLSEFX = as.factor(MRJLSEFX),
                          MRJCUTEV = as.factor(MRJCUTEV),
                          MRJEMCTD = as.factor(MRJEMCTD),
                          MRJPHCTD = as.factor(MRJPHCTD),
                          MRJLSACT = as.factor(MRJLSACT),
                          DEPNDMRJ = as.factor(DEPNDMRJ),
                          MRJSERPB = as.factor(MRJSERPB),
                          MRJPDANG = as.factor(MRJPDANG),
                          MRJLAWTR = as.factor(MRJLAWTR),
                          MRJFMCTD = as.factor(MRJFMCTD),
                          ABUSEMRJ = as.factor(ABUSEMRJ),
                          GRSKMOCC = as.factor(GRSKMOCC),
                          GRSKMREG = as.factor(GRSKMREG),
                          ABUSEILL = as.factor(ABUSEILL),
                          ABUSEIEM = as.factor(ABUSEIEM),
                          ABILLALC = as.factor(ABILLALC),
                          ABILANAL = as.factor(ABILANAL),
                          DEPNDILL = as.factor(DEPNDILL),
                          DEPNDIEM = as.factor(DEPNDIEM),
                          DPILLALC = as.factor(DPILLALC),
                          DPILANAL = as.factor(DPILANAL),
                          TXILALEV = as.factor(TXILALEV),
                          ALCTRMT  = as.factor(ALCTRMT ),
                          ILLTRMT  = as.factor(ILLTRMT ),
                          TXILLALC = as.factor(TXILLALC),
                          TXILANAL = as.factor(TXILANAL),
                          TXLTILL2 = as.factor(TXLTILL2),
                          AMHTXRC3 = as.factor(AMHTXRC3),
                          DRIVALD2 = as.factor(DRIVALD2),
                          PAROL    = as.factor(PAROL   ),
                          PROB     = as.factor(PROB    ),
                          ANXDLIF  = as.factor(ANXDLIF ),
                          DEPRSLIF = as.factor(DEPRSLIF),
                          AMDELT   = as.factor(AMDELT  ),
                          CATAGE   = as.factor(CATAGE  ),
                          CATAG3   = as.factor(CATAG3  ),
                          EDUCCAT2 = as.factor(EDUCCAT2),
                          POVERTY2 = as.factor(POVERTY2),
                          GOVTPROG = as.factor(GOVTPROG),
                          IRSEX    = as.factor(IRSEX   ),
                          IRMARIT  = as.factor(IRMARIT ),
                          EMPSTATY = as.factor(EMPSTATY),
                          COUTYP2  = as.factor(COUTYP2 ),
                          BOOKED   = as.factor(BOOKED  )
                          )

# Investigation of certain variables as factors

# Per the survey data codebook, the cigarette variables appear to have
# a weighted least squares regression imputation for missing values
# if the observation contains 16 of 17 variables with coded data
# As such, the cigarette variables have values that appear continuous
# versus ordinal.

# Only IRCGROUT and IRCGRGDY have proper factor levels without imputation
# Nicotine dependance - NDSSANSP - should be treated as a continuous variable per
# the data codebook based upon regression imputation.
levels(surveydf.clean$IRCGROUT) # PROPER LEVELS
levels(surveydf.clean$IRCGRGDY) # PROPER LEVELS
levels(surveydf.clean$NDSSANSP) # NOT A FACTOR / CONTINUOUS 

