############structure 2.3.4 Software Installation#############
##On the official website https://web.stanford.edu/group/pritchardlab/structure_software/release_versions/v2.3.4/html/structure.html, download the linux-structure compressed package and select Download package without front end. In addition, download and install the C code (not installing it will cause the decompressed structure to not work normally)##

##Unzip structure compression package##
~$ tar -zxvf /home/minminli/software installation package/structure_linux_console.tar.gz -C /home/minminli/software/structure

##Unzip the C-code compressed package##
~$ tar -zxvf /home/minminli/software installation package/structure_kernel_source.tar.gz -C /home/minminli/software/structure

##Run structure##
~$ cd software/structure
~/software/structure$ ls
~/software/structure$ cd structure_kernel_src
~/software/structure/structure_kernel_src$ ls
~/software/structure/structure_kernel_src$ cat Makefile
~/software/structure/structure_kernel_src$ ls
~/software/structure/structure_kernel_src$ make
~/software/structure/structure_kernel_src$ ls
~/software/structure/structure_kernel_src$ ./structure





############structure 2.3.4 Software usage ############
##Create output directory##
~/software/structure/structure_kernel_src$ mkdir struct
##Fill in the configuration file, fill in the mainparams; generate an empty extraparams file, note that the number of mainparams configuration files is the maximum K value multiplied by the number of repetitions, for example, calculate K=1 to K=10, repeat 3 times, then the mainparams file The number should be 30, and the number of command lines should also be 30. The extraparams file is empty and one can be shared. Note, put the mainparams and empty extraparams files in the ~/software/structure/structure_kernel_src folder. ##

##mainparamsfile format##
#define OUTFILE /home/minminli/software/structure/structure_kernel_src/struct/structure_1_1
#define INFILE /home/minminli/software/tassel-5-standalone/TASSELTutorialData/data/test.imputed.maf0.05.int0.9.prune.in.recode.strct_in
#define NUMINDS 300
#define NUMLOCI 6331
#define LABEL 1
#define POPDATA 1
#define POPFLAG 0
#define LOCDATA 0
#define PHENOTYPE 0
#define MARKERNAMES 1
#define MAPDISTANCES 1
#define ONEROWPERIND 1
#define PHASEINFO 0
#define PHASED 0
#define RECESSIVEALLELES 0
#define EXTRACOLS 0
#define MISSING 0
#define PLOIDY 2
#define MAXPOPS 8
#define BURNIN 50000
#define NUMREPS 500000
#define RANDOMIZE 0
#define SEED 15
#define NOADMIX 0
#define LINKAGE 0
#define USEPOPINFO 0
#define LOCPRIOR 0
#define INFERALPHA 1
#define ALPHA 1.0
#define POPALPHAS 0
#define UNIFPRIORALPHA 1
#define ALPHAMAX 10.0
#define ALPHAPROPSD 0.025
#define FREQSCORR 1
#define ONEFST 0
#define FPRIORMEAN 0.01
#define FPRIORSD 0.05
#define INFERLAMBDA 0
#define LAMBDA 1.0
#define COMPUTEPROB 1
#define PFROMPOPFLAGONLY 0
#define ANCESTDIST 0
#define STARTATPOPINFO 0
#define METROFREQ 10
#define UPDATEFREQ 1

##Run the software to process the data, there is the group structure data obtained in the struct folder##
~/software/structure/structure_kernel_src$ ./structure
##Or ./structure -m mainparams2 -e extraparams;./structure -m mainparams3 -e extraparams##
~/software/structure/structure_kernel_src$ ./structure -m mainparams -e extraparams





############Calculation of ΔK#############
##Method 1: Use structureHarvester: http://taylor0.biology.ucla.edu/structureHarvester, 1) select all _f files, and pack these files into .zip data packages; 2) upload to the Structure Harvester website and wait Can ##
##Method 2: Using R package pophelper##
##windows installation>3.6.0 version R language, or install the latest version R##
####Judging the best K value based on deltaK####
##Package-install package devtools##
devtools::install_github('royfrancis/pophelper')
library("pophelper")
##Get Work Path##
getwd()
##Change working directory to desktop##
setwd("C:/Users/99039/Desktop/")
##struct/There are multiple duplicate results obtained by structure software in the folder, such as structure_1_1_f file##
file_list <- list.files(path = "struct/", full.names = T)
qlist <- readQ(file_list)
##Get a pdf and a txt result, take the smallest K value of deltaK##
evannoMethodStructure(summariseQ(tabulateQ(qlist)), exportplot=T,writetable=T,na.rm=T, imgtype = "pdf")

####Combine multiple repeated results into one file####
library("pophelper")
file_list <- list.files(path = "struct/", full.names = T)
qlist <- readQ(file_list)
##Generate a series of folders such as pop_K2, such as pop_K2-combined files, for multiple repetitions##
clumppExport(qlist = qlist)

####Make the merged file a structure bar graph####
library("pophelper")
##The data is in the desktop folder pop-both/, the file name is for example pop_K2-combined-merged, note that the result is repeated only once##
file_list2 <- list.files(path = "pop-both/", pattern = "merge", full.names = T)
qlist2 <- readQ(file_list2)
##All K value results are drawn together to generate pdf##
plotQ(qlist2[c(2:9,1)], sharedindlab = F, sortind = "all", imgtype = "pdf", ordergrp = F, imgoutput = "join", width = 15, outputfilename = paste0("structure_barplot "), showindlab=F, indlabsize = 0.5, indlabheight = 0.1)
##Draw the result graph of the specified K=9 value, generate pdf##
plotQ(qlist2[c(2:9,1)], sharedindlab = F, sortind = "all", imgtype = "pdf", ordergrp = F, imgoutput = "join", width = 15, outputfilename = paste0("structure_barplot"), showindlab=F, indlabsize = 0.5, indlabheight = 0.1)
##Draw the result graph of the specified K=9 value, generate pdf##
plotQMultiline(qlist2[9], imgtype = "pdf", sortind = "all", useindlab = T, width = 80, height = 15, indlabsize = 6, spl = 453)




