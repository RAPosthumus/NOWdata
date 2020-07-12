#load libs
library(dplyr)
library(readr)
library(ggplot2)
library(ggstatsplot)
library(ggcharts)

#get base data loaded
register_now <- read_delim("data/register-now.csv", ";", escape_double = FALSE, trim_ws = TRUE)
prov <- read_delim("data/Woonplaatsen_in_Nederland_2020_12072020_141248.csv", ";", escape_double = FALSE, trim_ws = TRUE)

#wrangle data for easy programming
data <- register_now
data <- data %>% mutate(VP=toupper(Vestigingsplaats))
data <- data %>% mutate(AV=toupper(`Naam aanvrager`))
data <- data %>% mutate(Bedr=`Toegekend bedrag`)
prov <- prov %>% mutate(WP=toupper(Woonplaats))
# the now data set contains places with provinfo attached
#cleaup prov_data
prov[which(prov[,2]=='WP3510'),1]<-'Hengelo Ov'
prov[which(prov[,2]=='WP3596'),1]<-'Oosterhout Nb'
prov[which(prov[,2]=='WP2061'),1]<-'Noordwijk Zh'
prov[which(prov[,2]=='WP1213'),1]<-'Zevenhuizen Zh'
prov[which(prov[,2]=='WP2459'),1]<-'Rijswijk Zh'
prov[which(prov[,2]=='WP2890'),1]<-'Laren Nh'
prov[which(prov[,2]=='WP1707'),1]<-'Katwijk Zh'
prov[which(prov[,2]=='WP2843'),1]<-'Vianen Ut'
prov[which(prov[,2]=='WP3606'),1]<-'Nijkerk Gld'
prov[which(prov[,2]=='WP2764'),1]<-'Ede Gld'
prov[which(prov[,2]=='WP1392'),1]<-'Breukelen Ut'
prov[which(prov[,2]=='WP2432'),1]<-'Ijsselstein Ut'
prov[which(prov[,2]=='WP1500'),1]<-'Velp Gld'
prov[which(prov[,2]=='WP3198'),1]<-'Velp Nb'
prov[which(prov[,2]=='WP2615'),1]<-'Hoorn Terschelling'
prov[which(prov[,2]=='WP2417'),1]<-'OUDEGA SUDWEST-FRYSLAN'
prov[which(prov[,2]=='WP1763'),1]<-'Oosterwolde Fr'
prov[which(prov[,2]=='WP2318'),1]<-'Makkum Fr'
prov[which(prov[,2]=='WP3614'),1]<-'Hoorn Nh'
prov[which(prov[,2]=='WP3605'),1]<-'Oostrum Lb'
prov[which(prov[,2]=='WP3605'),1]<-'Oostrum Lb'
prov[which(prov[,2]=='WP1914'),1]<-'Elsloo Lb'
prov[which(prov[,2]=='WP2589'),1]<-'Buren Fr'
prov[which(prov[,2]=='WP2135'),1]<-'Scherpenzeel Gld'
#TODO: add further updates for prov such that nd is small ass poissible (see below)
#for joining use uppercase for woonplaats.
prov <- prov %>% mutate(WP=toupper(Woonplaats))

#join data & prov on VP/WP
now_data <- left_join(data,prov,by=c("VP"="WP"))

#choose top 500 for testing
#now_data <- now_data %>% slice_sample(n=500)

nd<- now_data %>% filter(is.na(Landsdeel))
nd
unique(nd$VP)
