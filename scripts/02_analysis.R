
# Create a boxplot of the dataset, outliers are shown as two distinct points
bp <- now_data %>%
  ggplot(aes(x="",y=Bedr))+
  geom_boxplot() +
  ggtitle('Box plot before outlier removal') + ylab("Toegekend bedrag") + xlab("NOW data")
bp
ggsave(paste("Boxplot_before_outlier_removal",".png",sep=""))
#show analysis based on landsdeel
ggbetweenstats(now_data,Landsdeel, Bedr, outlier.tagging = TRUE)
ggsave(paste("Boxplot_landsdeel_before_outlier_removal",".png",sep=""))
#calculate ranges for eliminating outliers
Q <- quantile(now_data$Bedr, probs=c(.25, .75), na.rm = FALSE)
iqr <- IQR(now_data$Bedr)
up  <- Q[2]+1.5*iqr # Upper Range  
low <- Q[1]-1.5*iqr # Lower Range

#apply subsetting
eliminated<- subset(now_data, now_data$Bedr > (Q[1] - 1.5*iqr) & now_data$Bedr < (Q[2]+1.5*iqr))

bp <- eliminated %>%
  ggplot(aes(x="",y=Bedr))+
  geom_boxplot() +
  ggtitle('Box plot after outlier removal') + ylab("Toegekend bedrag") + xlab("NOW data")
bp
ggsave(paste("Boxplot_after_outlier_removal",".png",sep=""))
ggbetweenstats(eliminated,Landsdeel, Bedr, outlier.tagging = TRUE)
ggsave(paste("Boxplot_landsdeel_after_outlier_removal",".png",sep=""))

#make barplots on geo/info
data <- now_data 
data <- data %>% group_by(AV,Landsdeel,Provincie_naam,Gemeente_naam,VP) %>% summarise(n=n(),TB=sum(Bedr))

bp <-data %>% 
  arrange(desc(TB)) %>% 
  ggplot(aes(x=reorder(Landsdeel,TB,sum), y=TB)) +
  geom_bar(stat='identity') +
  coord_flip() +
  ggtitle("NOW-bedragen per landsdeel")+ ylab("Toegekend bedrag") + xlab("Landsdeel")

bp 
ggsave(paste("Bedrag_per_landsdeel",".png",sep=""))
for (l in unique(data$Landsdeel)) {
  gp <-data %>% filter(Landsdeel==l) %>%  
    arrange(desc(TB)) %>% 
    ggplot(aes(x=reorder(Gemeente_naam,TB,sum),y=TB)) +
    geom_bar(stat = 'identity') +
    coord_flip()+
    ggtitle(paste("NOW-bedragen per Gemeente in landsdeel ",l,sep="")) +
    ylab("Toegekend bedrag") + xlab("Gemeente")
  gp 
  ggsave(paste(l,".png",sep=""))
}
