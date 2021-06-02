####  Code written by: Omar F. AlThuwaynee (PhD)
####      GIS and Geomatics engineering
####          email: omar.faisel@gmail.com

# Start

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
