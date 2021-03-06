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
      
      # names of the reference tables
      
      stdvariable_names <- myvariables$short_en[ myvariables$ref_file==1 & !is.na(myvariables$ref_file) ]
      
      ### initialising the list of tables
      
      ref.tables <- vector("list", length = length(stdvariable_names))
      
      ##creating a list the tables
      
      ## the link variable is always the same as the short_en name in the main dataframe
      
      ## first table (ref ID)
      
      i <- 1
      
      tempdata <- Allmydata[[i+1]]

      names(tempdata) <- c( "Reference" , "description" )
      
      ref.tables[[i]] <- tempdata
      
      ## other tables
      
      for (i in 2:length(stdvariable_names)) {
      
      tempdata <- Allmydata[[i+1]]
      
        #only the english
      
      tempdata <-  tempdata[ , c(1,3) ]
      
      names(tempdata) <- c( stdvariable_names[i] , "Description" )
      
      ref.tables[[i]] <- tempdata
      
      }
      
      ## naming the elements
      
      names(ref.tables) <- stdvariable_names
            
########## saving relevant RDS R files
      
      SilicaDB_en <- mydata
      
      saveRDS( SilicaDB_en , "./EnglishDB/RDS_objects/SilicaDB_en.RDS")
      
      SilicaRefTables_en <- ref.tables
      
      saveRDS( SilicaRefTables_en , "./EnglishDB/RDS_objects/SilicaRefTables_en.RDS")
      
      SilicaVarList_en <- myvariables
      
      saveRDS( SilicaVarList_en , "./EnglishDB/RDS_objects/SilicaVarList_en.RDS")
            
      
########### saving data as CSV
      
      write.csv( SilicaDB_en ,  "./EnglishDB/CSV_files/SilicaDB_en.csv"  , row.names = FALSE , quote = TRUE )
      
      write.csv( SilicaVarList_en ,  "./EnglishDB/CSV_files/SilicaVarList_en.csv"  , row.names = FALSE , quote = TRUE )
      
      for (i in 1:length(stdvariable_names)) { 
        
        write.csv( SilicaRefTables_en[[i]] ,  paste("./EnglishDB/CSV_files/",
                                                    stdvariable_names[i],
                                                      ".csv", sep="")  
                   , row.names = FALSE , quote = TRUE )
        
        }
      
############ clearing thr R environment  
      
      rm(list = ls())
      