

############# ############# Step 1: extract zip files ############# ############# 

## for All files in folder with single steps
install.packages("plyr")
library(plyr)


## Open main zip folder

list.files("C:/Users/OMAR/Documents/Rainfall thresholds model/Rainfall threshold", pattern = ".zip", recursive = F)

My_path= "C:/Users/OMAR/Documents/Rainfall thresholds model/Rainfall threshold" #EDIT HERE
From_Dir <- list.files(path = My_path , pattern = "ASOS_new student.zip", full.names = TRUE)
To_Dir<- file.path((My_path))
ldply(.data = From_Dir, .fun = unzip, exdir = To_Dir)


## Now sub folders

AA="C:/Users/OMAR/Documents/Rainfall thresholds model/Rainfall threshold/ASOS_new student/ASOS"
setwd(AA)
list.dirs(AA, recursive = F, full.names = F)

{A = "station 98 1999~2010" #change station ID only!
My_path= A #EDIT HERE
From_Dir <- list.files(path = My_path , pattern = "*.zip", full.names = TRUE)
To_Dir<- file.path((My_path))

# unzip all your files
ldply(.data = From_Dir, .fun = unzip, exdir = To_Dir)
do.call(file.remove, list(list.files(My_path, full.names = TRUE, pattern = ".zip")))
list.dirs(AA, recursive = F, full.names = F)}



# Test if any
length(list.files(AA, full.names = TRUE, pattern = ".zip", recursive = T))





#Resources
# Manipulate paths https://rdrr.io/r/base/basename.html
# get all the zip files (https://stackoverflow.com/questions/41954183/how-can-i-extract-multiple-zip-files-and-read-those-csvs-in-r) 


###############














############# ############# START 2: Manage header and sort in separate folder ############# 

setwd("C:/Users/OMAR/Documents/WD Threshold/805station")
newdir <- "C:/Users/OMAR/Documents/WD Threshold/805station_update/"
files <- dir(pattern="*.csv")
for (my.file in files){
  a <- read.csv(my.file,header=T)
    a=a[-2]
  names(a)[1] <- ("ID")
  names(a)[2] <- ("DATE")
  names(a)[3] <- ("AMOUNT")
  a$DATE=as.POSIXct(a$DATE)
  ######################## Read 1 year date
  
  library(lubridate)
  R= as.numeric(substr(my.file, 12, 15))  # to subtract the date part from the ID name of the station, position 12 (2) to position 15 (1) (ex."805station(2011)")
  R1=((R*10000+101))   # To add the first month 01 and first day 01 at the digit after the year
  R2=((R*10000+1231))   # To add the end of the year 12 month 31 days
  D1=as.Date(as.character(R1), "%Y%m%d")  
  D2=as.Date(as.character(R2), "%Y%m%d")
  b=(seq(as.POSIXct(D1), as.POSIXct(D2), by="hour"))
  #b=(seq(as.POSIXct("1993-01-01 1:00:00"), as.POSIXct("1993-12-31 1:00:00"), by="hour"))
  b= as.data.frame(b)
  names(b)[1]="DATE"
  
  ############# #merge the two data frames  
  # https://www.datasciencecentral.com/profiles/blogs/how-to-write-an-r-function-to-match-and-merge-2-files-like
  C=dplyr::left_join(b, a, by="DATE")    # join in larger dataframe
  # d=dplyr::right_join(b, a, by="DATE") # join in smaller dataframe
  C$AMOUNT[is.na(C$AMOUNT)] <- 0  # NA TO 0
  C$ID[is.na(C$ID)] <- 805   # give the station name
  C=C[-2]  # remove the ID 
  
  
  write.csv(C,file=paste(newdir,"UPDATED ",my.file,sep=""))#,row.names=FALSE,col.names=FALSE) ,"INPUT/landslides.csv",sep=""
}

##################





































#ARCHIVE

## CASE 1 if you want to create another folder to save files
#change station ID only!
list.dirs("C:/Users/OMAR/Documents/Rainfall thresholds model/Rainfall threshold/ASOS/ASOS", recursive = F)
Path= "C:/Users/OMAR/Documents/Rainfall thresholds model/Rainfall threshold/ASOS/ASOS/station 100 1999~2010" #EDIT HERE
From_Dir <- list.files(path = Path , pattern = "*.zip", full.names = TRUE)
newfolder <- basename(Path)  
dir.create(file.path((Path), newfolder))
To_Dir<- (file.path((Path), newfolder))

# unzip all your files
ldply(.data = From_Dir, .fun = unzip, exdir = To_Dir)
do.call(file.remove, list(list.files(Path, full.names = TRUE, pattern = ".zip")))
list.dirs("C:/Users/OMAR/Documents/Rainfall thresholds model/Rainfall threshold/ASOS/ASOS", recursive = F)




















### Archieve


################################################################### JUST TEST
############## read rain gague
file_input_raingauge<-paste(current_dir,"805station/805station(1993).csv",sep="")
a<- read.csv(file_input_raingauge, header=T)
a=a[-2]
names(a)[1] <- ("ID")
names(a)[2] <- ("DATE")
names(a)[3] <- ("AMOUNT")
a$DATE=as.POSIXct(a$DATE)
######################## Read 1 year date
b=(seq(as.POSIXct("1993-01-01 1:00:00"), as.POSIXct("1993-12-31 1:00:00"), by="hour"))
b= as.data.frame(b)
names(b)[1]="DATE"
############# #merge the two data frames  
# https://www.datasciencecentral.com/profiles/blogs/how-to-write-an-r-function-to-match-and-merge-2-files-like
C=dplyr::left_join(b, a, by="DATE")    # join in larger dataframe
# d=dplyr::right_join(b, a, by="DATE") # join in smaller dataframe
C$AMOUNT[is.na(C$AMOUNT)] <- 0  # NA TO 0
C$ID[is.na(C$ID)] <- 805
write.csv(C,"./805station/805station(1993)1.csv")
#####################
################################################################### JUST TEST FINISHED HERE


