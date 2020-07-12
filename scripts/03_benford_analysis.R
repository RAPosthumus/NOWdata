library(benford.analysis)
ba <- benford(register_now$`Toegekend bedrag`,2,sign="both")
suspects <- getSuspects(ba, register_now, how.many=2) %>% arrange(`Toegekend bedrag`)
suspects
duplicates <- getDuplicates(ba, register_now,how.many=2) %>% arrange(`Toegekend bedrag`)
duplicates 
plot(ba,except=c("mantissa","abs diff"), multiple=TRUE)

100*nrow(suspects)/nrow(register_now)
