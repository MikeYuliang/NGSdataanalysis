library(tidyverse)
library(DESeq2)
#import data
setwd("../Activated_Bcells/counts")
mycounts<-read.table("Mergedata.txt",header = TRUE,row.names = 1,sep ="\t" )
condition<-factor(c(rep("KO",2),rep("WT",2)),levels = c("WT","KO"))
colData<-data.frame(row.names = colnames(mycounts),condition)

dds <- DESeqDataSetFromMatrix(mycounts, colData, design= ~ condition)
dds <- DESeq(dds)

res= results(dds)
res = res[order(res$pvalue),]
head(res)
summary(res)
write.csv(res,file="All_results.csv")

