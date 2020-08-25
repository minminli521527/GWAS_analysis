
############Software download operation############
##Official website download compressed package http://software.genetics.ucla.edu/admixture/download.html##
~$ tar -zxvf /home/minminli/software installation package/admixture_linux-1.3.0.tar.gz -C /home/minminli/software/admixture
~$ cd /home/minminli/software/admixture/admixture_linux-1.3.0
##Run admixture##
~/software/admixture/admixture_linux-1.3.0$ ./admixture


############data processing############
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




