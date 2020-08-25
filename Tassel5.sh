############Install java############


############Install tassel5############
~$ git clone https://bitbucket.org/tasseladmin/tassel-5-standalone.git
###########Put the tassel software in the tassel-5-standalone folder under the software folder of the main directory############
~$ cd tassel-5-standalone
############Sample files that come with the software/and your own data are stored in /home/minminli/software/tassel-5-standalone/TASSELTutorialData/data/ folder###### ######
~$ cd /home/minminli/software/tassel-5-standalone/TASSELTutorialData/data/


############Use tassel software to fill test.vcf with genotype to generate test.imputed.vcf#############
~/software/tassel-5-standalone$ perl run_pipeline.pl -Xms512m -Xmx5g -importGuess /home/minminli/tassel-5-standalone/TASSELTutorialData/data/test.vcf -LDKNNiImputationPlugin -highLDSSites 50 -knnTaxa 5 -maxLDDistance 100000000- endPlugin -export /home/minminli/tassel-5-standalone/TASSELTutorialData/data/test.imputed.vcf -exportType VCF


############tassel software does PCA analysis, test.imputed.vcf is placed in the same folder, and the first 3 principal components are generated, test_PCA.txt########### #
~/software/tassel-5-standalone$ perl run_pipeline.pl -fork1 -importGuess test.imputed.vcf -PrincipalComponentsPlugin -covariance true -endPlugin -export test_PCA.txt -runfork1


############tassel software does kinship analysis, test.imputed.vcf is placed in the same folder, and test_kinship.txt############
~/software/tassel-5-standalone$ perl run_pipeline.pl -importGuess test.imputed.vcf -KinshipPlugin -method Centered_IBS -endPlugin -export test_kinship.txt -exportType SqrMatrix

############tassel software generates hapmap format from vcf, and puts test.imputed.vcf in the same folder to generate test.hmp.txt############
~/software/tassel-5-standalone$ perl run_pipeline.pl -fork1 -vcf test.imputed.vcf -export test -exportType Hapmap -runfork1

############Sort the test.hmp.txt file SNP to generate test_sort.hmp.txt############
~/software/tassel-5-standalone$ perl run_pipeline.pl -SortGenotypeFilePlugin -inputFile test.hmp.txt -outputFile test_sort -fileType Hapmap

###########GLM correlation analysis, the required test_sort.hmp.txt, test.trait.txt, test_structure.sample5.txt data are placed in the same file to generate test_glm_file#### ########
~/software/tassel-5-standalone$ perl run_pipeline.pl -fork1 -h test_sort.hmp.txt -fork2 -r test.trait.txt -fork3 -q test_structure.sample5.txt -excludeLastTrait -combine4 -input1 -input2- input3 -intersect -glm -export test_glm_ -runfork1 -runfork2 -runfork3

############MLM correlation analysis, the required test_sort.hmp.txt, test.trait.txt, test_structure.sample5.txt, test_kinship.txt data are placed in the same file to generate test_mlm_ file ############
~/software/tassel-5-standalone$ perl run_pipeline.pl -fork1 -h test_sort.hmp.txt -fork2 -r test.trait.txt -fork3 -q test_structure.sample5.txt -excludeLastTrait -fork4 -k test_kinship.txt -combine5 -input1 -input2 -input3 -intersect -combine6 -input5 -input4 -mlm -mlmVarCompEst P3D -mlmCompressionLevel None -export test_mlm_ -runfork1 -runfork2 -runfork3

############CMLM correlation analysis, the required test_sort.hmp.txt, test.trait.txt, test_structure.sample5.txt, test_kinship.txt data are placed in the same file to generate test_cmlm_ file ############
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
