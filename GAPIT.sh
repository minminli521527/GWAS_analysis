########1.R Language Installation########
##First enter R in the terminal, if not installed, run##
~$ sudo apt install r-base-core

##After the installation is complete, enter R to enter the R language operating platform. ##
~$ R

##Enter the following command at the cursor to view the software package that R language has already included##
> .packages(all.available=T)

##Package Installation##
> options(BioC_mirror="http://mirrors.ustc.edu.cn/bioc/",repos=structure(c(CRAN="http://mirrors.tuna.tsinghua.edu.cn/CRAN/")) )
> source("http://www.bioconductor.org/biocLite.R")
> biocLite("multtest")
> biocLite("chopsticks")
> install.packages("gplots")
> if (!requireNamespace("BiocManager", quietly = TRUE))
 install.packages("BiocManager")
> BiocManager::install("snpStats")
> install.packages("LDheatmap")
> install.packages("genetics")
> install.packages("ape")
> install.packages("EMMREML")
> install.packages("scatterplot3d")

##Load data package##
library(multtest)
library(gplots)
library(LDheatmap)
library(genetics)
library(ape)
library(EMMREML)
library(compiler) #this library is already installed in R
library("scatterplot3d")
source("http://zzlab.net/GAPIT/gapit_functions.txt")
source("http://zzlab.net/GAPIT/emma.txt")


####Run Command####
##Get .hmp.txt file##
perl ./software/tassel_v5/run_pipeline.pl -fork1 -vcf ./data/test.impute.vcf -export test -exportType Hapmap -runfork1
Read file
myY <- read.table("test.trait.txt", head = TRUE)
myG <- read.table("test.hmp.txt", head = FALSE, comment.char = "")


##GLM##
myGAPIT_GLM=GAPIT(
Y=myY,
G=myG,
PCA.total=3,
file.output=T,
group.from=0,
group.to=0,
group.by=0,
memo="GLM"
)


##MLM##
myGAPIT_MLM=GAPIT(
Y=myY,
G=myG,
file.output=T,
group.from=nrow(myY),
group.to=nrow(myY),
group.by=10,
memo="MLM"
)


##ECMLM##
myGAPIT_ECMLM=GAPIT(
Y=myY,
G=myG,
PCA.total=3,
kinship.cluster=c("average", "complete", "ward"),
kinship.group=c("Mean", "Max"),
file.output=T,
group.from=0,
group.to=nrow(myY),
group.by=10,
memo="ECMLM"
)



##SUPER##
myGAPIT_SUPER <- GAPIT(
Y=myY,
G=myG,
PCA.total=3,
sangwich.top="MLM", #options are GLM,MLM,CMLM, FaST and SUPER
sangwich.bottom="SUPER", #options are GLM,MLM,CMLM, FaST and SUPER
LD=0.1,
iteration.output=F,
file.output=T
)
