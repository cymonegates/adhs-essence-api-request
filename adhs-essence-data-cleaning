
# Title:   Cleaning ESSENCE Data Details Results
#  
# Details: Code for cleaning ESSENCE Data Details results. Assumes you have used a Location (Full Details) data source
#
# Author:  Cymone Gates, MPH
#
# Email:   syndromicsurveillance@azdhs.gov
#
# Written: 12-17-2022 | Last Modified: 2-16-2022


################################################################################################################
#LOAD PACKAGES
################################################################################################################

packages <- c("stringr","lubridate","tidyverse","httr","janitor","MMWRweek", "filesstrings", "xlsx", "plyr","openxlsx")

#install required packages if missing
if (length(setdiff(packages, rownames(installed.packages() ) ) ) > 0)   {
  install.packages(setdiff(packages, rownames(installed.packages() ) ) )  
  
}

#install Rnssp package if missing - If all of your packages are not up to date, you'll have to enter a 1 in the Console and press enter for the download to proceed
if (length(setdiff("Rnssp", rownames(installed.packages() ) ) ) > 0)   {
  devtools::install_github("cdcgov/Rnssp")
}

lapply(packages, library, character.only = TRUE)
lapply("Rnssp", library, character.only = TRUE)


################################################################################################################
#PULL DATA FROM ESSENCE
################################################################################################################

#use to authenticate to the BioSense Platform - do not modify - a window will appear for you to enter your credentials

myProfile <- Credentials$new(username = askme("Enter your username: "),password = askme())


#paste ESSENCE API URL (csv type) between quotation marks

url <- ""



#API call to bringing the data into R data frame called api_data

api_data <- myProfile$get_api_data(num_url, fromCSV = TRUE)


#####################################################################################################
#SUGGESTED DATA CLEANING
#####################################################################################################

#create new data frame called clean_visits
#remove duplicate visits
#set erroneous ages and dates of birth to missing
#create new county variable with only county name
#create new visit type field with patient class spelled out
#recode unknown race and ethnicity categories to 'Unknown'
#recode Native Hawaiians and Asians into one race category
#create new combined race & ethnicity field where Hispanic or Latino is it's own race
#drop other variables that aren't needed

clean_visits <- api_data  %>%
  distinct(Visit_ID,HospitalName,C_Visit_Date_Time,.keep_all = TRUE) %>% 
  arrange(desc(C_Visit_Date_Time)) %>% 
  distinct(Visit_ID,HospitalName,C_Patient_Class,.keep_all = TRUE) %>% 
  mutate(Age=ifelse(is.na(Birth_Date_Time)|Age<0|grepl("190[0-9]-01-01",as.Date(Birth_Date_Time)), NA,Age),
         Birth_Date=as.Date(Birth_Date_Time),
         Birth_Date=ifelse(grepl("190[0-9]-01-01",Birth_Date, NA,Birth_Date)),
         Patient_County=sub("AZ_","",Region),
         Visit_Type=recode(C_Patient_Class, E = "Emergency", I = "Inpatient", O = "Outpatient"),
         c_race= ifelse(c_race=="Not Categorized"| c_race=="Not Reported or Null","Unknown",
                                      ifelse(c_race=="Native Hawaiian or Other Pacific Islander" | c_race=="Asian",
                                             "Asian or Pacific Islander", c_race)),
         c_ethnicity=ifelse(c_ethnicity=="Not Categorized"| c_ethnicity=="Not Reported or Null","Unknown",c_ethnicity),
         Combined_Race_Eth = ifelse(c_ethnicity=="Hispanic or Latino","Hispanic or Latino",c_race)
           ) %>% 
  select(HospitalName,Visit_Type,Date,Year,MonthYear,WeekYear,Patient_County,Patient_Zip,Sex,c_race,c_ethnicity,Combined_Race_Eth,CCDDCategory_flat) %>% 
  dplyr::rename(Patient_Sex=Sex,Visit_Year=Year,Visit_Date=Date,Visit_MonthYear=MonthYear,Visit_WeekYear=WeekYear,Patient_Race=c_race,Patient_Ethnicity=c_ethnicity)
                   
  
#####################################################################################################
#END OF SCRIPT
#####################################################################################################

