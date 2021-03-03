#################################################################
#
#
#  Preparing the silica data for the Trade paper
#
#
#################################################################


########## libraries

library(readxl)

######### reading raw data

mydata <- read_xlsx("./Rawdata/Silica_OEDB20130115.xlsx")

excel_sheets(mydata)
