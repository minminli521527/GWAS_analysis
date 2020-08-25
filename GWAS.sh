############Install java############

############download tassel5 software############
~$ git clone https://bitbucket.org/tasseladmin/tassel-5-standalone.git
##Put the tassel software in the tassel-5-standalone folder of the software folder of the main directory##
~$ cd /home/minminli/software/tassel-5-standalone
##The sample files that come with the software and your own data are stored in /home/minminli/software/tassel-5-standalone/TASSELTutorialData/data/##
~$ cd /home/minminli/software/tassel-5-standalone/TASSELTutorialData/data/

##Perform genotype filling test.vcf: test.imputed.vcf##
~/tassel-5-standalone$ perl run_pipeline.pl -Xms512m -Xmx5g -importGuess /home/minminli/software/tassel-5-standalone/TASSELTutorialData/data/test.vcf -LDKNNiImputationPlugin -highLDSSites 50 -knnTaxa 5 -maxLDDistance 100000000- endPlugin -export /home/minminli/software/tassel-5-standalone/TASSELTutorialData/data/test.imputed.vcf -exportType VCF

##tassel software does PCA analysis, test.imputed.vcf is placed in the same folder, and the first 3 principal components are generated, test_PCA.txt##
~/software/tassel-5-standalone$ perl run_pipeline.pl -fork1 -importGuess test.imputed.vcf -PrincipalComponentsPlugin -covariance true -endPlugin -export test_PCA.txt -runfork1

##tassel software does kinship analysis, test.imputed.vcf is placed in the same folder, and test_kinship.txt##
~/software/tassel-5-standalone$ perl run_pipeline.pl -importGuess test.imputed.vcf -KinshipPlugin -method Centered_IBS -endPlugin -export test_kinship.txt -exportType SqrMatrix





############plink for data filtering and format conversion############

##Install plink, enter plink official website http://www.cog-genomics.org/plink2/download linux 64 bit, put the compressed package in the software folder under the main directory, unzip the installation package##
~/software$ mkdir plink
~/software$ unzip -n -d ./plink plink_linux_x86_64_20200121.zip

##plinkfilter-MAF0.05 and missing rate 0.1, test.imputed.vcf: test.imputed.maf0.05.int0.9##
~/software$ /home/minminli/software/plink/plink --vcf /home/minminli/software/tassel-5-standalone/TASSELTutorialData/data/test.imputed.vcf --maf 0.05 --geno 0.1 --recode vcf-iid --out /home/minminli/software/tassel-5-standalone/TASSELTutorialData/data/test.imputed.maf0.05.int0.9 --allow-extra-chr
~/software$ cd /home/minminli/software/tassel-5-standalone/TASSELTutorialData/data/
~/software/tassel-5-standalone/TASSELTutorialData/data$ ll
~/software/tassel-5-standalone/TASSELTutorialData/data$ less test.imputed.maf0.05.int0.9.vcf
~/software/tassel-5-standalone/TASSELTutorialData/data$ cat test.imputed.maf0.05.int0.9.log

##Select the markers based on LD, and take one of the SNPs with LD, 50kb 10snp step size LD value 0.2, produce test.impute.maf0.05.int0.9.prune.in and test.impute.maf0.05. int0.9.prune.out file, in represents the selected mark, out represents the removed mark, both files only have the marked ID##
~/software/tassel-5-standalone/TASSELTutorialData/data$ /home/minminli/software/plink/plink --vcf /home/minminli/software/tassel-5-standalone/TASSELTutorialData/data/test.imputed.maf0. 05.int0.9.vcf --indep-pairwise 50 10 0.2 --out /home/minminli/software/tassel-5-standalone/TASSELTutorialData/data/test.imputed.maf0.05.int0.9 --allow- extra-chr
~/software/tassel-5-standalone/TASSELTutorialData/data$ less -N test.imputed.maf0.05.int0.9.prune.in

##Extraction of screening results##
##Convert to a bed file, extract the vcf file corresponding to the SNP in the prune.in file to generate test.imputed.maf0.05.int0.9.prune.in.bed, test.imputed.maf0.05.int0.9 .prune.in.bim, test.imputed.maf0.05.int0.9.prune.in.fam file##
~/software/tassel-5-standalone/TASSELTutorialData/data$ /home/minminli/software/plink/plink --vcf /home/minminli/software/tassel-5-standalone/TASSELTutorialData/data/test.imputed.maf0. 05.int0.9.vcf --make-bed --extract /home/minminli/software/tassel-5-standalone/TASSELTutorialData/data/test.imputed.maf0.05.int0.9.prune.in --out /home/minminli/software/tassel-5-standalone/TASSELTutorialData/data/test.imputed.maf0.05.int0.9.prune.in

##The filtered data is converted back to the vcf format, and the test.imputed.maf0.05.int0.9.prune.in.vcf file is generated##
~/software/tassel-5-standalone/TASSELTutorialData/data$ /home/minminli/software/plink/plink --bfile /home/minminli/software/tassel-5-standalone/TASSELTutorialData/data/test.imputed.maf0. 05.int0.9.prune.in --recode vcf-iid --out /home/minminli/software/tassel-5-standalone/TASSELTutorialData/data/test.imputed.maf0.05.int0.9.prune.in
##View SNP number##
~/software/tassel-5-standalone/TASSELTutorialData/data$ less -N test.imputed.maf0.05.int0.9.prune.in.vcf

##Convert the filtered bed file into structure format and admixture data format##
##Generate test.imputed.maf0.05.int0.9.prune.in.recode.strct_in,structure file##
~/software/tassel-5-standalone/TASSELTutorialData/data$ /home/minminli/software/plink/plink -bfile /home/minminli/software/tassel-5-standalone/TASSELTutorialData/data/test.imputed.maf0.05 .int0.9.prune.in --recode structure --out /home/minminli/software/tassel-5-standalone/TASSELTutorialData/data/test.imputed.maf0.05.int0.9.prune.in
##Generate test.imputed.maf0.05.int0.9.prune.in.ped, Admixture file##
~/software/tassel-5-standalone/TASSELTutorialData/data$ /home/minminli/software/plink/plink -bfile /home/minminli/software/tassel-5-standalone/TASSELTutorialData/data/test.imputed.maf0.05 .int0.9.prune.in --recode 12 --out /home/minminli/software/tassel-5-standalone/TASSELTutorialData/data/test.imputed.maf0.05.int0.9.prune.in




############Use structure software to analyze and get the group structure############
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
plotQMultiline(qlist2[9], imgtype = "pdf", sortind = "all", useindlab = T, width = 80, height = 15, indlabsize = 6, spl = 453)







############Admixture software analysis, get the group structure############
##Software download, official website download compressed package http://software.genetics.ucla.edu/admixture/download.html##
~$ tar -zxvf /home/minminli/software installation package/admixture_linux-1.3.0.tar.gz -C /home/minminli/software/admixture
~$ cd /home/minminli/software/admixture/admixture_linux-1.3.0

##Run admixture software##
~/software/admixture/admixture_linux-1.3.0$ ./admixture

##data processing###
  ##admixture supported format: plink bed file or ped file, if the data format is plink bed file, such as a.bed, then it should include a.bim, a.fam; if the data format is plink ped file, for example b.ped, then b.map##
~$ cd /home/minminli/software/tassel-5-standalone/TASSELTutorialData/data/
##Each k value generates two files, CV value and P, Q. The result of the .Q file is mainly used for GWAS, but the results of the two files do not have the header and sample name, which are required when inputting the Tassel software as a covariate Add sample name and <Covariate> identifier and headers starting with <Trait>##
~/software/tassel-5-standalone/TASSELTutorialData/data$ /home/minminli/software/admixture/admixture_linux-1.3.0/admixture --cv test.imputed.maf0.05.int0.9.prune.in.ped 1 >> log.txt
~/software/tassel-5-standalone/TASSELTutorialData/data$ /home/minminli/software/admixture/admixture_linux-1.3.0/admixture --cv test.imputed.maf0.05.int0.9.prune.in.ped 2 >> log.txt
~/software/tassel-5-standalone/TASSELTutorialData/data$ /home/minminli/software/admixture/admixture_linux-1.3.0/admixture --cv test.imputed.maf0.05.int0.9.prune.in.ped 3 >> log.txt
~/software/tassel-5-standalone/TASSELTutorialData/data$ /home/minminli/software/admixture/admixture_linux-1.3.0/admixture --cv test.imputed.maf0.05.int0.9.prune.in.ped 4 >> log.txt
~/software/tassel-5-standalone/TASSELTutorialData/data$ /home/minminli/software/admixture/admixture_linux-1.3.0/admixture --cv test.imputed.maf0.05.int0.9.prune.in.ped 5 >> log.txt
~/software/tassel-5-standalone/TASSELTutorialData/data$ /home/minminli/software/admixture/admixture_linux-1.3.0/admixture --cv test.imputed.maf0.05.int0.9.prune.in.ped 6 >> log.txt
~/software/tassel-5-standalone/TASSELTutorialData/data$ /home/minminli/software/admixture/admixture_linux-1.3.0/admixture --cv test.imputed.maf0.05.int0.9.prune.in.ped 7 >> log.txt
~/software/tassel-5-standalone/TASSELTutorialData/data$ /home/minminli/software/admixture/admixture_linux-1.3.0/admixture --cv test.imputed.maf0.05.int0.9.prune.in.ped 8 >> log.txt
~/software/tassel-5-standalone/TASSELTutorialData/data$ /home/minminli/software/admixture/admixture_linux-1.3.0/admixture --cv test.imputed.maf0.05.int0.9.prune.in.ped 9 >> log.txt
~/software/tassel-5-standalone/TASSELTutorialData/data$ /home/minminli/software/admixture/admixture_linux-1.3.0/admixture --cv test.imputed.maf0.05.int0.9.prune.in.ped 10 >> log.txt
~/software/tassel-5-standalone/TASSELTutorialData/data$ /home/minminli/software/admixture/admixture_linux-1.3.0/admixture --cv test.imputed.maf0.05.int0.9.prune.in.ped 11 >> log.txt
~/software/tassel-5-standalone/TASSELTutorialData/data$ /home/minminli/software/admixture/admixture_linux-1.3.0/admixture --cv test.imputed.maf0.05.int0.9.prune.in.ped 12 >> log.txt
~/software/tassel-5-standalone/TASSELTutorialData/data$ /home/minminli/software/admixture/admixture_linux-1.3.0/admixture --cv test.imputed.maf0.05.int0.9.prune.in.ped 13 >> log.txt
##Select the appropriate number of clusters k value, and then see which k value corresponds to the lower cv value in log.txt, which k value to use##







############Use tassel for association analysis############
##tassel software generates hapmap format from vcf and puts test.imputed.vcf in the same folder to generate test.hmp.txt##
~/software/tassel-5-standalone$ perl run_pipeline.pl -fork1 -vcf test.imputed.vcf -export test -exportType Hapmap -runfork1

##Sort the SNP of the test.hmp.txt file to generate test_sort.hmp.txt##
~/software/tassel-5-standalone$ perl run_pipeline.pl -SortGenotypeFilePlugin -inputFile test.hmp.txt -outputFile test_sort -fileType Hapmap

##GLM correlation analysis, the required test_sort.hmp.txt, test.trait.txt, test_structure.sample5.txt data are placed in the same file to generate test_glm_file##
~/software/tassel-5-standalone$ perl run_pipeline.pl -fork1 -h test_sort.hmp.txt -fork2 -r test.trait.txt -fork3 -q test_structure.sample5.txt -excludeLastTrait -combine4 -input1 -input2- input3 -intersect -glm -export test_glm_ -runfork1 -runfork2 -runfork3

##MLM correlation analysis, the required test_sort.hmp.txt, test.trait.txt, test_structure.sample5.txt, test_kinship.txt data are placed in the same file to generate test_mlm_file##
~/software/tassel-5-standalone$ perl run_pipeline.pl -fork1 -h test_sort.hmp.txt -fork2 -r test.trait.txt -fork3 -q test_structure.sample5.txt -excludeLastTrait -fork4 -k test_kinship.txt -combine5 -input1 -input2 -input3 -intersect -combine6 -input5 -input4 -mlm -mlmVarCompEst P3D -mlmCompressionLevel None -export test_mlm_ -runfork1 -runfork2 -runfork3

##CMLM correlation analysis, the required test_sort.hmp.txt, test.trait.txt, test_structure.sample5.txt, test_kinship.txt data are placed in the same file to generate test_cmlm_file##
~/software/tassel-5-standalone$ perl run_pipeline.pl -fork1 -h test_sort.hmp.txt -fork2 -r test.trait.txt -fork3 -q test_structure.sample5.txt -excludeLastTrait -fork4 -k test_kinship.txt -combine5 -input1 -input2 -input3 -intersect -combine6 -input5 -input4 -mlm -mlmVarCompEst P3D -mlmCompressionLevel Optimum -export test_cmlm_ -runfork1 -runfork2 -runfork3 -runfork4






############gwasResult View############
##Install R##
~$ sudo apt install r-base-core
##Enter R to enter the R language operating platform##
~$ R
##install software##
> install.packages("CMplot")
##View work path##
> getwd()
##Change working path##
> setwd(/home/minminli/software/tassel-5-standalone)
##Loading software##
> library(CMplot)

###glm
glm <- read.table("test_glm_1.txt", header = T, comment.char = "", stringsAsFactors = F, check.names = F)
traitID <- unique(glm$Trait)
for(tr in traitID){
outfile = paste0(tr, "_glm")
sub <- subset(glm, Trait == tr)[,c(2:4,6)]
CMplot(sub, threshold = 0.05, amplify = F, memo = outfile)
}


###mlm
mlm <- read.table("test_mlm_7.txt", header = T, comment.char = "", stringsAsFactors = F, check.names = F, fill = T)
traitID <- unique(mlm$Trait)
for(tr in traitID){
outfile = paste0(tr, "_mlm")
sub <- subset(mlm, Trait == tr)[,c(2:4,7)]
sub <- sub[-1,]
CMplot(sub, threshold = 0.05, amplify = F, memo = outfile)
}


###cmlm
cmlm <- read.table("test_cmlm_7.txt", header = T, comment.char = "", stringsAsFactors = F, check.names = F, fill = T)
traitID <- unique(cmlm$Trait)
for(tr in traitID){
outfile = paste0(tr, "_cmlm")
sub <- subset(cmlm, Trait == tr)[,c(2:4,7)]
sub <- sub[-1,]
CMplot(sub, threshold = 0.05, amplify = F, memo = outfile)
}


