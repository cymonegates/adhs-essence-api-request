
# Title:   ESSENCE API Pull Template
#  
# Details: A template for Arizona Syndromic Surveillance users for pulling in ESSENCE data through APIs for automated reports
#
# Author:  Cymone Gates, MPH - ADHS Informatics Epidemiologist
#
# POC:     syndromicsurveillance@azdhs.gov
#
# Written: 9-14-2021 | Last Modified: 9-30-2021
#
# Resource: https://cdcgov.github.io/Rnssp/articles/Rnssp_intro.html


################################################################################################################
#LOAD RNSSP PACKAGE & COMMONLY USED PACKAGES
################################################################################################################


#commonly used packages you might need - devtools is required to install the Rnssp package for the first time
packages <- c("devtools","stringr","lubridate","tidyverse","httr","janitor","MMWRweek", "filesstrings", "xlsx", "plyr","openxlsx")

#install commonly used packages if missing
if (length(setdiff(packages, rownames(installed.packages() ) ) ) > 0)   {
  install.packages(setdiff(packages, rownames(installed.packages() ) ) )  
  
}

#load commonly used packages
lapply(packages, library, character.only = TRUE)


#install required Rnssp package if missing
#If all of your packages are not up to date, you'll have to enter a 1 in the Console and press enter for the download to proceed <----READ THIS

if (length(setdiff("Rnssp", rownames(installed.packages() ) ) ) > 0)   {
  devtools::install_github("cdcgov/Rnssp")
}

#load Rnssp package
lapply("Rnssp", library, character.only = TRUE)



################################################################################################################
#SET_DATES FUNCTION TO CHANGE START & END DATES IN ESSENCE API
################################################################################################################

set_dates <- function(url, start = (Sys.Date()-7), end = Sys.Date()) {
  
  # pull out the end date from the url
  old_end <- regmatches(url, regexpr('endDate=.+?&', url)) %>% str_replace(.,"endDate=","") %>% str_replace(.,"&","")
  # format the new end date you specify when calling the function
  new_end <- format(as.Date(end), "%e%b%Y")
  # replace the old end date with the new end date
  url <- gsub("[[:space:]]", "", str_replace(url, old_end, new_end))
  # pull out the start date from the url
  old_start <- regmatches(url, regexpr('startDate=.+?&', url)) %>% str_replace(.,"startDate=","") %>% str_replace(.,"&","")
  # format the new start date you specify when calling the function
  new_start <- str_trim(format(as.Date(start), "%e%b%Y"))
  # replace the old start date with the new start date
  url <- gsub("[[:space:]]", "", str_replace(url, old_start, new_start))
  
  return(url)
}

################################################################################################################
#SET UP OR PULL IN YOUR ESSENCE CREDENTIALS
################################################################################################################

#insert file path where your rNSSP myProfile is saved (or will be saved if you need to save it now) #e.g. //computer/Folder A/Folder B

point_to <- " "   #<------------------Enter your file path here with forward slashes


#THIS R SCRIPT ASSUMES YOU HAVE ALREADY COMPLETED THE STEPS BELOW TO SAVE YOUR rNSSP myProfile CREDENTIALS. If YOU HAVE, SKIP TO LINE 92. IF NOT, FOLLOW THE STEPS.

      #1 - Uncomment lines 86 and 88
      #2 - Run line 86 without changing anything. You'll be prompted to enter your ESSENCE username and password. It will be encrypted.
      #3 - Run line 88 without changing anything. This will save your credentials to the file path you saved in point_to.
      #4 - Check your file path to ensure the myProfile.rds file is there
      #5 - Recomment lines 86 and 88 so they are ignored when the script runs. 

    #NOTE: when you change your BioSense Platform / ESSENCE password, you'll need to repeat steps 1 - 5 to update your credentials.

        #myProfile <- Credentials$new(username = askme("Enter your username: "),password = askme())

        #saveRDS(myProfile, file=paste0(point_to,"/myProfile.rds"))


# Load profile object from your saved location
myProfile <- readRDS(paste0(point_to,"/myProfile.rds")) 


################################################################################################################
#PULL DATA FROM ESSENCE USING API URL
################################################################################################################

#You will need to first build your query in the ESSENCE Query Portal and then grab the API for those results
  #1 - Build Query in ESSENCE with your parameters
  #2 - Select Data Details or Table Builder
  #3 - Select Query Options-->API Urls-->Copy and paste the "CSV" API URL. If there are 2 CSV URLS, copy the"CSV with Reference Values" URL


url <- " "#<------------------Paste your API url here

#IF YOU WANT TO CHANGE THE START AND END DATES IN THE ORIGINAL API, UNCOMMENT LINES 104 - 106 and ENTER YOUR DESIRED DATES
    #start_date <- "YYYY-MM-DD" 
    #end_date <- "YYYY-MM-DD"  
    #url <- set_dates(url, start = start_date, end = end_date)


#API call to bringing the data into R data frame - Can be used for Table Builder or Data Details (line level) API Results

#If you want to bring in other types of ESSENCE data e.g. Time Series Data Table, Time Series Graph, etc. the syntax can be found at https://cdcgov.github.io/Rnssp/articles/Rnssp_intro.html

api_data <- myProfile$get_api_data(url, fromCSV = TRUE)



################################################################################################################
#EXPORT DATA
################################################################################################################

#output a csv file with the data
write.csv(api_data,
          file = " ", #<----------------Insert file path and csv file name e.g. #e.g. //computer/Folder A/Folder B/Test.csv
          row.names = FALSE
          )


#output excel file with the data
write.xlsx(api_data, file = " " #<----------------Insert file path and xlsx file name e.g. #e.g. //computer/Folder A/Folder B/Test.xlsx
           )





