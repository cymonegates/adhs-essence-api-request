
# Title:   ESSENCE API Pull Template
#  
# Details: A template for Arizona Syndromic Surveillance users for pulling in ESSENCE data through APIs
#
# POC:     syndromicsurveillance@azdhs.gov
#
# Written: 9-14-2021 | Last Modified: 9-21-2021
#
# Resource: https://cdcgov.github.io/Rnssp/articles/Rnssp_intro.html


################################################################################################################
#LOAD RNSSP PACKAGE
################################################################################################################

#install Rnssp package if missing - If all of your packages are not up to date, you'll have to enter a 1 in the Console and press enter for the download to proceed
if (length(setdiff("Rnssp", rownames(installed.packages() ) ) ) > 0)   {
  devtools::install_github("cdcgov/Rnssp")
}

#load RNSSP
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
#PULL DATA FROM ESSENCE
################################################################################################################

#insert file path where your rNSSP myProfile is saved (or will be saved if you need to save it now) #e.g. //computer/Folder A/Folder B
point_to <- " "   #<------------------Enter your myProfile file path here with forward slashes

#THIS CODE ASSUMES YOU HAVE ALREADY SAVED YOUR rNSSP myProfile CREDENTIALS
    #IF YOU HAVE NOT SET THAT UP, UNCOMMENT LINES 47 & 49, ADD IN THE FILE PATHS AND RUN THE CODE SEGMENT
    #YOU'LL BE PROMPTED TO ENTER YOUR ESSENCE USERNAME AND PASSWORD. IT WILL BE ENCRYPTED.
    #THE COMMENTED CODE ONLY NEEDS TO BE RUN ONCE, UNLESS YOU NEED TO CHANGE YOUR PASSWORD, SO PLEASE PUT THE COMMENTS BACK

        #myProfile <- Credentials$new(username = askme("Enter your username: "),password = askme())

        #saveRDS(myProfile, file=paste0(point_to,"/myProfile.rds"))


# Load profile object from your saved location
myProfile <- readRDS(paste0(point_to,"/myProfile.rds")) 


#ESSENCE API 
  #Build Query in ESSENCE with your parameters
  #Select Data Details or Table Builder
  #Select Query Options-->API Urls-->Copy and paste the "CSV with Reference Values" API URL


url <- " "#<------------------Enter your API url here with forward slashes

#IF YOU WANT TO CHANGE THE START AND END DATES IN THE ORIGINAL API, UNCOMMENT THE CODE BELOW
    #start_date <- "YYYY-MM-DD" 
    #end_date <- "YYYY-MM-DD"  
    #url <- set_dates(url, start = start_date, end = end_date)

#API call to bringing the data into R data frame - Can be used for Table Builder or Data Details (line level) API Results
#If you want to bring in other types of ESSENCE data e.g. Time Series Data Table, Time Series Graph, etc. the syntax can be found at https://cdcgov.github.io/Rnssp/articles/Rnssp_intro.html

api_data <- myProfile$get_api_data(url, fromCSV = TRUE)


#output a csv file with the data
write.csv(api_data,
          file = " ", #<----------------Insert file path and csv file name e.g. #e.g. //computer/Folder A/Folder B/Test.csv
          row.names = FALSE)
