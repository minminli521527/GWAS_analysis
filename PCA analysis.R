rm(list = ls())
setwd("C:/Users/99039/Desktop")
library("scatterplot3d")
#Only keep the PC column, change the column number to PC1 PC2 PC3
the.data = read.table(file ='test_PCA3.txt', header = TRUE ,sep = "\t")
PC1 <- the.data$PC1
PC2 <- the.data$PC2
PC3 <- the.data$PC3
d<-data.frame(x=the.data$PC1,y=the.data$PC2,z=the.data$PC3)
#Perform type conversion by column (except for the first column, the other columns are converted from character to numeric)
the.data[,1:5]<-lapply(the.data[,1:5],MARGIN=2,as.numeric)
head(the.data)
#Perform type conversion by column
#the.data <- apply(the.data, MARGIN=2, as.numeric)
#Convert the result from the matrix to data.frame
#the.data <- as.data.frame(the.data)


#Í¼1£¬Front view
pdf(file="3d_PCA-1.pdf",width=7,height=7)
color <- rep("blue")
scatterplot3d(PC1,PC2,PC3,color,pch=20, cex.symbols=0.5*par("cex"), cex.axis=0.8*par("cex.axis"),cex.lab=par("cex .lab"))
dev.off()


#Í¼2£¬360¡ãrotating multiple images
pdf('3d_PCA-2.pdf',onefile=TRUE,width=8,height=8)
color <- rep("blue")
#Adjust the angle, save
diffangle <- function(ang){
     scatterplot3d(PC1,PC2,PC3,main='3D plot',color=color,type='p',
                                     highlight.3d=F,angle=ang,grid=T,box=T,scale.y=1,
                                     pch=16,col.grid='lightblue', cex.symbols=0.5*par("cex"), cex.axis=0.8*par("cex.axis"),cex.lab=par("cex.lab "))
        }
#Produce a figure when the angle rotates
sapply(seq(-360,360,2),diffangle)
dev.off()



##Figure 3, rotated three-dimensional image, can not save HD
library("rgl")
plot3d(x,y,z,pch=20,col = "blue",size=0.3,box=T)
rgl.postscript("plot1.pdf", "pdf", drawText = TRUE)
