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
plotQMultiline(qlist2[9], imgtype = "pdf", sortind = "all", useindlab = T, width = 80, height = 15, indlabsize = 6, spl = 453)





