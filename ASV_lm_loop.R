q.filter <-
  subset_taxa(q.norm,Phylum=="D_1__Planctomycetes") 
 q.filtered <- as.data.frame(q.filter@otu_table) 

# Remove the otu_stats object so upon rerunning doesn’t add to existing object
rm(asv_stats)
# Create new data frame to hold linear model outputs
asv_stats = data.frame("Estimate" = numeric(0), "Std. Error"= numeric(0),"t value"= numeric(0),"Pr(>|t|)"= numeric(0))


#Run a loop across your row names from a table of your otu/asv table filtered to 
#just those within your taxon of interest. In this script, this table is named "m.filtered".
for (asv in row.names(q.filtered)){
#Make sure necessary packages are loaded
  require(tidyverse)
  require(knitr)

#Run a linear model of 1 OTU against depth
    linear_fit = q.norm %>% 
    psmelt() %>% 
    filter(OTU==asv) %>% 
    
    lm(Abundance ~ Depth_m, .) %>% 
    summary()
    
#Pull out the coefficients and p-values for depth
  asv_data = linear_fit$coefficients["Depth_m",]
#Add these values to a growing table of OTUs
  asv_stats <- rbind(asv_stats, asv_data)
}

#Rename columns of output table
colnames(asv_stats)<- (c("Estimate", "Std. Error","t value","Pr(>|t|)"))

#Apply row names from the m.filtered data to the lm output table
row.names(asv_stats) <- row.names(q.filtered)

#Print table
kable(asv_stats,caption="Correlation data of OTUs within Planctomycetes phylum across depth")

asv_stats %>% 
  p.adjust(method="fdr")

