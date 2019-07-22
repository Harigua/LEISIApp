# LEISIApp

## About us
Lesionia is an open-source software/Web applications for the collection, management and analysis of clinical and epidemiological data related to patients suspected for cutaneous leishmaniasis (CL). It was initially conceived and developed in the frame of the PEER518 project, funded by the USAID-NAS. It is meant to enable researchers within the project consortium to enter and access the data with respect to the FAIR criteria. It offers a remote and secured access via a web-based interface to all users that are based in different countries and acting at different stages of the data life cycle. Lesionia can be useful for researchers working on CL cases and who need a data management system for their research activities. The system can easily be tuned to be used for other diseases correlated to cutaneous lesions.

### Requirements:
- LEMP software stack (i.e. a variation on the LAMP software bundle that uses Nginx rather than Apache, also known as LNMP : Linux Nginx MySql Php)
- R (why not Rstudio or any other R IDE)
- Shiny and Shiny-server
- Basic knowledge of linux command lines 

#### Installation using Rstudio (graphical mode) suitable for both Linux and Windows [Coming soon]

- Set up the DataBase with either wampServer(Window, Apache, MySql, Php) see [here](http://www.wampserver.com/en/) or with EasyPHP see [here](https://www.easyphp.org/)
- Go to [127.0.0.1/phpmyadmin](127.0.0.1/phpmyadmin) in your browser and create a new DataBase
- Import [db.sql](https://github.com/Harigua/LEISIApp/blob/master/db.sql) in your MySql Database.
- Install ODBC drivers and create DSN configuration from [here](https://web.synametrics.com/mysql.htm) like this
![screenshot](https://github.com/Harigua/LEISIApp/blob/master/Screenshot%20from%202019-07-10%2010-03-08(1).jpg)
- Installing R and RStudio [here](https://www.datacamp.com/community/tutorials/installing-R-windows-mac-ubuntu)
- Two possible ways to get the project on your computer :
  1. With Git (Recommended but requires Git to be installed and a git account):
     - First make sure that you download Git see [here](https://git-scm.com/download/win) and your account is set as an enviourment variable if not the next steps will not work [see](http://www.geo.uzh.ch/microsite/reproducible_research/post/rr-rstudio-git/) .
     - In RStudio go to File>New Project>VersionControl>Git
     - Choose location and paste the repository URL [https://github.com/Harigua/LEISIApp.git](https://github.com/Harigua/LEISIApp.git)
     - Create Project 
     - A prompt will ask you to connect to your git account 
  2. With zip file download :
     - Download the application as a zip file from [https://github.com/Harigua/LEISIApp.git](https://github.com/Harigua/LEISIApp.git)
     - Extract the files 
     - Double click on the LEISIApp(.Rproj) R project
- An alert warning with a one click Install packages will appear (for both ui.R and server.R) if you have any trouble try installing them manually see section 8 of “Installation using command-lines under Ubuntu 16.04.”
- Run the app with the runApp button or with shiny::runApp() in the R Console
- If a “there is no package called ‘packageName’ ” error occurred try installing them with “install.packages("packageName")” or see section 8 of “Installation using command-lines under Ubuntu 16.04.”


#### Installation using command-lines under Ubuntu 16.04. This section also includes the R packages and their dependencies

1. Supposing that you have a linux base OS (you can Download UBUNTU 16.04 from [here](http://releases.ubuntu.com/16.04/)).
2. Setting up MySql from [here](https://linuxize.com/series/how-to-install-lemp-stack-on-ubuntu-18-04/).
3. Installing PhpMyAdmin with nginx [here](https://linuxize.com/post/how-to-install-phpmyadmin-with-nginx-on-ubuntu-18-04/) & [here](https://www.digitalocean.com/community/questions/phpmyadmin-got-404-not-found-error-on-nginx-ubuntu-16-04).
4. Don't forget `sudo ufw allow 'Nginx Full'` and `sudo ufw enable`
5. Install R `sudo apt-get install r-base-core r-base-dev`
   - [Optional] Install your favorite R ide (for RStudio see [here](https://www.rstudio.com/products/rstudio/download/)).
6. Installing Linux librarys `sudo apt-get install libcurl4-openssl-dev libssl-dev libv8-dev libxml2-dev  libcairo2-dev libpoppler-cpp-dev libwebp-dev libxt-dev libgtk2.0-dev libcairo2-dev xvfb xauth xfonts-base libpq-dev unixodbc-dev  libudunits2-dev libtiff5-dev libfftw3-dev`
7. Adding repositories 
   ```
   sudo add-apt-repository ppa:marutter/c2d4u3.5
   sudo add-apt-repository ppa:marutter/rrutter
   sudo apt update
   sudo apt full-upgrade
   ```
8. Installing the R packages 
   ```
   library(remotes) 
   install_version("car", "3.0-2") 
   install_version('caret','6.0-80') 
   source("http://bioconductor.org/biocLite.R") 
   install.packages("tiff","fftwtools") 
   biocLite("EBImage")
   install.packages(c("Hmisc","RODBC","RODBCext","DT","ggplot2","zoo","V8","googleVis","cluster","wordcloud","lubridate","multcompView","dygraphs","forecast","GGally","plotly","sqldf","ggmap","labelled","RColorBrewer","ade4", "caret", "doBy", "factoextra", "FactoMineR", "ggdendro","shiny", "shinyjs", "shinydashboard","tm")) 
   ```
   > Please note that if a package is outdated could not install with install.packages("package_name") 
   you should use install_version("package_name", "version_number") or simply go to [section 6 of this answer](https://stackoverflow.com/questions/25721884/how-should-i-deal-with-package-xxx-is-not-available-for-r-version-x-y-z-wa/31293955)
   Or [this answer](https://stackoverflow.com/questions/37222603/i-want-to-use-ebimage-package-but-it-says-it-is-not-available-for-my-version-of)
9. ODBC DSN Config file
   - Download libmyodbc8a.so from [here](https://dev.mysql.com/downloads/connector/odbc/)
   and place it in **/usr/lib/x86_64-linux-gnu/odbc/**
   - In **/etc/odbc.ini** write
   ```
   [MyAppDB]
   Description = ODBC connection to a database
   Driver = /usr/lib/x86_64-linux-gnu/odbc/libmyodbc8a.so
   Database =  #the name your database
   Server = localhost #the name your database server localhost if you are using a local database as shown in this file
   User = "" #the uid your database privileged user
   Password = "" #it’s password 
   Port = 3838 #the port number 3838
   ```
10. Setting up ShinyServer with Nginx see [here](https://www.digitalocean.com/community/tutorials/how-to-set-up-shiny-server-on-ubuntu-16-04).
    - Set the following configuration in **/etc/shiny-server/shiny-server.conf**
      ```
      # Instruct Shiny Server to run applications as the user "shiny"
      #run_as shiny;
      run_as :HOME_USER: ; # if :HOME_USER: does not work try your username
      
      #websocket error
      app_init_timeout 1800;
      app_idle_timeout 1800;
      http_keepalive_timeout 1800;
      sockjs_heartbeat_delay 500;
      disable_websockets off;
      
      # Define a server that listens on port 3838
      server {
        listen 3838;
      
        # Define a location at the base URL
        location / {
      
          # Host the directory of Shiny Apps stored in this directory
          site_dir /srv/shiny-server;
      
          # Log all Shiny output to files in this directory
          log_dir /var/log/shiny-server;
      
          # When a user visits the base URL rather than a particular application,
          # an index of the applications available in this directory will be shown.
          directory_index on;
        
      }
      ```
    - Restart shinyServer `sudo systemctl restart shiny-server.service`
#### Miscellaneous
#### Citing Lesionia
If you have used Lesionia or parts of it in the course of your research, 
we ask that you cite us as follows:
XXXXXXX

