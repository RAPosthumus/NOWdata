library(dplyr)
library(tidyr)
library(rayshader)
library(ggplot2)
#make a crosstab of the data
source("http://pcwww.liv.ac.uk/~william/R/crosstab.r")
t<-crosstab(now_data, row.vars = "Provincie_naam", col.vars = "LD", type = "f")
#convert to data frame
t<-as.data.frame(t$table)
#remove row with sum
t<-t %>% filter(Provincie_naam !="Sum")

rsplot = ggplot(t) + geom_point(aes(y=Provincie_naam,x=LD,color=Freq))
rsplot = plot_gg(rsplot,width = 3.5, multicore = TRUE, windowsize = c(800, 800), 
                 zoom = 0.85, phi = 35, theta = 30, sunangle = 225, soliddepth = -1)

rsplot
