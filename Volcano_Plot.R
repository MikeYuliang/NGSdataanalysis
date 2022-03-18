setwd("C:/Users/xjmik/Desktop/")
diff_gene <- read.table("All_results.txt", sep="\t", header=TRUE, row.names=1)
diff_gene=as.data.frame(diff_gene)
gene_list=diff_gene[,c("avg_log2FC","p_val_adj")]
colnames(gene_list)=c("logFC","padj")
gene_list$threshold = as.factor(abs(gene_list$logFC) > 1.5 & gene_list$padj < 0.05)
colored_point<-gene_list[gene_list$threshold == "TRUE",]
gene_list$threshold<-as.character(gene_list$threshold)
Mycolors<-c("Gray","Black")
library("ggplot2")
pdf("vocano.pdf")

g = ggplot(data=gene_list, aes(x=logFC, y=-log10(padj),color=threshold)) + geom_point(alpha=0.5,size=1.75)  + xlim(c(-2, 2)) + ylim(c(0, 12.5)) +xlab("log2 fold change") + ylab("-log10 p-value") + theme_set(theme_bw()) + theme(panel.grid.major=element_line(colour=NA)) + scale_color_manual(values = Mycolors)
print(g)
dev.off()
