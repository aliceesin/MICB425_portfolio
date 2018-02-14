#load tidyverse
library("tidyverse")

#load phyloseq
source("https://bioconductor.org/biocLite.R")
biocLite("phyloseq")
library("phyloseq")

#Import data 
metadata = read.table(file="Saanich.metadata.txt", header=TRUE, row.names=1, sep="\t")
OTU = read.table(file="Saanich.OTU.txt", header=TRUE, row.names=1, sep="\t", na.strings="NAN", "NA", ".")
load("phyloseq_object.RData")

#dot plots
ggplot(metadata, aes(x=O2_uM, y=Depth_m)) +
  geom_point(color="blue")

#Exercise 3
#SiO2 graph with purple triangles 
ggplot(metadata, aes(x=SiO2_uM, y=Depth_m)) +
  geom_point(color="purple", shape=17)

#Exercise 2
#changing from celcius to fahrenheit using mutate then chain together ggplot function using dplyr 
metadata %>% 
  select(Depth_m, Temperature_C) %>% 
  mutate(Temperature_F = (Temperature_C*1.8)+32) %>%
  ggplot(aes(x=Temperature_F, y=Depth_m))+
  geom_point()

#ggplot with phyloseq because it understands taxonomy
physeq

#plot the phylum level by specifying the fill
plot_bar(physeq, fill="Phylum")

#plot the phylum level so that abundances are the same (change it into a percentage using physeq_percent)
physeq_percent = transform_sample_counts(physeq, function(x) 100 * x/sum(x))
plot_bar(physeq_percent, fill="Phylum")

#plot the phylum level and get rid of the black lines using geombar
plot_bar(physeq_percent, fill="Phylum") + 
  geom_bar(aes(fill=Phylum), stat="identity")  #stat means that it doesn't see OTUs as separate data

#Exercise 3: Bar plot with Order
physeq_percent = transform_sample_counts(physeq, function(x) 100 * x/sum(x))
plot_bar(physeq_percent, fill = "Order") +
  geom_bar(aes(fill=Phylum), stat="identity") +
  labs(title = "Order from 10 to 200m Saanich Inlet", x="Sample depth", y="Percent relative abundance")

#Faceting-good for low abundance taxa so we can see it
plot_bar(physeq_percent, fill="Phylum") +
  geom_bar(aes(fill=Phylum), stat="identity") +
  facet_wrap(~Phylum, scales = "free_y") +   #use scales="free_y" so that each graph has its own scale
  theme(legend.position = "none") #removes the legend

#Exercise 4: Faceted figure of nutrient concentrations 
#pipeline dplyr functions to ggplot 
metadata %>% 
  select(Depth_m, NH4_uM, NO2_uM, NO3_uM, O2_uM, PO4_uM, SiO2_uM) %>% 
  gather(nutrient, uM,NH4_uM:SiO2_uM ) %>% 
  ggplot(aes(x=Depth_m, y=uM)) +
  geom_line() +
  geom_point() +
  facet_wrap(~nutrient, scales ="free_y")
  
  