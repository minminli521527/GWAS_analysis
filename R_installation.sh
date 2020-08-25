########1.R Language Installation########
#First enter R in the terminal, if not installed, run##
~$ sudo apt install r-base-core

##If there is an old version, uninstall the previous version##
~$ sudo apt remove r-base-core
##Second, add sources in /etc/apt/sources##
~$ sudo vi /etc/apt/sources
##Press i, edit, add the following command, press esc to exit, press:, wq!, save and exit##
deb https://cloud.r-project.org/bin/linux/ubuntu disco-cran35/
##Third，update source##
~$ sudo apt-get update
##四，Install R##
~$ sudo apt-get install r-base-dev

##After the installation is complete, enter R to enter the R language operating platform##
~$ R

##Enter the following command at the cursor to view the software package that comes with the R language##
> .packages(all.available=T)

To download other software packages, we can download them online by entering install.packages("package name").
