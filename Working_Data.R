#comments
install.packages("tidyverse")
library("tidyverse")
cp /Documents/MICB425_materials 


#only for materials repo  

#Load data
read.table(file="Saanich.metadata.txt")
read.table(file="Saanich.metadata.txt", header=TRUE, row.names=1, sep="\t", na.strings="NAN", "NA", ".")

#save data as object in environment
metadata = read.table(file="Saanich.metadata.txt", header=TRUE, row.names=1, sep="\t")

OTU = read.table(file="Saanich.metadata.txt", header=TRUE, row.names=1, sep="\t")

data %>% function
function(data)

metadata %>%
  select(O2_uM)

#Select variables with O2 or oxygen in the name 
metadata %>%
  select(matches("O2|oxygen"))

#filter rows (samples where oxygen = 0)
metadata %>%
  filter(O2_uM == 0) %>%
  select(Depth_m)

#find anything with these names because | means "or" 
metadata %>%
  select(matches("CH4_nM|Temperature_C"))

#variables are CH4_nM and Temperature_C
#typically filter everything first (selects a row) you need before selecting (it takes the whole column)
metadata %>%
  filter(Temperature_C < 10) %>%
  filter(CH4_nM > 100) %>%    
  select(Depth_m, CH4_nM, Temperature_C)  
  
#It is equivalent to
metadata %>%
  filter(Temperature_C < 10 & CH4_nM > 100) %>%
  select(Depth_m, CH4_nM, Temperature_C)

#if you give it the same name it will change it in the table but not the ACTUAL data 
#always good to rename when you mutate
metadata %>% 
  mutate(new = N2O_nM/1000)

