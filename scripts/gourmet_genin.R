# Get General Information incidents which appear in Causes

year = 2014


setwd(system("pwd", intern = T) ) # set path to current directory
directory = "../data/"

output_name = paste(c("GenIn", year, "_gourmet.csv"), collapse = "")
genin_filename = paste(c(directory, "GenIn", year, "_cleaned.csv"), collapse = "")
causes_filename = paste(c(directory, "Causes", year, "_cleaned.csv"), collapse = "")

formatdate <- function(filename, isGenIn=F){
  thefile <- read.csv(filename, stringsAsFactors = F)
  thefile <- thefile[rowSums(is.na(thefile)) == 0,]
  thefile$inc_date[nchar(thefile$inc_date)==7] <-paste("0", thefile$inc_date[nchar(thefile$inc_date)==7], sep="")
  thefile$inc_date <- as.Date(thefile$inc_date, format = "%m%d%Y") # as.Date used for dates
  
  if (isGenIn){
    thefile$alarm[nchar(thefile$alarm)==11] <-paste("0", thefile$alarm[nchar(thefile$alarm)==11],sep="")
    thefile$alarm <- as.POSIXct(thefile$alarm, format = "%m%d%Y%H%M") # as.POSIXct used for datetimes
    
    thefile$arrival[nchar(thefile$arrival)==11] <-paste("0", thefile$arrival[nchar(thefile$arrival)==11],sep="")
    thefile$arrival <- as.POSIXct(thefile$arrival, format = "%m%d%Y%H%M")
    
    thefile$lu_clear[nchar(thefile$lu_clear)==11] <-paste("0", thefile$lu_clear[nchar(thefile$lu_clear)==11],sep="")
    thefile$lu_clear <- as.POSIXct(thefile$lu_clear, format = "%m%d%Y%H%M")
  }
  return(thefile)
}
genin_csv <- formatdate(genin_filename, T)
causes_csv <- formatdate(causes_filename)

genin_selected <- merge(x = causes_csv, y = genin_csv)

col <- colnames(genin_selected)
col <- col[!col %in%  colnames(genin_csv)]

genin_selected[col] <- NULL

write.csv(genin_selected, output_name)

print("done!")

