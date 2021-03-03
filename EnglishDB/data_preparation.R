#################################################################
#
#
#  Preparing the silica data for english language
#
#
#################################################################


########## libraries

        library(readxl)
        library(writexl)

######### reading raw data

      #list of sheets
     
      mylist  <- excel_sheets("./Rawdata/Silica_OEDB20130115.xlsx")
      
      # recuperating all sheets
      
      Allmydata <- lapply(excel_sheets("./Rawdata/Silica_OEDB20130115.xlsx"), read_excel, path = "./Rawdata/Silica_OEDB20130115.xlsx")
      
      # variable dictionnaries
      
      myvariables <- read_excel("./Rawdata/Silica_variable_dictionnary.xlsx")
      
######## main database      
      
      mydata <- Allmydata[[1]]
      
      # keeping line 1 as names
      
      mydata <- mydata[ -c(1,2) , ]
      
      names( mydata ) <- myvariables$short_en

######### treating the standardized variables      
      
      i <- 1
      
      mycategory <- Allmydata[[i+1]]

      names(mycategory)
            
########## saving relevant RDS R files
      
      
      
      
      

            