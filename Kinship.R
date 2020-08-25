rm(list = ls())
setwd("C:/Users/99039/Desktop")
library("gplots")
x = read.table(file ='test_kinship.txt', header = T) #After the original data is processed, the first row and the first column are the row names, and the first row in the first column is names
x
row.names<-x$name
x<-x[,2:300]
y<-data.matrix(x)
png('kinship.png') #When the picture is too big, output the png picture to see
x_heatmap<-heatmap(y,col=redgreen(75),scale="row",key=TRUE,symkey=FALSE,density.info="none",trace="none",labRow=row.names,cexRow= 0.68,cexCol=0.03)
dev.off()

#figure 2
z<-as.matrix(x)
png('kinship.png')
heatmap.2(z,col=redgreen, labRow=row.names,trace="none")
dev.off()

#image 3
z<-as.matrix(x)
png('kinship.png')
heatmap.2(z,col=topo.colors, labRow=row.names,trace="none")
dev.off()

#Figure 4
z<-as.matrix(x)
png('kinship.png')
heatmap.2(z,col=colorpanel(100,low="white",high="steelblue"), labRow=row.names,trace="none")
dev.off()

#Figure 5
z<-as.matrix(x)
png('kinship.png')
heatmap.2(z,col=redblue, labRow=row.names,trace="none")
dev.off()

#Figure 6
z<-as.matrix(x)
png('kinship.png')
heatmap.2(z,col=terrain.colors(100),labRow=row.names,trace="none")
dev.off()

#Figure 7
z<-as.matrix(x)
png('kinship.png')
heatmap.2(z,col=cm.colors(100),labRow=row.names,trace="none")
dev.off()

#Figure 8
z<-as.matrix(x)
png('kinship.png')
heatmap.2(z,col=heat.colors(100),labRow=row.names,trace="none")
dev.off()
