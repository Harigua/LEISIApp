library(readr)
world <- read_delim("www/country_list.csv",  ";", escape_double = FALSE, trim_ws = TRUE)
cities <- read_delim("www/worldcities.csv",  ",", escape_double = FALSE, trim_ws = TRUE)[,c('iso2','city','city')]
for(i in 1:nrow(cities)){
  cities[i,3] <-  paste(cities[i,1],cities[i,2], sep = ", ")
}
choice <- read_delim("www/choice.csv",  ";", escape_double = FALSE, trim_ws = TRUE)

library(Hmisc)
library(shiny)
library(shinyjs)
library(RODBC)
library(DT)
library(RODBCext)
library(zoo)
library(ggplot2)
library(ggdendro)
library(forecast)
library(caret)
library(GGally)
library(plotly)
library(ade4)
library(factoextra)
library(FactoMineR)
library(sqldf)
library(doBy)
library(ggmap)
library(labelled)
library(RColorBrewer)
library(cluster)
library(wordcloud)
library(tm)
library(EBImage)
library(lubridate)
library(multcompView)
library(dygraphs)
suppressPackageStartupMessages(library(googleVis))
library(V8)

Sys.setenv(NLS_LANG="FRENCH_FRANCE.UTF8")
connect=odbcConnect("InDev", uid='root', pwd='16souemna' , DBMSencoding = "UTF-8")
#connect=odbcConnect("MyAppDB", uid='root', pwd='16souemna', DBMSencoding = "UTF-8")
#connect=odbcConnect("MyAppDB_CIC", uid='root', pwd='16souemna', DBMSencoding = "UTF-8")

js.png <- '
shinyjs.exportPNG = function(params) {
var defaultParams = {
dygraph : null,
img : null,
userOptions : null,
}
params = shinyjs.getParams(params, defaultParams);

var image = document.getElementById(params.img);
Dygraph.Export.asPNG(params.dygraph, image);
}
'

shinyServer(function(input, output,session) {
  useShinyjs()
  extendShinyjs(text = js.png)
  includeScript('www/dygraph-extra.js')
  img(id = 'plot-static')
  datatestech=reactive({
    sqlQuery(connect,paste("SELECT * from molecularl_test"))
  })
  dataech=reactive({
    sqlQuery(connect,paste("SELECT * from sample"))
  })
  datainvv=reactive({
    sqlQuery(connect,paste("SELECT * from interrogator"))
  })
  addClass(selector = "body", class = "sidebar-collapse")
  output$tables=renderUI({
    taables=sqlTables(connect, errors = FALSE, as.is = TRUE,
                      catalog = NULL, schema = NULL, tableName = NULL,
                      tableType = NULL, literal = FALSE)
    selectInput("ttest", "",choices=taables[,3])
  })
  output$datainv=renderUI({
    selectInput("investcinn","Choose from list the investigator", choices= c("",as.character(datainvv()[,1])) , multiple=FALSE )
  })
  datas= reactive({
    sqlQuery(connect,paste("SELECT * from ",input$ttest))
  })
  output$datas= DT::renderDataTable ({
    DT::datatable(datas(), options = list(scrollX = TRUE,lengthMenu = c(5, 10,15) ,pageLength = 5))
  })
  output$sum= renderPrint ({
    summary(datas())
  })
  output$sum2= renderPrint ({
    summary(datas2())
  })
  observeEvent(input$subtosample, {
    output$addallo=renderUI({
      div(
        actionButton("addalliquot","Add alliquot"),
        actionLink("back","Go back"))
    })
    output$echnn=renderUI({
    })
  })

  #######################################################
  observeEvent(input$selecthome, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "acc2"
    updateTabItems(session, "tabs", newvalue)
  })

  #######################################################
  observeEvent(input$selectDatMang, {
    ############################################################################
    #                              Access to Super                             #
    ############################################################################
    security=sqlQuery(connect,paste("SELECT * from userdata"))
    security=security[which(security[,1]==USER$name),3]
    validate(
      need(security!="normal", "You have to be a super user to access")
    )
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "cleanD"
    updateTabItems(session, "tabs", newvalue)
  })

  ####################################################################
  observeEvent(input$selectDatAdd, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "OTD"
    updateTabItems(session, "tabs", newvalue)
  })

  ##############################################################
  observeEvent(input$selectDatView, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "VD"
    updateTabItems(session, "tabs", newvalue)
  })

  ################################################################
  observeEvent(input$selectDatAna, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "AnD"
    updateTabItems (session, "tabs", newvalue)
  })

  #####################################################################
  observeEvent(input$selectpub, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "UP"
    updateTabItems(session, "tabs", newvalue)
  })

  #########################################################################
  userdata=reactive({
    sqlQuery(connect,"SELECT * from userdata")
  })
  observeEvent(input$Sub, {
    observeEvent(input$title, {
      newvalue <- "acc2"
      updateTabItems(session, "tabs", newvalue)
    })
    valid=FALSE
    for(i in 1:length(userdata()[,1])) if ( input$user== userdata()[i,1] && input$pass==userdata()[i,2] ) valid=TRUE
    if (valid=="TRUE") updateTabItems(session, "tabs", "acc2")
  })
  observeEvent(input$toInvestigator, {
    newvalue <- "Add Interrogator"
    updateTabItems(session, "inputdata", newvalue)
  })
  observeEvent(input$toPatientp2, {
    newvalue <- "Add Patient"
    updateTabItems(session, "inputdata", newvalue)
  })
  observeEvent(input$toPatient, {
    newvalue <- "Add Patient"
    updateTabItems(session, "inputdata", newvalue)
  })
  observeEvent(input$addintertopat1, {
    newvalue <- "Add Patient"
    updateTabItems(session, "inputdata", newvalue)
  })
  observeEvent(input$addintertopat2, {
    newvalue <- "Add Patient"
    updateTabItems(session, "inputdata", newvalue)
  })
  observeEvent(input$addintertohost, {
    newvalue <- "Add Host"
    updateTabItems(session, "inputdata", newvalue)
  })
  observeEvent(input$toLesion, {
    newvalue <- "Lesion data"
    updateTabItems(session, "inputdata", newvalue)
  })
  observeEvent(input$interIntoinvest, {
    newvalue <- "Add Interrogator"
    updateTabItems(session, "inputdata", newvalue)
  })
  observeEvent(input$interIntoetab1, {
    newvalue <- "Add Institution"
    updateTabItems(session, "inputdata", newvalue)
  })
  observeEvent(input$interIntoetab2, {
    newvalue <- "Add Institution"
    updateTabItems(session, "inputdata", newvalue)
  })
  observeEvent(input$tosample, {
    newvalue <- "Sample data"
    updateTabItems(session, "inputdata", newvalue)
  })
  observeEvent(input$testtolesion, {
    newvalue <- "Lesion data"
    updateTabItems(session, "inputdata", newvalue)
  })
  observeEvent(input$testtoetab1, {
    newvalue <- "Add Institution"
    updateTabItems(session, "inputdata", newvalue)
  })
  observeEvent(input$testtoetab2, {
    newvalue <- "Add Institution"
    updateTabItems(session, "inputdata", newvalue)
  })
  observeEvent(input$treattopat1, {
    newvalue <- "Add Patient"
    updateTabItems(session, "inputdata", newvalue)
  })
  observeEvent(input$treattopat2, {
    newvalue <- "Add Patient"
    updateTabItems(session, "inputdata", newvalue)
  })
  observeEvent(input$movetopat1, {
    newvalue <- "Add Patient"
    updateTabItems(session, "inputdata", newvalue)
  })
  observeEvent(input$movetopat2, {
    newvalue <- "Add Patient"
    updateTabItems(session, "inputdata", newvalue)
  })
  observeEvent(input$movetoreg1, {
    newvalue <- "Add Region"
    updateTabItems(session, "inputdata", newvalue)
  })
  observeEvent(input$movetoreg2, {
    newvalue <- "Add Region"
    updateTabItems(session, "inputdata", newvalue)
  })
  output$value <- renderText({
    req(input$go)
    isolate(input$password)
  })
  ########################################
  USER <- reactiveValues(Logged = FALSE , session = session$user)
  PASSWORD=reactive({
    data.frame( sqlQuery(connect,"SELECT * from userdata"))
  })
  output$uiLogin <- renderUI({
    if (USER$Logged == FALSE) {
      wellPanel(
        column("", textInput("userName", "User Name:"),width = 4),
        column("", passwordInput("passwd", "Password:"),width = 4),
        br(),
        actionButton("Login", "Login"),
        br(),
        br(),
        if (USER$Logged == FALSE) {
          p(USER$pass,style="color:red;")
        },
        h3("Contact us :"),
        p("For more information on Lesionia and the data system management, please contact Dr. Emna HARIGUA at ",a("emna.harigua@pasteur.utm.tn")),
        p("please note : We will get back to you shortly, usually within 2-3 days.",style="color:gray;")
      )
    }
  })

  # Login info during session ----
  output$userPanel <- renderUI({
    if (USER$Logged == TRUE) {
      fluidRow(
        column(2,
               span("User: ", USER$name
                    #, style="color:blue"
               )
        ),
        column(1, actionLink("logout", "Logout"))
      )
    }
  })
  output$homenav=renderUI({
    if(USER$Logged==TRUE ){
      div(
        fluidRow(
          box(width = 2, status = "info",solidHeader = TRUE,
              column(3,  h3(actionLink("selectDatMang",strong("Data Management"),icon = icon("fa fa-american-sign-language-interpreting"))))
          ),
          box(width = 2, status = "info",solidHeader = TRUE,
              column(3,  h3(actionLink("selectDatAdd",strong("Data Entry"),icon = icon("list-alt"))))
          ),
          box(width = 2, status = "info",solidHeader = TRUE,
              column(3,  h3(actionLink("selectDatView",strong("Data Viewer") ,icon = icon("table"))))
          ),
          box(width = 2, status = "info",solidHeader = TRUE,
              column(3,  h3(actionLink("selectDatAna",strong("Data Analysor"),icon = icon("bar-chart-o"))))
          )
        )
      )
    }
  })

  # control login
  observeEvent(input$Login , {
    Username <- isolate(input$userName)
    Password <- isolate(input$passwd)
    Id.username <- which(PASSWORD()$LOGINUSER == Username)
    Id.password <- which(PASSWORD()$MOTDPASS    == Password)
    if (length(Id.username) > 0 & length(Id.password) > 0) {
      if (Id.username == Id.password) {
        USER$Logged <- TRUE
        USER$name <- Username
      }
    } else {
      USER$pass <- "User name or password failed!"
    }
  })

  # control logout
  observeEvent(input$logout , {
    USER$Logged <- FALSE
    USER$pass <- ""
  })

  ###############################################
  #### Add data ##############################
  output$Patient=renderUI({
    if(USER$Logged==TRUE ){
      h3("Hello in this section.")
      tabBox(
        id="inputdata",
        title = tagList( ""),
        width = 10,
        height = 4,
        tabPanel(h3(strong("Add Patient Data")),
                 id="formPR",
                 uiOutput("firsttimeID"),
                 uiOutput("patdataout"),
                 uiOutput("patennt"),
                 uiOutput("AdddSample"),
                 uiOutput("AdddTreatment"),
                 uiOutput("Adddcheckup"),
                 uiOutput("AdddRegion"),
                 uiOutput("alliquot")
        ),
        tabPanel(h3(strong("Diagnosis")),
                 id="formInsertDiagnos",
                 div(
                   id="formInsertDiagnos",
                   fluidRow(
                     box(width = 12, status = "info",solidHeader = TRUE,
                         p("feilds with asterisk(*) are mandatory", style = "color:red"),
                         selectInput("chemtest","Molecular test*",choices = c("",as.character(datatestech()[,1]))),
                         selectInput("labname","Laboratory*",choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT LABORATORY_NAME from laboratory")))$LABORATORY_NAME)))),
                         selectInput("sample","Sample*",choices = c("",as.character(dataech()[,1]))),
                         dateInput("dattest","Test date",value = "1900-01-01"),
                         textInput("quantity","DNA volume (in micoL)*","-1"),
                         selectInput("restest","Test result*",choices = c("N/A","+","-")),
                         selectInput("susSpec","Suspected Species*",choices = c("",c(as.character(data.frame(sqlQuery(connect,sprintf("SELECT SPECIES from leishmania_species")))$SPECIES))))
                     ),
                     actionButton("btnInsertDiognosis", "Submit Data",  class = "btn-primary"),
                     actionButton("editDiag", "Edit",  class = "btn-primary")
                   )
                 )
        ),
        tabPanel(h3(strong("Identified Species")),
                 fluidRow(
                   div(
                     id="formUpdateIdentifiedSpecies",
                     box(width = 7, status = "info",solidHeader = TRUE,
                         column("", selectInput("upsample","Choose Sample",choices = c("",as.character(dataech()[,1]))),width = 3),
                         tableOutput("testsDone")
                     ),
                     column("",selectInput("spece","Identified Species",choices =c("",c(as.character(data.frame(sqlQuery(connect,sprintf("SELECT SPECIES from leishmania_species")))$SPECIES)))),width = 3),

                     actionButton("btnUpdateIdentifiedSpecies","Update Leishmania species")
                   )
                 )
        ),
        tabPanel(h3(strong("Add Interrogator")),
                 fluidRow(
                   div(
                     shinyjs::useShinyjs(),
                     id="formAddInterrogator",
                     box(width = 12, status = "info",solidHeader = TRUE,
                         p("feilds with asterisk(*) are mandatory", style = "color:red"),

                         textInput("idInterrogator","Identity number*",  ""),
                         textInput("nameInterrogator","Last name*",""),
                         textInput("lastNameInterrogator","First name*",""),
                         selectInput("qualityInterrogator","Quality*",c("N/A","Doctor","Nurse","Researcher","Resident doctor","Technicien"))

                     ),
                     actionButton("btnAddInterrogator", "Submit Data",  class = "btn-primary"),
                     actionButton("editinterr", "Edit",  class = "btn-primary")
                   )
                 )
        ),
        tabPanel(h3(strong("Add laboratory")),
                 fluidRow(
                   div(
                     shinyjs::useShinyjs(),
                     id="formAddLab",
                     box(width = 12, status = "info",solidHeader = TRUE,
                         p("feilds with asterisk(*) are mandatory", style = "color:red"),

                         textInput("nameLab","Laboratory*",""),
                         selectInput("countryLab","Country*",choices = c("",world[,1]))

                     ),
                     actionButton("btnInsertLab", "Submit",  class = "btn-primary"),
                     actionButton("editlab", "Edit",  class = "btn-primary")
                   )
                 )
        ),
        tabPanel(h3(strong("Add Discrepancy")),
                 fluidRow(
                   div(
                     shinyjs::useShinyjs(),
                     id="formAddDiscrepancy",
                     box(width = 12, status = "info",solidHeader = TRUE,
                         p("feilds with asterisk(*) are mandatory", style = "color:red"),

                         selectInput("idPatientDisc","patient DB Code*",choices = c("",as.character(data.frame(sqlQuery(connect,sprintf("SELECT PATIENT_IDENTIFIER from patient")))$PATIENT_IDENTIFIER))),
                         uiOutput("idMedDiscrepancy"),

                         #textAreaInput("text_Disc", "Discrepancy*", height= "100px")
                         textInput("text_Disc", "Discrepancy*")

                     ),
                     actionButton("btnInsertDiscrepancy", "Submit",  class = "btn-primary")
                   )
                 )
        )
      )
    }else{  USER$Logged <- FALSE
    USER$pass <- ""
    newvalue <- "acc2"
    updateTabItems(session, "tabs", newvalue)
    addClass(selector = "body", class = "sidebar-collapse")}
  })
  output$idMedDiscrepancy=renderUI({
    selectInput("Med_check","date of medical checkup*",choices = c("",as.character(data.frame(sqlQuery(connect,sprintf( "SELECT `DATE_MED` from `medical_checkup` WHERE `PATIENT_IDENTIFIER`='%s'",paste(as.character(input$idPatientDisc)) )))$DATE_MED)))
  })
  observeEvent(input$btnInsertDiscrepancy , {
    queryInserDiscrepancy  <- paste0(
      "INSERT INTO discrepancy(idDiscrepancy,PATIENT_IDENTIFIER,DATE_MED,Description,user)
      VALUES ('",paste0(input$idPatientDisc),"/",input$Med_check,"','",input$idPatientDisc,"','",input$Med_check,"','",input$text_Disc,"','",USER$name,"') ")
    if (input$idPatientDisc==""){
      info("Error : Missing data patient DB code")
    }else if(input$Med_check==""){
      info("Error : Missing data Medical Checkup date")
    }else if(input$text_Disc ==""){
      info("Error : There is no Discrepancy without a text")
    }else{
      an.error.occured <- FALSE
      tryCatch( { sqlExecute(connect,query =  queryInserDiscrepancy)  }
                , error = function(e) {an.error.occured <<- TRUE}
      )
      if(an.error.occured){
        info("Error : inserting Discrepancy ")
      }else{
        info("Discrepancy  successfully added")
      }
    }
    shinyjs::reset("formAddDiscrepancy")
  })
  output$viewtable=renderUI({
    if(USER$Logged==TRUE ){
      fluidRow(
        box(width = 3, status = "info",solidHeader = TRUE,
            title = "Choose table to View",
            helpText(tags$b("This section enable you to see content of all tables of database  ")),
            tags$hr(),
            uiOutput("tables")
        ),
        box(width = 9, status = "info",solidHeader = FALSE,
            DT::dataTableOutput("datas")
        )
      )}else{  USER$Logged <- FALSE
      USER$pass <- ""
      newvalue <- "acc2"
      updateTabItems(session, "tabs", newvalue)
      addClass(selector = "body", class = "sidebar-collapse")}
  })
  output$map1=renderGvis ({
    if(USER$Logged==TRUE ){
      gvisGeoChart(world, locationvar="Country" ,"Estimated Population at Risk of CL",
                   options=list( projection="kavrayskiy-vii",
                                 colorAxis="{colors:['#CECEF6', '#06325A']}",
                                 backgroundColor="White",
                                 width=1075, height=400
                   )
      )
    }
  })
  output$map2=renderGvis ({
    if(USER$Logged==TRUE ){
      box(
        gvisGeoChart(mydata, locationvar="Country" ,colorvar="Score",
                     options=list(
                       projection="kavrayskiy-vii",
                       colorAxis="{colors:['white', 'blue']}",
                       backgroundColor="steelblue",
                       width=1000, height=200,region="145"
                     )
        )
      )
    }
  })
  output$adnlove=renderUI ({
    if(USER$Logged==FALSE ){
      tags$img(src="adnlove.png",width=150, height=490)
    }
  })
  output$wiw=renderUI ({
    if(USER$Logged==FALSE ){
      tags$img(src="wiw.png",width=800, height=450)
    }
  })
  output$ipt=renderUI ({
    if(USER$Logged==FALSE ){
      tags$img(src="logo-IPT.png",width=90, height=450)
    }
  })
  output$mail=renderUI({
    if(USER$Logged==FALSE ){
      div(
        column("", actionButton("mail", "About us ",width = 237
                                #,icon("paper-plane"), style="yellow: #fff; background-color: white ; border-color: #2e6da4"
        ),width = 3),br(),br()
      )
    }
  })
  observeEvent( input$mail, {
    output$mailcontent=renderUI({
      if(USER$Logged==FALSE  ){
        div(
          box( width = 16,status = "info",solidHeader = FALSE,
               id="mail",
               div(
                 box( width = 12,status = "info",solidHeader = TRUE,
                      h1("About us", align="center"),
                      h3("What is lesionia :"),
                      p("   Lesionia is an open-source software/Web applications for the collection, management and
                             analysis of clinical and epidemiological data related to patients with confirmed cutaneous
                             leishmaniasis and their negative controls. It was developed in the frame of the PEER518 project.
                             It is conceived to enable researchers within the PEER518 consortium that are based in different
                             countries and acting at different stages of the data life cycle to enter and access the data with
                             respect to the FAIR criteria.
                         "),
                      br(),
                      h3(" What is the PER518 project :"),
                      p("  PER518: Diagnosis of Cutaneous Leishmaniasis: Development
                            and Evaluation of Multiplex POC DNA Assays. "),
                      p("  Objectives: Our aim is to develop species specific and multiplex DNA assays for the concomitant detection
                             and identification of the Leishmania species: L. infantum/L. donovani, L. major and L. tropica, which
                             are the main causal agents of cutaneous leishmaniasis encountered in the Old World (Africa, MENA,
                             Europe and Asia). Such diseases are also of global relevance in more than 98 countries
                             affected. "),
                      p("   Methodology: We use novel technologies for the isothermal amplification and detection of DNA
                             that are well adapted to point of care (POC) centres. They do not need specialized equipment,
                             are prone to multiplexing and are rapid in delivering results (<1h). "),
                      p("    Impact: Our DNA assays will serve the CL diagnosis in limited resources environment. In fact,
                             accurate species-specific diagnoses also allows for rapid diagnosis, efficient patient
                             management and follow up and accurate reporting to leishmaniasis control programs.
                             Availability of the diagnostics POC tools we aim for would change diagnosis algorithms and
                             improve patient management in Tunisia and many endemic countries, and in travel medicine. It
                             is also well known that the species differently react to the different treatments available. So far
                             reporting does not precise the causal species, so enlarged use of such tools would improve
                             disease epidemiology and burden estimates. Likewise, with more popular DNA tests it becomes
                             possible to adequately and timely react in emerging foci. Clinical trials will be needed to improve
                             robustness of the recommendations. "),
                      br(),
                      h3("Who are we :"),
                     
                        p("  Laboratory of Molecular Epidemiology and Experimental Pathology at Institut Pasteur de Tunis
                             is the central node of the PEER518 consortium that includes partners from Tunisia (Hopital de
                             Farhat Hachad, Sousse and Hopital La Rabta, Tunis), Morocco (Institut Pasteur du MAroc),
                             Lebanon (Rafik el Hariri Hospital and Faculty of Public Health), Mali (Faculty of Medicine and
                             Odontostomatology, University of Bamako) and the USA (Infectious Disease Research Institute). "),
                      br(),
                      h3("How to collaborate :"),
                      p(" If you are interested in collaborating with us, please send an email to Dr. Ikram Guizani(",a("ikram.Guizani@pasteur.tn"),
                        ") and/or to Dr. Insaf Bel Hadj Ali (",a("insaf.belhadjali@pasteur.tn"),"), with the object: “Collaboration proposal on CL diagnosis”."),
                      br(),
                      h3("Get in touch :"),
                      p("  For more information on Lesionia and the data system management, please contact Dr. Emna Hariga at ",a("emna.harigua@pasteur.utm.tn")),
                      p("  Lesionia was developed in collaboration with Mr. Maaoui Hariga ",a("harigamaaoui@gmail.com")," and Mr. Youssef Ben Salem ",a("bensalemyoussef70@gmail.com"),
                        "  The source code can be accessed and used on ",a(href="https://github.com/Harigua/LEISIApp","github") ),
                      br(),
                      p("please note : We will get back to you shortly, usually within 2-3 days. Also note that if you send an email on a Friday,
                        we may get back to you only on the following Monday or Tuesday.",style="color:gray;"),
                      p("If you are contacting us for a collaboration proposal please mention it in your message.",style="color:gray;"),
                      br()
                 ),
                 # column("", ,width = 12 ),
                 column("", actionButton("cancelmail","Cancel") ,width = 2 )
               )
          )
        )
      }
    })
  })
  observeEvent( input$cancelmail, {
    output$mailcontent=renderUI({
      if(USER$Logged==FALSE  ){}
    })
  })
  output$patdataout=renderUI ({
    if(paste(USER$name)=='super')
    {
      quer=sprintf("SELECT * from patient")
    }else{
      quer=sprintf("SELECT * from patient where LOGINUSER='%s'",paste(USER$name))
    }
    datpat=sqlQuery(connect,quer)
    if ( input$PatIdentifier %in% datpat[,1] ) {
      output$ViewTable=renderDataTable({
        A=datpat[which(datpat$PATIENT_IDENTIFIER==input$PatIdentifier),c(1,6:10)]
        DT::datatable(A, options = list(scrollX = TRUE,lengthMenu = c(1) ,pageLength = 1))
      })
      div(
        DT::dataTableOutput("ViewTable"),
        actionButton("btnInsertT_RInt","Travel/Residency"),
        actionButton("btnInsertCheckupInt","Add Medical check-UP"),
        actionButton("btnInsertTreatmenthistoryInt","Add Historical Treatment "),
        actionButton("btnInsertTreatmentInt","Add Treatment "),
        actionButton("btnInsertSampleInt","Add Sample "),
        actionButton("gotofirst","Quit")
      )
    } else{
        div(
          actionButton("addpatient","Add Patient"),
          actionButton("editpatient", "Edit Patient")
        )
    }
  })
  observeEvent( input$gotofirst, {
    output$firsttimeID=renderUI({
      textInput("PatIdentifier","Please Enter the Patient DB Code",placeholder = 'PPPLL****')
    })
    output$patdataout=renderUI ({
      datpat=sqlQuery(connect,paste("SELECT * from patient"))
      if ( input$PatIdentifier %in% datpat[,1] ) {
        output$ViewTable=renderDataTable({
          A=datpat[which(datpat$PATIENT_IDENTIFIER==input$PatIdentifier),c(1,6:8)]
          DT::datatable(A, options = list(scrollX = TRUE,lengthMenu = c(1) ,pageLength = 1))
        })
        div(
          DT::dataTableOutput("ViewTable"),
          actionButton("btnInsertT_RInt","Travel/Residency"),
          actionButton("btnInsertCheckupInt","Add Medical check-UP"),
          actionButton("btnInsertTreatmenthistoryInt","Add Historical Treatment "),
          actionButton("btnInsertTreatmentInt","Add Treatment "),
          actionButton("btnInsertSampleInt","Add Sample "),
          actionButton("gotofirst","Quit")
        )
      } else{
          div(
            actionButton("addpatient","Add Patient"),
            actionButton("editpatient", "Edit Patient")
          )
      }
    })
  })
  observeEvent( input$addpatient, {
    output$patennt=renderUI({
      output$firsttimeID=renderUI({
      })
      div(
        id="formInsertPatient",
        box(width = 12, status = "info",solidHeader = TRUE,
            p("feilds with asterisk(*) are mandatory", style = "color:red"),
            textInput("idPatient","Patient DB Code *",placeholder = 'PPPLL****'),
            textInput("medfilenumber","Patient ID",""),
            selectInput("ConsPat","Consentment", c("N/A","No","Yes","YES from IBA")), 
            dateInput("datenaissp","Birth date",value = "1900-01-01"), 
            numericInput("AgePatient","Or Age","-1"), 
            selectInput("nationalp","Nationality", c("N/A","other","TN","LB", "SY", "MA", "DZ")),
            textInput("othernationalp","If other please specify") ,                          
            selectInput("sexep","Gender", c("N/A","Other","Female","Male")),
            box(width = 12, status = "info",solidHeader = TRUE,
                selectInput("countryState_PA","Country and state of Residency (The last 6 months)*",choices = c('',cities[,3])),
                textInput("city_PA","City"), 
                selectInput("TypePA","Urban/Rural",choices =  c("N/A", "Urban","Rural")), 
                selectInput("bitePA","Bite Notion",choices =  c("N/A", "Yes","No"))
            )
        ),
        actionButton("btnInsertPatient","Submit"),
        actionButton("cansAdd","Cancel")
      )
    })
  })
  observeEvent( input$btnInsertPatient, {
    queryIpfe <- paste0(
      "INSERT INTO patient
      VALUES ('",toString(input$idPatient)  ,"','",toString(USER$name)  ,"', '",toString( input$medfilenumber) ,"','','','",toString( input$datenaissp) ,"','",toString( input$AgePatient) ,"','",if(toString( input$nationalp)=="other"){toString( toupper(input$othernationalp))}else{toString( input$nationalp)} ,"','",toString( input$sexep) ,"','",toString( input$ConsPat) ,"','') ")
    if (input$idPatient=="" || input$idPatient=="PPPLL****"){
      info("Error : Missing data Patient DB Id")
    }else{
      an.error.occured <- FALSE
      tryCatch( {sqlExecute(connect, queryIpfe)}
                , error = function(e) {an.error.occured <<- TRUE}
      )
      if(an.error.occured){
        info("Error : Patient already exists")
      }else{
        querySelectDataTR=sqlQuery(connect,paste("SELECT * from travel_residency"))
        querytravinpfe <- paste0(
          "INSERT INTO travel_residency(`IDMVT`, `CITY`, `LOGINUSER` ,`PATIENT_IDENTIFIER`, `FROMDATE`, `BYTENOT`, `RESIDENCY`,`TYPE`,`TODATE`)
      VALUES ('", toString(paste0(input$idPatient,"-",length(querySelectDataTR[,1])+1)) ,"', '",input$countryState_PA,", ",input$city_PA ,"', '",paste0(USER$name),"','",toString(input$idPatient),"', '",as.character( input$datenaissp )  ,"', '",toString( input$bitePA ) ,"', '",paste0( "Yes" ) ,"','",toString(input$TypePA),"','-1') ")
        tryCatch( {sqlExecute(connect, querytravinpfe)}
                  , error = function(e) {an.error.occured <<- TRUE}
        )
        if(an.error.occured){
          info("Error : INSERT INTO  travel_residency from patient")
        }
        info("Patient successfully stored")
      }
    }
    shinyjs::reset("formInsertPatient")
    output$firsttimeID=renderUI({
      textInput("PatIdentifier","Please Enter the Patient DB Code",placeholder = 'PPPLL****')
    })
    output$patennt=renderUI({
    })
  })
  output$firsttimeID=renderUI({
    textInput("PatIdentifier","Please Enter the Patient DB Code",placeholder = 'PPPLL****')
  })
  observeEvent( input$cansAdd, {
    output$firsttimeID=renderUI({
      textInput("PatIdentifier","Please Enter the Patient DB Code",placeholder = 'PPPLL****')
    })
    output$patennt=renderUI({
    })
  })
  observeEvent(input$btnInsertSampleInt, {
    output$AdddSample=renderUI({
      output$firsttimeID=renderUI({
      })
      output$patennt=renderUI({
      })
      output$patdataout=renderUI ({
      })
      div(
        id="formSample",
        box( width = 12, status = "info",solidHeader = TRUE,
             p("feilds with asterisk(*) are mandatory", style = "color:red"),
             selectInput("samplsupport","Type of sample support",choices = c("N/A","TE","Slide", "Filter paper","Saline","RNA later"),multiple = TRUE),
             selectInput("sammeth","Sampling Method",choices = c("N/A","Scrapping","aspiration","biopsy","Dental broch","Swab"),multiple = TRUE),
             selectInput("directexam","Direct examination result",choices = c("N/A","Positive","Negative")),
             selectInput("abandance","Abundance on the smear", c("N/A", "+","++","+++","++++","+++++","++++++")),
             dateInput("apparitionlesion","Lesion first appearence",value="1900-01-01") ,
             numericInput("Lesion_Age","Or leision age","-1") ,
             numericInput("diamlesionMax","lesion Diameter Maximal(millimeter)*","-1") ,
             numericInput("diamlesionMin","lesion Diameter Minimal(millimeter)*","-1") ,
             numericInput("highlesion","lesion Hight(millimeter)*","-1") ,
             # selectInput("locallesion","Lesion localisation*",choices = c("",-1,1:45),multiple = TRUE) ,
             selectInput("extractDay","Sampling date*",choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT DATE_MED from medical_checkup where PATIENT_IDENTIFIER = '%s'",as.character(input$PatIdentifier))))$DATE_MED))) ),
             selectizeInput("descriptionlesion","Lesion description",choices=c("","Ulcerative crusty","Dry","Wet","Surrounded by a hyperpigmented rim","Nodules pseudosporotrichoides","Pseudotumoral","Infected","Surrounded by a erythematouseruption","lupoid","Other","N/A"),multiple=TRUE) ,
             textInput("otherdescriptionlesion","If other please specify")
        ),
        actionButton("btnAddSampleAndQuit","Submit and Quit"),
        actionButton("btnUpImgInt","Upload Image"),
        actionButton("btnInsertAlliquotInt","Enter Aliquot data"),
        actionButton("btnAddSampleAndOther"," Submit and add other samples"),
        actionButton("btnUpdateSampleInt","Edit"),
        actionButton("cansAddinfo","Cancel")
      )
    })
  })
  observeEvent(input$btnInsertT_RInt, {
    output$AdddRegion=renderUI({
      output$firsttimeID=renderUI({
      })
      output$patennt=renderUI({
      })
      output$patdataout=renderUI ({
      })
      div(
        id="formInsertT_R",
        box(width = 12, status = "info",solidHeader = TRUE,
            p("feilds with asterisk(*) are mandatory", style = "color:red"),
            selectInput("regvisit","Country and state*",choices = c('',cities[,3])),
            textInput("regvisitc","City"),
            selectInput("Type","Urban/Rural",choices =  c("N/A",'+4','-30',"Urban","Rural")),
            selectInput("resedent","Residency ",choices =  c("N/A", "Yes","No")),
            selectInput("bybyte","Bite Notion",choices =  c("N/A", "Yes","No")),
            dateInput("datedatevisit","Visit Date*",value = data.frame(sqlQuery(connect,sprintf("SELECT 	BIRTH_DATE from patient where PATIENT_IDENTIFIER='%s'",as.character(input$PatIdentifier))))$BIRTH_DATE),
            textInput("dateleavevisit","Duration (In weeks, one year = 52 weeks)*","-1")
        ),
        actionButton("subregionQ","Submit and Quit"),
        actionButton("otherregionAdd"," Submit and add other regions"),
        actionButton("editregion","Edit"),
        actionButton("cansAddinfo","Cancel")
      )
    })
  })
  observeEvent(input$btnInsertTreatmentInt, {
    output$AdddTreatment=renderUI({
      output$firsttimeID=renderUI({
      })
      output$patennt=renderUI({
      })
      output$patdataout=renderUI ({
      })
      div(
        id="formInsertTreatment",
        box(width = 12, status = "info",solidHeader = TRUE,
            selectInput("treattype","Treatment type",choices = c("N/A","Other","Antibiotics","Glucantime","No treatment"),multiple = TRUE), 
            textInput("otherTreattype","If other please specify") ,  
            selectInput("prescribed","Prescribed for",choices = c("N/A","Other","Leishmania")), 
            textInput("otherPrescribed","If other please specify") ,
            dateInput("datetreatbeg","Treatment start date",value = "1900-01-01"), 
            textInput("datetreatend","Treatment Duration (in weeks, one year = 52 weeks)","-1"), 
            textInput("Posology","Posology",""), 
            textInput("admin","Administration Root",""),
            numericInput("injectionnumber","Number of injections* (for Glucantime)","-1")
        ),
        actionButton("subtreatmentQ","Submit and Quit"),
        actionButton("othertreatmentAdd"," Submit and Add Treatment"),
        actionButton("edittreatment","Edit"),
        actionButton("cansAddinfo","Cancel")
      )
    })
  })
  observeEvent(input$btnInsertTreatmenthistoryInt, {
    output$AdddTreatment=renderUI({
      output$firsttimeID=renderUI({
      })
      output$patennt=renderUI({
      })
      output$patdataout=renderUI ({
      })
      div(
        id="formInsertTreatmenthistory",
        box(width = 12, status = "info",solidHeader = TRUE,
            selectInput("treattype","historical Treatment type",choices = c("N/A","Other","Antibiotics","Glucantime","No treatment"),multiple = TRUE), 
            textInput("otherTreattype","If other please specify") , 
            selectInput("prescribed","Prescribed for",choices = c("N/A","Other","Leishmania")), 
            textInput("otherPrescribed","If other please specify") , 
            dateInput("datetreatbeg","Treatment start date",value = "1900-01-01"), 
            textInput("datetreatend","Treatment Duration (in weeks, one year = 52 weeks)","-1"), 
            textInput("Posology","Posology",""), 
            textInput("admin","Administration Root",""), 
            numericInput("injectionnumber","Number of injections* (for Glucantime)","-1")
        ),
        actionButton("subtreatmentQ","Submit and Quit"),
        actionButton("othertreatmentHistoryAdd"," Submit and Add Treatment"),
        actionButton("edittreatment","Edit"),
        actionButton("cansAddinfo","Cancel")
      )
    })
  })
  observeEvent(input$btnInsertCheckupInt , {
    output$Adddcheckup=renderUI({
      output$firsttimeID=renderUI({
      })
      output$patennt=renderUI({
      })
      output$patdataout=renderUI ({
      })
      div(
        id="formCh",
        box(width = 12, status = "info",solidHeader = TRUE,
            p("feilds with asterisk(*) are mandatory", style = "color:red"),
            selectInput("interrID","Interrogator ID",choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT ID_INTERROGATOR from interrogator")))$ID_INTERROGATOR)))),
            textInput("hospital","Hospital",""),
            textInput("pysicien","Physician",""),
            textInput("sampler","Sampler",""),
            dateInput("datecheck","Medical check-Up date",value = "1900-01-01"),
            selectizeInput("clinstate","Clinical State",choices =  c("N/A","Other","High blood pressure","Diabetes","Allergy","Pregnancy","Nothing to Report"), multiple = TRUE),
            textInput("otherClinstate","If other please specify") ,
            selectizeInput("HhostR","Surrounding human cases", c("N/A","No","Yes","Family","Neighbour","Colleague"), multiple = TRUE),
            selectizeInput("HhostL","Link with human cases", c("N/A","No","Other","Household","Neighborhood","Workplace","Travel"), multiple = TRUE),
            selectizeInput("Ahost","Possible animal contact", c("N/A","No","Other","Bovines","Ovins","Caprins","Camels","Equids","Hares","Cats","Dogs","Foxs","Other Canids","Sandrats","Meriones","Other rodents","Gondis","Hedgehogs","Bats","Hyrax","Cattle"), multiple = TRUE),
            textInput("otherAhost","If other please specify") ,
            numericInput("Lesion_Number","Number of Lesions*",value = "-1"),
            selectInput("Lesion_Sites","Lesion localisation",choices = c("N/A","Other","Face", "Upper limbs","Lower limbs","Trunc"),multiple = TRUE)
        ),
        actionButton("subchekupQ","Submit and Quit"),
        actionButton("othercheckAdd"," Submit and add other checkup"),
        actionButton("editmedcheck","Edit Checkup"),
        actionButton("cansAddinfo","Cancel")
      )
    })
  })
  observeEvent(input$cansAddinfo, {
    output$patdataout=renderUI ({
      div(
        DT::dataTableOutput("ViewTable"),
        actionButton("btnInsertT_RInt","Travel/Residency"),
        actionButton("btnInsertCheckupInt","Add Medical check-UP"),
        actionButton("btnInsertTreatmenthistoryInt","Add Historical Treatment "),
        actionButton("btnInsertTreatmentInt","Add Treatment "),
        actionButton("btnInsertSampleInt","Add Sample "),
        actionButton("gotofirst","Quit")
      )
    })
    output$Adddcheckup=renderUI({
    })
    output$AdddSample=renderUI({
    })
    output$AdddRegion=renderUI({
    })
    output$AdddTreatment=renderUI({
    })
  })
  observeEvent(input$othercheckAdd, {
    datacheck=sqlQuery(connect,paste("SELECT * from medical_checkup"))
    querycheckinpfe <- paste0(
      "INSERT INTO  medical_checkup
      VALUES ('", toString(paste0("Medical-check",length(datacheck[,1])+1)) ,"', '",toString( input$datecheck ) ,"','",toString(input$interrID)  ,"', '",toString( input$PatIdentifier) ,"','",toString( USER$name ) ,"','",toString( input$hospital) ,"', '",toString( input$pysicien ) ,"','",toString( input$sampler) ,"','",toString( input$Ahost) ,", ",toString(input$otherAhost),"','",toString( input$HhostR) ,"','",toString( input$HhostL) ,"','",toString( input$clinstate),", ",toString(input$otherClinstate),"','",toString( input$Lesion_Number) ,"','",toString(input$Lesion_Sites) ,"','N/A') ")
    if(is.na(input$Lesion_Number)){
      info("Error : Missing value Number of Lesions")
    }else if(input$Lesion_Number<(-1)){
      info("Error : Wrong value Number of Lesions")
    }else{
      an.error.occured <- FALSE
      tryCatch( {sqlExecute(connect,  querycheckinpfe)}
                , error = function(e) {an.error.occured <<- TRUE}
      )
      if(an.error.occured){
        info("Error : INSERT INTO  Medical checkUp")
      }else{info("Medical checkUp successfully added")}
    }
    shinyjs::reset("formCh")
  })
  observeEvent(input$subchekupQ, {
    datacheck=sqlQuery(connect,paste("SELECT * from medical_checkup"))
    querycheckinpfe <- paste0(
      "INSERT INTO  medical_checkup
      VALUES ('", toString(paste0(input$PatIdentifier,"-",length(datacheck[,1])+1)) ,"', '",toString( input$datecheck ) ,"','",toString(input$interrID)  ,"', '",toString( input$PatIdentifier) ,"','",toString( USER$name ) ,"','",toString( input$hospital) ,"', '",toString( input$pysicien ) ,"','",toString( input$sampler) ,"','",toString( input$Ahost) ,", ",toString(input$otherAhost),"','",toString( input$HhostR) ,"','",toString( input$HhostL) ,"','",toString( input$clinstate) ,", ",toString(input$otherClinstate),"','",input$Lesion_Number ,"','",toString(input$Lesion_Sites) ,"','N/A') ")
    if(is.na(input$Lesion_Number)){
      info("Error : Missing value Number of Lesions")
    }else if(input$Lesion_Number<(-1)){
      info("Error : Wrong value Number of Lesions")
    }else{
      an.error.occured <- FALSE
      tryCatch( {sqlExecute(connect,  querycheckinpfe)}
                , error = function(e) {an.error.occured <<- TRUE}
      )
      if(an.error.occured){
        info("Error : INSERT INTO  Medical checkUp")
      }else{info("Medical checkUp successfully added")}
    }
    output$patdataout=renderUI ({
      div(
        DT::dataTableOutput("ViewTable"),
        actionButton("btnInsertT_RInt","Travel/Residency"),
        actionButton("btnInsertCheckupInt","Add Medical check-UP"),
        actionButton("btnInsertTreatmenthistoryInt","Add Historical Treatment "),
        actionButton("btnInsertTreatmentInt","Add Treatment "),
        actionButton("btnInsertSampleInt","Add Sample "),
        actionButton("gotofirst","Quit")
      )
    })
    output$Adddcheckup=renderUI({
    })
    output$AdddSample=renderUI({
    })
    output$AdddRegion=renderUI({
    })
    output$AdddTreatment=renderUI({
    })
  })
  observeEvent(input$othertreatmentAdd, {
    datamytreatment2=sqlQuery(connect,paste("SELECT * from treatmenthistory"))
    querytreatpfe <- paste0(
      "INSERT INTO  treatmenthistory
      VALUES ( '", toString(paste0("Treatment",length(datamytreatment2[,1])+1)) ,"','", toString(input$PatIdentifier) ,"', '",toString( input$treattype),", ",toString( input$otherTreattype),"', '",if(toString( input$prescribed)=="other"){toString( input$otherPrescribed)}else{toString( input$prescribed)} ,"', '",as.character( input$datetreatbeg) ,"', '",toString( input$Posology) ,"', '",toString( input$admin) ,"','",input$injectionnumber ,"','",as.character( input$datetreatend) ,"','",as.character( input$healing) ,"') ")
    if(is.na(input$injectionnumber)){
      info("Error : Missing value Number of injections")
    }else if(input$injectionnumber<(-1)){
      info("Error : Wrong value Number of injections")
    }else{
      an.error.occured <- FALSE
      tryCatch( {sqlExecute(connect,querytreatpfe)}
                , error = function(e) {an.error.occured <<- TRUE}
      )
      if(an.error.occured){
        info("Error : INSERT INTO  treatmenthistory")
      }else{info("Treatment successfully stored")}
    }
    shinyjs::reset("formInsertTreatment")
  })
  observeEvent(input$othertreatmentHistoryAdd, {
    datamytreatment2=sqlQuery(connect,paste("SELECT * from treatmenthistory"))
    querytreatpfe <- paste0(
      "INSERT INTO  treatmenthistory
      VALUES ( '", toString(paste0("Treatment",length(datamytreatment2[,1])+1)) ,"','", toString(input$PatIdentifier) ,"', '",toString( input$treattype),", ",toString( input$otherTreattype),"', '",if(toString( input$prescribed)=="other"){toString( input$otherPrescribed)}else{toString( input$prescribed)} ,"', '",as.character( input$datetreatbeg) ,"', '",toString( input$Posology) ,"', '",toString( input$admin) ,"','",input$injectionnumber ,"','",as.character( input$datetreatend) ,"','",as.character( input$healing) ,"') ")
    if(is.na(input$injectionnumber)){
      info("Error : Missing value Number of injections")
    }else if(input$injectionnumber<(-1)){
      info("Error : Wrong value Number of injections")
    }else{
      an.error.occured <- FALSE
      tryCatch( {sqlExecute(connect,querytreatpfe)}
                , error = function(e) {an.error.occured <<- TRUE}
      )
      if(an.error.occured){
        info("Error : INSERT INTO  treatmenthistory")
      }else{info("Treatment successfully stored")}
    }
    shinyjs::reset("formInsertTreatmenthistory")
  })
  observeEvent(input$subtreatmentQ, {
    treatmenthistory=sqlQuery(connect,paste("SELECT * from treatmenthistory"))
    querytreatpfe <- paste0(
      "INSERT INTO  treatmenthistory
      VALUES ( '", toString(paste0("Treatment",length(treatmenthistory[,1])+1)) ,"','", toString(input$PatIdentifier) ,"', '",toString( input$treattype),", ",toString( input$otherTreattype),"', '",if(toString( input$prescribed)=="other"){toString( input$otherPrescribed)}else{toString( input$prescribed)} ,"', '",as.character( input$datetreatbeg) ,"', '",toString( input$Posology) ,"', '",toString( input$admin) ,"','",input$injectionnumber ,"','",as.character( input$datetreatend) ,"','",as.character( input$healing) ,"') ")
    if(is.na(input$injectionnumber)){
      info("Error : Missing value Number of injections")
    }else if(input$injectionnumber<(-1)){
      info("Error : Wrong value Number of injections")
    }else{
      an.error.occured <- FALSE
      tryCatch( {sqlExecute(connect,querytreatpfe)}
                , error = function(e) {an.error.occured <<- TRUE}
      )
      if(an.error.occured){
        info("Error : INSERT INTO  treatmenthistory")
      }else{info("Treatment successfully stored")}
    }
    shinyjs::reset("formInsertTreatment")
    output$patdataout=renderUI ({
      div(
        DT::dataTableOutput("ViewTable"),
        actionButton("btnInsertT_RInt","Travel/Residency"),
        actionButton("btnInsertCheckupInt","Add Medical check-UP"),
        actionButton("btnInsertTreatmenthistoryInt","Add Historical Treatment "),
        actionButton("btnInsertTreatmentInt","Add Treatment "),
        actionButton("btnInsertSampleInt","Add Sample "),
        actionButton("gotofirst","Quit")
      )
    })
    output$Adddcheckup=renderUI({
    })
    output$AdddSample=renderUI({
    })
    output$AdddRegion=renderUI({
    })
    output$AdddTreatment=renderUI({
    })
  })
  observeEvent(input$otherregionAdd, {
    querySelectDataTR=sqlQuery(connect,paste("SELECT * from travel_residency"))
    querytravinpfe <- paste0(
      "INSERT INTO  travel_residency(`IDMVT`, `CITY`, `LOGINUSER` ,`PATIENT_IDENTIFIER`, `FROMDATE`,`TODATE`, `BYTENOT`, `RESIDENCY`,`TYPE`)
      VALUES ('", toString(paste0(input$PatIdentifier,"-",length(querySelectDataTR[,1])+1)) ,"', '",input$regvisit,", ",input$regvisitc,"', '",paste0(USER$name),"','",toString(input$PatIdentifier),"', '",as.character( input$datedatevisit )  ,"', '",as.character( input$dateleavevisit )  ,"', '",toString( input$bybyte ) ,"', '",toString( input$resedent ) ,"', '",toString( input$Type ) ,"') ")
    if( as.character(input$regvisit) ==""){
      info("Error : Missing value Country and state")
    }else if( !(as.character(input$datedatevisit) <= Sys.Date()) && as.character(input$datedatevisit) ==""){
      info("Error : Incorrect date Visit Date")
    }else{
      an.error.occured <- FALSE
      tryCatch( {sqlExecute(connect, querytravinpfe)}
                , error = function(e) {an.error.occured <<- TRUE}
      )
      if(an.error.occured){
        info("Error : INSERT INTO  travel_residency")
      }else{
        info(" successfully added")
        shinyjs::reset("formInsertT_R")
      }
    }
  })
  observeEvent(input$subregionQ, {
    querySelectDataTR=sqlQuery(connect,paste("SELECT * from travel_residency"))
    querytravinpfe <- paste0(
      "INSERT INTO  travel_residency(`IDMVT`, `CITY`, `LOGINUSER` ,`PATIENT_IDENTIFIER`, `FROMDATE`,`TODATE`, `BYTENOT`, `RESIDENCY`,`TYPE`)
      VALUES ('", toString(paste0(input$PatIdentifier,"-",length(querySelectDataTR[,1])+1)) ,"', '",input$regvisit,", ",input$regvisitc,"', '",paste0(USER$name),"','",toString(input$PatIdentifier),"', '",as.character( input$datedatevisit )  ,"', '",as.character( input$dateleavevisit )  ,"', '",toString( input$bybyte ) ,"', '",toString( input$resedent ) ,"', '",toString( input$Type ) ,"') ")
    if( as.character(input$regvisit) ==""){
      info("Error : Missing value Country and state")
    }else if( !(as.character(input$datedatevisit) <= Sys.Date()) && as.character(input$datedatevisit) ==""){
      info("Error : Incorrect date Visit Date")
    }else{
      an.error.occured <- FALSE
      tryCatch( {sqlExecute(connect, querytravinpfe)}
                , error = function(e) {an.error.occured <<- TRUE}
      )
      if(an.error.occured){
        info("Error : INSERT INTO  travel_residency")
      }else{info(" successfully added")}
    }
    output$patdataout=renderUI ({
      div(
        DT::dataTableOutput("ViewTable"),
        actionButton("btnInsertT_RInt","Travel/Residency"),
        actionButton("btnInsertCheckupInt","Add Medical check-UP"),
        actionButton("btnInsertTreatmenthistoryInt","Add Historical Treatment "),
        actionButton("btnInsertTreatmentInt","Add Treatment "),
        actionButton("btnInsertSampleInt","Add Sample "),
        actionButton("gotofirst","Quit")
      )
    })
    output$Adddcheckup=renderUI({
    })
    output$AdddSample=renderUI({
    })
    output$AdddRegion=renderUI({
    })
    output$AdddTreatment=renderUI({
    })
  })
  observeEvent(input$btnAddSampleAndQuit, {
    querySelectDataSample=sqlQuery(connect,paste("SELECT  * from sample "))
    idSample <- paste0(input$PatIdentifier,"-",length(querySelectDataSample[,1])+1)
    queryInsertSample <- paste0(
      "INSERT INTO  sample
      VALUES ('", paste0(idSample) ,"', '",toString( input$PatIdentifier ) ,"', '",toString("NotIdentified") ,"', '",toString( USER$name ) ,"', '",toString( input$Lesionsite) ,"', '",toString( input$sammeth ) ,"','",toString( input$samplsupport) ,"','",toString( input$directexam) ,"','",toString( input$abandance) ,"','",toString( input$apparitionlesion) ,"','",toString( input$Lesion_Age) ,"','",input$diamlesionMax,"','",input$diamlesionMin,"','",input$highlesion,"','-1','",toString( input$descriptionlesion),",",toString(input$otherdescriptionlesion) ,"','",as.character( input$extractDay),"') ")
    if(toString(input$extractDay)==""){
      info("Error : Wrong value lesion Sampling date")
    }else if(is.na(input$diamlesionMax)){
      info("Error : Missing value lesion Diameter Maximal")
    }else if(input$diamlesionMax<(-1)){
      info("Error : Wrong value lesion Diameter Maximal")
    }else if(is.na(input$diamlesionMin)){
      info("Error : Missing value lesion Diameter Minimal")
    }else if(input$diamlesionMin<(-1)){
      info("Error : Wrong value lesion Diameter Minimal")
    }else if(is.na(input$highlesion)){
      info("Error : Missing value lesion Hight")
    }else if(input$highlesion<(-1)){
      info("Error : Wrong value lesion Hight")
    }else{
      an.error.occured <- FALSE
      tryCatch( {sqlExecute(connect,queryInsertSample)}
                , error = function(e) {an.error.occured <<- TRUE}
      )
      if(an.error.occured){
        info("Error : INSERT INTO  sample")
      }else{info(paste0("Sample successfully stored ", idSample))}
    }
    observe({updateSelectInput(session,"sample","",choices =  c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT ID_SAMPLE from sample where PATIENT_IDENTIFIER='%s'",paste(input$PatIdentifier))))$ID_SAMPLE))  )})
    output$patdataout=renderUI ({
      div(
        DT::dataTableOutput("ViewTable"),
        actionButton("btnInsertT_RInt","Travel/Residency"),
        actionButton("btnInsertCheckupInt","Add Medical check-UP"),
        actionButton("btnInsertTreatmenthistoryInt","Add Historical Treatment "),
        actionButton("btnInsertTreatmentInt","Add Treatment "),
        actionButton("btnInsertSampleInt","Add Sample "),
        actionButton("gotofirst","Quit")
      )
    })

    output$Adddcheckup=renderUI({
    })
    output$AdddSample=renderUI({
    })
    output$AdddTreatment=renderUI({
    })
    output$AdddRegion=renderUI({
    })
  })
  observeEvent(input$btnAddSampleAndOther, {
    querySelectDataSample=sqlQuery(connect,paste("SELECT * from sample "))
    idSample <- paste0(input$PatIdentifier,"-",length(querySelectDataSample[,1])+1)
    queryInsertSample <- paste0(
      "INSERT INTO  sample
      VALUES ('",paste0(paste0(input$PatIdentifier,"-",length(querySelectDataSample[,1])+1)),"', '",toString( input$PatIdentifier ) ,"', '",toString("NotIdentified") ,"', '",toString( USER$name ) ,"', 'N/A', '",toString( input$sammeth ) ,"','",toString( input$samplsupport) ,"','",toString( input$directexam) ,"','",toString( input$abandance) ,"','",toString( input$apparitionlesion) ,"','",toString(input$Lesion_Age) ,"','",input$diamlesionMax,"','",input$diamlesionMin,"','",input$highlesion,"','-1','",toString( input$descriptionlesion) ,",",toString(input$otherdescriptionlesion) ,"','",as.character( input$extractDay),"')  ")
    if(input$extractDay==""){
      info("Error : Wrong value lesion Sampling date")
    }else if(is.na(input$diamlesionMax)){
      info("Error : Missing value lesion Diameter Maximal")
    }else if(input$diamlesionMax<(-1)){
      info("Error : Wrong value lesion Diameter Maximal")
    }else if(is.na(input$diamlesionMin)){
      info("Error : Missing value lesion Diameter Minimal")
    }else if(input$diamlesionMin<(-1)){
      info("Error : Wrong value lesion Diameter Minimal")
    }else if(is.na(input$highlesion)){
      info("Error : Missing value lesion Hight")
    }else if(input$highlesion<(-1)){
      info("Error : Wrong value lesion Hight")
    }else{
      an.error.occured <- FALSE
      tryCatch( {sqlExecute(connect,queryInsertSample)}
                , error = function(e) {an.error.occured <<- TRUE}
      )
      if(an.error.occured){
        info("Error : INSERT INTO  sample")
      }else{info(paste0("Sample successfully stored",idSample))}
    }
    observe({updateSelectInput(session,"sample","",choices =  c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT ID_SAMPLE from sample where PATIENT_IDENTIFIER='%s'",paste(input$PatIdentifier))))[,"ID_SAMPLE"]))  )})
    output$AdddSample=renderUI({
      output$firsttimeID=renderUI({
      })
      output$patennt=renderUI({
      })
      output$patdataout=renderUI ({
      })
      div(
        box( width = 12, status = "info",solidHeader = TRUE,
              p("feilds with asterisk(*) are mandatory", style = "color:red"),
              selectInput("samplsupport","Type of sample support",choices = c("N/A","TE","Slide", "Filter paper","Saline","RNA later"),multiple = TRUE), 
              selectInput("sammeth","Sampling Method",choices = c("N/A","Scrapping","aspiration","biopsy","Dental broch","Swab"),multiple = TRUE), 
              selectInput("directexam","Direct examination result",choices = c("N/A","Positive","Negative")), 
              selectInput("abandance","Abundance on the smear", c("N/A", "+","++","+++","++++","+++++","++++++")), 
              dateInput("apparitionlesion","Lesion first appearence",value="1900-01-01") ,
              numericInput("Lesion_Age","Or leision age","-1") ,
              numericInput("diamlesionMax","lesion Diameter Maximal(millimeter)*","-1") , 
              numericInput("diamlesionMin","lesion Diameter Minimal(millimeter)*","-1") , 
              numericInput("highlesion","lesion Hight(millimeter)*","-1") , 
              # selectInput("locallesion","Lesion localisation*",choices = c("",-1,1:45)) , 
              selectInput("extractDay","Sampling date*",choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT DATE_MED from medical_checkup where PATIENT_IDENTIFIER = '%s'",as.character(input$PatIdentifier))))$DATE_MED))) ),
              selectizeInput("descriptionlesion","Lesion description",choices=c("N/A","Other","Ulcerative crusty","Dry","Wet","Surrounded by a hyperpigmented rim","Nodules pseudosporotrichoides","Pseudotumoral","Infected","Surrounded by a erythematouseruption","lupoid","Papulo-nodular"),multiple=TRUE) , 
              textInput("otherdescriptionlesion","If other please specify")
        ),
        actionButton("btnAddSampleAndQuit","Submit and Quit"),
        actionButton("btnUpImgInt","Upload Image"),
        actionButton("btnInsertAlliquotInt","Enter Aliquot data"),
        actionButton("btnAddSampleAndOther"," Submit and add other samples"),
        actionButton("btnUpdateSampleInt","Edit"),
        actionButton("cansAddinfo","Cancel")
      )
    })
  })
  observeEvent(input$btnAddInterrogator, {
    shinyjs::reset("formAddInterrogator")
  })
  observeEvent(input$btnAddInterrogator, {
    queryAddInterrogator <- paste0(
      "INSERT INTO  interrogator
      VALUES ('", input$idInterrogator ,"', '",toString( USER$name ) ,"', '",toString( input$nameInterrogator ) ,"', '",toString(input$lastNameInterrogator) ,"','",toString( input$qualityInterrogator) ,"') ")
    if(toString(input$idInterrogator)==""){
      info("Error : Missing data id interrogator")
    }else if(toString(input$nameInterrogator) == ""){
      info("Error : Missing data first name")
    }else if(toString(input$lastNameInterrogator) == ""){
      info("Error : Missing data last name")
    }else if(toString(input$qualityInterrogator) == ""){
      info("Error : Missing data quality")
    }else{
      an.error.occured <- FALSE
      tryCatch( {sqlExecute(connect,queryAddInterrogator)}
                , error = function(e) {an.error.occured <<- TRUE}
      )
      if(an.error.occured){
        info("Error : INSERT INTO Interrogator")
      }else{info("Interrogator successfully stored")}
    }
    updateSelectInput (session,"interrID",label="Interrogator ID",choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT ID_INTERROGATOR from interrogator")))$ID_INTERROGATOR))))
  })
  observeEvent(input$btnInsertDiognosis, {
    querySelectDataDiognosis=sqlQuery(connect,paste("SELECT * from diognosis"))
    queryInsertDiognosis <- paste0(
      "INSERT INTO  diognosis
      VALUES ( '", toString(paste0(input$PatIdentifier,"-",length(querySelectDataDiognosis[,1])+1)) ,"','",toString( input$chemtest ) ,"','", toString(input$labname) ,"','", toString(USER$name) ,"', '",toString(input$sample) ,"','",toString( input$dattest) ,"','",toString( input$quantity) ,"','",toString( input$restest) ,"','", toString(input$susSpec) ,"') ")
    if(toString(input$chemtest) == ""){
      info("Error : Missing data test")
    }else if(toString(input$labname)==""){
      info("Error : Missing data laboratory name")
    }else if(toString(input$sample)==""){
      info("Error : Missing data sample")
    }else if(toString(input$quantity)==""){
      info("Error : Missing data quantity")
    }else if(toString(input$restest) == ""){
      info("Error : Missing data result")
    }else if(toString(input$susSpec) == ""){
      info("Error : Missing suspected specie")
    }else{
      an.error.occured <- FALSE
      tryCatch( {sqlExecute(connect,queryInsertDiognosis)}
                , error = function(e) {an.error.occured <<- TRUE}
      )
      if(an.error.occured){
        info("Error : INSERT INTO Diagnosis ")
      }else{info("Diagnosis successfully added")}
    }
    shinyjs::reset("formInsertDiagnos")
  })
  observeEvent(input$btnInsertLab , {
    queryInsertLab <- paste0(
      "INSERT INTO laboratory
      VALUES ('", toString( input$nameLab ) ,"', '",toString( USER$name ) ,"', '",toString( input$countryLab ) ,"') ")

    if (input$nameLab==""){
      info("Error : Missing data laboratory name")
    }else if(input$countryLab==""){
      info("Error : Missing data country")
    }else{
      an.error.occured <- FALSE
      tryCatch( {sqlExecute(connect, queryInsertLab)}
                , error = function(e) {an.error.occured <<- TRUE}
      )
      if(an.error.occured){
        info("Error : laboratory already exists")
      }else{
        info("laboratory successfully added")
      }
    }
    shinyjs::reset("formAddLab")
    updateSelectInput(session,"labname","Laboratory",choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT LABORATORY_NAME from laboratory")))$LABORATORY_NAME))))
  })
  output$imgslide=renderUI({
    if (USER$Logged == FALSE) {
      includeHTML("www/style.css")
      includeHTML("www/imageslider.html")
    }
  })
  output$appkey=renderUI({
    if (USER$Logged == TRUE) {
      box(width =10 , status = "info",solidHeader = TRUE,
          div(
            fluidRow(
              box(width = 2, status = "info",solidHeader = TRUE,
                  column(3,  h5(actionLink("selecthome","Home page",icon = icon("list-alt"))))),
              box(width = 2, status = "info",solidHeader = TRUE,
                  column(3,  h5(actionLink("selectMang","Data Management",icon = icon("list-alt"))))),
              box(width = 2, status = "info",solidHeader = TRUE,
                  column(3,  h5(actionLink("selectDatAdd","Data Entry",icon = icon("list-alt"))))),
              box(width = 2, status = "info",solidHeader = TRUE,
                  column(3,  h5(actionLink("selectDatView","Data Viewer" ,icon = icon("table"))))),
              box(width = 2, status = "info",solidHeader = TRUE,
                  column(3,  h5(actionLink("selectDatAna","Data Analysor",icon = icon("bar-chart-o")))))
              #,
              # box(width = 2, status = "info",solidHeader = TRUE,
              #     column(3,  h5(actionLink("selectpub","Publication Consultor" ,icon = icon("refresh")))))
            )
          )
      )
    }
  })
  observeEvent(input$btnUpImgInt, {

    output$AdddSample=renderUI({
    })
    output$alliquot=renderUI({

      if (USER$Logged == TRUE) {
        div(
          id="FormUploadImage",
          box(width = 12, status = "info",solidHeader = TRUE,
              selectInput("sampleIDD","Sample",
                          choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT ID_SAMPLE from sample where PATIENT_IDENTIFIER='%s'",paste(input$PatIdentifier))))$ID_SAMPLE))
                          )),
              fileInput("MyImage","Image of lesion sampled",
                        accept = c('image/png','image/jpeg'))
          ),
          actionButton("btnUploadImage","Submit"),
          actionButton("cansAddalliquot","Cancel")
        )
      }
    })
  })
  observeEvent(input$btnUploadImage, {
    querySelectDataImg=sqlQuery(connect,paste("SELECT * from Img"))
    inFile  <- input$MyImage
    fileName  <- paste0(input$PatIdentifier,"_",input$sampleIDD,"_",length(querySelectDataImg)+1)
    queryInsertImg= paste0("INSERT INTO Img
                     VALUES ('",fileName,"','",input$PatIdentifier,"','",input$sampleIDD  ,"', '",USER$name ,"') ")
    if(is.null(inFile)){
      info("Error : NO IMAGE TO UPLOAD")
    }else if(input$sampleIDD==""){
      info("Error : Missing value Sample id")
    }else{
      an.error.occured <- FALSE
      tryCatch( {sqlExecute(connect,queryInsertImg)}
                , error = function(e) {an.error.occured <<- TRUE}
      )
      if(an.error.occured){
        info("Error : UPLOAD IMAGE ")
      }else{
        file.copy(inFile$datapath,file.path("./StoredImages",fileName))
        info("Image successfully stored")
      }
    }
  })
  observeEvent(input$btnInsertAlliquotInt, {
    output$AdddSample=renderUI({
    })
    output$alliquot=renderUI({
      if (USER$Logged == TRUE) {
        div(
          id="FormInsertAlliquotAndQuit",
          box(width = 12, status = "info",solidHeader = TRUE,
              selectInput("sampleIDD","Sample",
                          choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT ID_SAMPLE from sample where PATIENT_IDENTIFIER='%s'",paste(input$PatIdentifier))))$ID_SAMPLE))
                          ))
              ,
              numericInput("voll","Quantity in nanogramme","-1"),
              selectInput("val","Type",choices = c('N/A','+4','-30','Azote','R80')),
              selectInput("RakPFE","Container",choices = c('',1:4)),
              uiOutput("ttt"),
              selectInput("conserve","conserve",choices = c('N/A',"Boite")),
              selectInput("Position","Position",choices = c('',1:100))
          ),
          actionButton("btnInsertAlliquot","Submit"),
          actionButton("cansAddalliquot","Cancel")
        )
      }
    })
  })
  observeEvent(input$btnInsertAlliquot, {
    querySelectDataAlliquot=sqlQuery(connect,paste("SELECT * from alliquot"))
    queryInsertAlliquot= paste0("INSERT INTO alliquot
                     VALUES ('", toString(paste0(input$sampleIDD,"-",length(querySelectDataAlliquot)+1)) ,"','",toString(input$sampleIDD)  ,"', '",toString( USER$name ) ,"','",input$voll,"','",toString(paste0( input$val, "/", input$RakPFE,"/", input$valL,"/", input$conserve,"/", input$Position))  ,"') ")
    if(input$sampleIDD==""){
      info("Error : Missing value Sample id")
    }else if(is.na(input$voll)){
      info("Error : Missing value Quantity")
    }else if(input$voll<(-1)){
      info("Error : Wrong value Quantity")
    }else{
      an.error.occured <- FALSE
      tryCatch( {sqlExecute(connect,queryInsertAlliquot)}
                , error = function(e) {an.error.occured <<- TRUE}
      )
      if(an.error.occured){
        info("Error : INSERT INTO alliquit ")
      }else{info("Aliquot successfully stored")}
    }
  })
  observeEvent(input$cansAddalliquot, {
    output$alliquot=renderUI({
    })
    output$AdddSample=renderUI({
      output$firsttimeID=renderUI({
      })
      output$patennt=renderUI({
      })
      output$patdataout=renderUI ({
      })
      div(
        id="formInsertSample",
        box( width = 12, status = "info",solidHeader = TRUE,
             p("feilds with asterisk(*) are mandatory", style = "color:red"),
             selectInput("samplsupport","Type of sample support",choices = c("N/A","TE","Slide", "Filter paper","Saline","RNA later"),multiple = TRUE),
             selectInput("sammeth","Sampling Method",choices = c("N/A","Scrapping","aspiration","biopsy","Dental broch","Swab"),multiple = TRUE),
             selectInput("directexam","Direct examination result",choices = c("N/A","Positive","Negative")),
             selectInput("abandance","Abundance on the smear", c("N/A", "+","++","+++","++++","+++++","++++++")),
             dateInput("apparitionlesion","Lesion first appearence",value="1900-01-01") ,
             numericInput("Lesion_Age","Or leision age","-1") ,
             numericInput("diamlesionMax","lesion Diameter Maximal(millimeter)*","-1") ,
             numericInput("diamlesionMin","lesion Diameter Minimal(millimeter)*","-1") ,
             numericInput("highlesion","lesion Hight(millimeter)*","-1") ,
             # selectInput("locallesion","Lesion localisation*",choices = c("",-1,1:45)) ,
             selectInput("extractDay","Sampling date*",choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT DATE_MED from medical_checkup where PATIENT_IDENTIFIER = '%s'",as.character(input$PatIdentifier))))$DATE_MED))) ),
             selectizeInput("descriptionlesion","Lesion description",choices=c("N/A","Other","Ulcerative crusty","Dry","Wet","Surrounded by a hyperpigmented rim","Nodules pseudosporotrichoides","Pseudotumoral","Infected","Surrounded by a erythematouseruption","lupoid","Populo modulaire"),multiple=TRUE) ,
             textInput("otherdescriptionlesion","If other please specify")
        ),
        actionButton("btnAddSampleAndQuit","Submit and Quit"),
        actionButton("btnUpImgInt","Upload Image"),
        actionButton("btnInsertAlliquotInt","Enter Aliquot data"),
        actionButton("btnAddSampleAndOther"," Submit and add other samples"),
        actionButton("btnUpdateSampleInt","Edit"),
        actionButton("cansAddinfo","Cancel")
      )
    })
  })
  output$visualisation=renderUI({
    if (USER$Logged == TRUE) {

        tabBox(
          id="viewdata",
          title = tagList( ""),
          width = 10,
          height = 4,
          tabPanel(h4(strong("Tables View")),
                   uiOutput("viewtable")
          ),
          tabPanel(h4(strong("Patients Calendar")),
                   div(htmlOutput("calendar"),
                       uiOutput("calendarDB")
                   )
          ),
          tabPanel(h4(strong("Monthly patients")),
                   dygraphOutput("monthview")
          ),
          tabPanel(h4(strong("Partition")),
                   uiOutput("PieChart")
          )
          #,
          #tabPanel(h4(strong("Patients map")),
          #         uiOutput("SpeciesMapView")
          #)
        )

    }else{ USER$Logged <- FALSE
      USER$pass <- ""
      newvalue <- "acc2"
      updateTabItems(session, "tabs", newvalue)
      addClass(selector = "body", class = "sidebar-collapse")
    }
  })
  output$tables2=renderUI({
    taables=sqlTables(connect, errors = FALSE, as.is = TRUE,
                      catalog = NULL, schema = NULL, tableName = NULL,
                      tableType = NULL, literal = FALSE)
    opt=taables[,3]
    cho=opt[c(2,3,5,6,8,10,12,13,15)]
    selectInput("ttest2", "",choices=cho)
  })
  datas2= reactive({
    sqlQuery(connect,paste("SELECT * from ",input$ttest2))
  })
  output$datas2= DT::renderDataTable ({
    DT::datatable(datas2(), options = list(scrollX = TRUE,lengthMenu = c(5, 10,15) ,pageLength = 5))
  })
  output$viewtable2=renderUI({
    if(USER$Logged==TRUE ){
      fluidRow(
        box(width = 3, status = "info",solidHeader = TRUE,
            title = "Choose table to View",
            helpText(tags$b("This section enable you to see content of all tables of data base  ")),
            tags$hr(),
            uiOutput("tables2")
        ),
        box(width = 7, status = "info",solidHeader = FALSE,
            DT::dataTableOutput("datas2")
        )
      )
    }else{  USER$Logged <- FALSE
      USER$pass <- ""
      newvalue <- "acc2"
      updateTabItems(session, "tabs", newvalue)
      addClass(selector = "body", class = "sidebar-collapse")
    }
  })
  output$monthview=renderDygraph({
    totalChUp=sqlQuery(connect,paste("SELECT * from medical_checkup"))
    TS=totalChUp[,"DATE_MED"]
    TS <- c(TS,seq(as.Date(TS[1]), as.Date(TS[length(TS)]), "month") )
    Month=as.yearmon(TS)
    PM=table(Month)
    number=as.data.frame( PM)
    number[,2]=number[,2]-1
    TSSD=zoo(number[,2],seq(as.Date(TS[1]),as.Date(TS[length(TS)]),by="month") )
    MVG=dygraph(TSSD)%>% dyOptions(stackedGraph = TRUE) %>% dyRangeSelector()
    MVG
  })
  output$monthview2=renderDygraph ({
    totalChUp2=sqlQuery(connect,paste("SELECT * from medical_checkup"))
    TS2=totalChUp2[,"DATE_MED"][which(totalChUp2$LOGINUSER==USER$name  )]
    TS2 <- c(TS2,seq(as.Date(TS2[1]), as.Date(TS2[length(TS2)]), "month") )
    Month2=as.yearmon(TS2)
    PM2=table(Month2)
    number2=as.data.frame( PM2)
    number2[,2]=number2[,2]-1
    TSSD2=zoo(number2[,2],seq(as.Date(TS2[1]),as.Date(TS2[length(TS2)]),by="month") )
    MVG2=dygraph(TSSD2) %>% dyOptions(stackedGraph = TRUE) %>% dyRangeSelector()
    MVG2
  })
  output$DataAnalysis=renderUI({
    if (USER$Logged == TRUE) {
      tabBox(
        id="viewdata",
        title = tagList( ""),
        width = 10,
        height = 4,
        tabPanel(h4(strong("General Statistics")),
                 uiOutput("Random")
        ),
        tabPanel(h4(strong("Correlation")),
                 uiOutput("CrossTablecor")
        ),
        tabPanel(h4(strong("Regression")),
                 uiOutput("Reg")
        ),
        tabPanel(h4(strong("ACM")),
                 fluidRow( div( uiOutput("CAMM") ) )
        )
      )
    }else{ USER$Logged <- FALSE
      USER$pass <- ""
      newvalue <- "acc2"
      updateTabItems(session, "tabs", newvalue)
      addClass(selector = "body", class = "sidebar-collapse")
    }
  })
  preddata=reactive({
    totalChUp2=sqlQuery(connect,paste("SELECT * from medical_checkup"))
    TS=totalChUp2[,"DATE_MED"]
    Month=as.yearmon(TS)
    monthCal=as.data.frame(table(Month))
    mod2=msts(monthCal$Freq ,seasonal.periods = c(12))
    model=auto.arima(mod2)
    fut= as.data.frame(predict(model,n.ahead = 12))
    fut$pred
  })
  output$Predicted=renderTable({
    preddataL=as.data.frame(preddata())
    colnames(preddataL)="Predicted_monthly_patients_number"
    preddataL
  })
  output$Timeseriesplot=renderDygraph({
    totalChUp2=sqlQuery(connect,paste("SELECT * from medical_checkup"))
    TSD=totalChUp2[,"DATE_MED"]
    TSD2=ts(preddata(),start =as.numeric(format(as.Date(TSD[length(TSD)], format="%Y/%m/%d"),"%Y"))+1,frequency = 12)
    dygraph(TSD2)%>% dyOptions(stackedGraph = TRUE) %>% dyRangeSelector()
  })

  ####################################################################################
  ##################                      PIE plot start                ##############
  ####################################################################################
  output$tableschartPIE=renderUI({
    taablesPIE=sqlTables(connect, errors = FALSE, as.is = TRUE,
                         catalog = NULL, schema = NULL, tableName = NULL,
                         tableType = NULL, literal = FALSE)
    selectInput("ttestPIE", "",choices=taablesPIE[,3])
  })
  output$nameschartPIE= renderUI({
    AAllPIE=sqlQuery(connect,paste("SELECT * from ",input$ttestPIE))
    is.fact10 <- sapply(AAllPIE, is.factor)
    AAllPIE=data.frame( AAllPIE[, is.fact10])
    selectInput("ttestPIEnames", "",choices=c(colnames(AAllPIE)))
  })
  output$pie=renderPlot({
    dataPIE=sqlQuery(connect,paste("SELECT * from ",input$ttestPIE))
    Levels=dataPIE[,input$ttestPIEnames]
    ggplot(dataPIE, aes(x = factor(1),fill =Levels )) + geom_bar(width = 1)+ coord_polar(theta = "y")
  })

  output$PieChart=renderUI({
    if(USER$Logged==TRUE ){
      fluidRow(
        box(width = 3, status = "info",solidHeader = TRUE,
            title = "Choose table to View",

            tags$hr(),
            uiOutput("tableschartPIE")
        ),
        box(width = 3, status = "info",solidHeader = TRUE,
            title = "Choose table to View",
            tags$hr(),
            uiOutput("nameschartPIE")
        ),
        box(width = 6, status = "info",solidHeader = FALSE,
            plotOutput("pie")
        )
      )
    }else{  USER$Logged <- FALSE
      USER$pass <- ""
      newvalue <- "acc2"
      updateTabItems(session, "tabs", newvalue)
      addClass(selector = "body", class = "sidebar-collapse")
    }
  })

  #############################################
  output$tableschartPIE2=renderUI({
    taablesPIE2=sqlTables(connect, errors = FALSE, as.is = TRUE,
                          catalog = NULL, schema = NULL, tableName = NULL,
                          tableType = NULL, literal = FALSE)
    selectInput("ttestPIE2", "",choices=taablesPIE2[c(1,3,4,10,8,6),3])
  })
  output$nameschartPIE2= renderUI({
    AAllPIE2=sqlQuery(connect,paste("SELECT * from ",input$ttestPIE2))
    is.fact11 <- sapply(AAllPIE2, is.factor)
    AAllPIE2=data.frame( AAllPIE2[, is.fact11])
    selectInput("ttestPIEnames2", "",choices=c(colnames(AAllPIE2)))
  })
  output$pie2=renderPlot({
    dataPIE2=sqlQuery(connect,paste("SELECT * from ",input$ttestPIE2))
    dataPIE2N=dataPIE2[c(which(dataPIE2$LOGINUSER== USER$name)),]
    Levels=dataPIE2N[,input$ttestPIEnames2]
    ggplot(dataPIE2N, aes(x = factor(1),fill =Levels )) + geom_bar(width = 1)+ coord_polar(theta = "y")
  })
  output$PieChart2=renderUI({
    if(USER$Logged==TRUE ){
      fluidRow(
        box(width = 3, status = "info",solidHeader = TRUE,
            title = "Choose table to View",

            tags$hr(),
            uiOutput("tableschartPIE2")
        ),
        box(width = 3, status = "info",solidHeader = TRUE,
            title = "Choose table to View",
            tags$hr(),
            uiOutput("nameschartPIE2")
        ),
        box(width = 6, status = "info",solidHeader = FALSE,
            plotOutput("pie2")
        )
      )
    }else{  USER$Logged <- FALSE
      USER$pass <- ""
      newvalue <- "acc2"
      updateTabItems(session, "tabs", newvalue)
      addClass(selector = "body", class = "sidebar-collapse")
    }
  })

  #############################################################################
  #calandar#
  #############################################################################
  output$calendar=renderGvis ({
    dateMed=as.data.frame( table( sqlQuery(connect,paste("SELECT 	DATE_MED from medical_checkup where year(DATE_MED) > year(date(now()) - date('6-00-00'))"))))
    dateMed$Var1=as.Date(dateMed$Var1)
    Cal <- gvisCalendar(dateMed,
                        datevar="Var1",
                        numvar="Freq",
                        options=list(
                          title="Daily Patients for the last five years",
                          height=850,
                          width=850,
                          calendar="{yearLabel: { fontName: 'Times-Roman',
                          fontSize: 32, color: '#1A8763', bold: true},
                          cellSize: 15,
                          cellColor: { stroke: 'red', strokeOpacity: 0.2 },
                          focusedCellColor: {stroke:'yellow'}}")
    )
  })

  ##########################################################################################
  #Species MAP#
  ##########################################################################################
  output$CountriesShopUI=renderUI({
    countrie= unique( sqlQuery(connect,paste("SELECT NATIONALITY FROM patient where NATIONALITY not in ('OTHER','Other','other','N/A','N/a','n/A','n/a')")))
    selectInput("countriesshop", "",choices=countrie$NATIONALITY)
  })
  output$especeUI=renderUI({
    espece= unique( sqlQuery(connect,paste("SELECT SPECIES from sample")))
    selectInput("especesshop", "",choices=espece$SPECIES)
  })

  output$SpeciesMAP=renderPlot ({
    #sam= sqlQuery(connect,paste("SELECT SPECIES,PATIENT_IDENTIFIER	 from sample"))
    #reg=sqlQuery(connect,paste("SELECT COUNTRY_,CITY	 from region"))
    #town=sqlQuery(connect,paste0("SELECT CITY,PATIENT_IDENTIFIER	 from travel_residency where CITY like '",input$countriesshop,",%'"))
    #regC=reg[which(reg[,"COUNTRY_"]== input$countriesshop) ,]
    Tab=sqlQuery(connect,paste0("select CITY,SPECIES from  sample as s, travel_residency as t
              	where   s.PATIENT_IDENTIFIER=t.PATIENT_IDENTIFIER
		and t.CITY like '",paste0(input$countriesshop),",%' and s.SPECIES='",paste0(input$especesshop),"' ") )
    #TabPl=Tab[which(Tab$CITY %in% regC$CITY),]
    #TabSl=TabPl[which(TabPl[,"SPECIES"]== input$especesshop),]
    TabSl=as.data.frame(Tab)
    testttttttt=summaryBy(SPECIES~.,data =TabSl, FUN = length )
    TabOl=as.data.frame(testttttttt)
    df2 <- data.frame(location = as.character(TabOl$CITY),
                      values = TabOl$SPECIES.length,
                      stringsAsFactors = FALSE)
    locs_geo <- geocode(df2$location)
    df2 <- cbind(df2, locs_geo)
    mapK <- get_map(location = input$countriesshop, zoom = 6)
    ggmap(mapK) +
      geom_point(data = df2, aes(x = lon, y = lat, size = values,colour = values))
  })

  output$SpeciesMapView=renderUI({
    if(USER$Logged==TRUE ){
      fluidRow(
        box(width = 3, status = "info",solidHeader = TRUE,
            title = "Choose Country",

            tags$hr(),
            uiOutput("CountriesShopUI")
        ),
        box(width = 3, status = "info",solidHeader = TRUE,
            title = "Choose Species",
            tags$hr(),
            uiOutput("especeUI")
        ),
        box(width = 6, status = "info",solidHeader = FALSE,
            plotOutput("SpeciesMAP")
        )
      )
    }else{  USER$Logged <- FALSE
      USER$pass <- ""
      newvalue <- "acc2"
      updateTabItems(session, "tabs", newvalue)
      addClass(selector = "body", class = "sidebar-collapse")
    }
  })

  ##############################################################################################
  # Correlation plot#
  ##############################################################################################
  cordata=reactive({
    cor1=sqlQuery(connect,paste("SELECT PATIENT_IDENTIFIER,BIRTH_DATE,NATIONALITY,GENDER, AGE from patient"))
    cor3=sqlQuery(connect,paste("SELECT * from sample"))
    cordataall=sqldf("select * from  cor3, cor1
                     where   cor3.PATIENT_IDENTIFIER=cor1.PATIENT_IDENTIFIER ")
    PAITIENT_AGE=as.numeric(cor1$AGE)
    Lesion_Age=as.numeric(cor3$Lesion_Age)
    datatot=data.frame(cordataall,PAITIENT_AGE,Lesion_Age)
    datatot$LOCALISATION=as.factor(datatot$LOCALISATION)
    datatot
  })
  output$corVarUI=renderUI({
    selectizeInput("corvarstoplot", label=h4("Choose and combine Variables,SPECIES is necessary"), selected = c("SPECIES","GENDER"),choices=c(colnames(cordata()[,-c(1,2,4,6,12:16,18,19)])),multiple=TRUE)
  })
  output$corrr=renderPlot ({
    Variables=c(input$corvarstoplot)
    ggpairs(cordata()[,Variables], mapping = aes(color = SPECIES) , title = "Crossed variables")
  })
  output$CrossTablecor=renderUI({
    if(USER$Logged==TRUE ){
      fluidRow(
        uiOutput("corVarUI"),
        plotOutput("corrr")
      )}else{  USER$Logged <- FALSE
      USER$pass <- ""
      newvalue <- "acc2"
      updateTabItems(session, "tabs", newvalue)
      addClass(selector = "body", class = "sidebar-collapse")}
  })

  #############################################################################
  #                                 ACM                                       #
  #############################################################################
  prepdata=reactive({
    Totlalacm1=cordata()#[,-c(1,2,4,6,12:16,18,19)]
    Age_Class <- cut(as.numeric(cordata()$PAITIENT_AGE), c(0,10,20,30,40,50,60,70,80,120),
                     labels = c("Moins de 10 ans","11-20 ans","21-30 ans","31-40 ans","41-50 ans","51-60 ans", "61-70ans","71-80 ans ","plus de 80 ans" ))
    Lesion_Age_Class <- cut(as.numeric(cordata()$Lesion_Age), c(0, 2, 4, 6, 8, 10, 12, 15),
                            labels = c("moins de deux semaines", "2 - 4 semaines ", "4 - 6 semaines","6 - 8 semaines",
                                       "8- 10 semaines","10 - 12 semaines", "plus de 3 mois"))
    is.fact1 <- sapply(Totlalacm1, is.factor)
    dataacm1=data.frame( Totlalacm1[, is.fact1],Age_Class,Lesion_Age_Class)
    droplevels(dataacm1)
  })
  output$acmvars=renderUI({
    vecs=colnames(prepdata())
    selectizeInput ("acmV",label = "Choose variables",choices = c("",vecs[vecs!="SPECIES"]) ,multiple=TRUE)
  })
  output$ACM0=renderPlot({
    acm20 <- dudi.acm(prepdata()[,c(input$acmV)], scannf = FALSE, nf = 5)
    scatterutil.eigen(acm20$eig,nf=3,box=T)
  })
  output$ACM1=renderPlot({
    acm21 <- dudi.acm(prepdata()[,c(input$acmV)], scannf = FALSE, nf = 5)
    s.label(acm21$co,clabel = 0.7)
  })
  output$ACM2=renderPlot({
    acm22 <- dudi.acm(prepdata()[,c(input$acmV)], scannf = FALSE, nf = 5)
    s.class(acm22$li, prepdata()$SPECIES, col = brewer.pal(4, "Set1"))
  })
  output$CAMM=renderUI({
    if(USER$Logged==TRUE ){
      div( box(width = 12, height = 560, status = "info",solidHeader = FALSE,
               div(  tabBox(
                 id="acmall",
                 title = tagList( ""),
                 width = 12,
                 height = 2,
                 tabPanel(h5(strong("Eigen values")),
                          box(width = 12,
                              uiOutput("acmvars"),
                              plotOutput("ACM0" )
                          )
                 ),
                 tabPanel(h5(strong(" Distribution of Modalities")),
                          plotOutput("ACM1")
                 ),
                 tabPanel(h5(strong("Individuels map")),
                          plotOutput("ACM2")
                 ),
                 tabPanel(h5(strong("Clustring")),
                          plotOutput("clusr")
                 )
               ))
      ))
    }else{  USER$Logged <- FALSE
      USER$pass <- ""
      newvalue <- "acc2"
      updateTabItems(session, "tabs", newvalue)
      addClass(selector = "body", class = "sidebar-collapse")
    }
  })

  ###################################################################################
  #                               Relation variables                                #
  ###################################################################################
  prepdataNumeric=reactive({
    Totlal=cordata()
    is.num1 <- sapply(Totlal, is.numeric)
    data.frame( Totlal[, is.num1])
  })
  output$quanti1=renderUI({
    selectInput("quanti11",label = "Choose first variable",choices = c("",colnames(prepdataNumeric())))
  })
  output$quanti2=renderUI({
    selectInput("quanti12",label = "Choose Second variable",choices = c("",colnames(prepdataNumeric())))
  })
  output$quanti3=renderUI({
    selectInput("quanti13",label = "Choose first variable",choices = c("",colnames(prepdataNumeric())))
  })
  output$quali1=renderUI({
    selectInput("quali11",label = "Choose Second variable",choices = c("",colnames(prepdata())))
  })
  output$quali2=renderUI({
    selectInput("quali12",label = "Choose first variable",choices = c("",colnames(prepdata())))
  })
  output$quali3=renderUI({
    selectInput("quali13",label = "Choose Second variable",choices = c("",colnames(prepdata())))
  })
  output$resCor1= renderPrint({
    attach(prepdataNumeric())
    first=prepdataNumeric()[,input$quanti11]
    second=prepdataNumeric()[,input$quanti12]
    corrr1=data.frame(first,second)
    attach(corrr1)
    summary(l1 <- lm(corrr1[,1] ~ corrr1[,2]),    correlation=TRUE)
  })
  output$resCor2= renderTable ({
    attach(prepdataNumeric())
    attach(prepdata())
    first2=prepdataNumeric()[,input$quanti13]
    second2=prepdata()[,input$quali11]
    corrr2=data.frame(first2,second2)
    attach(corrr2)
    anov=data.frame(first2,second2)
    isolate(anova(lm(first2~second2,data = anov)))
  })
  output$resCor3= renderPrint({
    attach(prepdataNumeric())
    first3=prepdata()[,input$quali12]
    second3=prepdata()[,input$quali13]
    corrr3=data.frame(first3,second3)
    attach(corrr3)
    confus=table(corrr3[,1],corrr3[,2])
    chisq.test(confus, correct=TRUE)
  })
  output$Reg=renderUI({
    if(USER$Logged==TRUE ){
      fluidRow(
        tabBox(
          id="rlatall",
          title = tagList( ""),
          width = 11,
          height = 8,
          tabPanel(h5(strong("Linear Model")),
                   box(width = 3, status = "info",solidHeader = FALSE,
                       uiOutput("quanti1"),
                       uiOutput("quanti2")
                       ),
                   box(width = 8,status = "info",solidHeader = FALSE,
                       div( verbatimTextOutput("resCor1"))
                    )
          ),
          tabPanel(h5(strong("ANOVA")),
                   box(width = 3, status = "info",solidHeader = FALSE,
                       uiOutput("quanti3"),
                       uiOutput("quali1")),
                   box(width =9  , status = "info",solidHeader = TRUE,
                       tableOutput("resCor2")
                   ),
                   box(title = "Tukey HSD test", width =12 , status = "info",solidHeader = FALSE,
                       box(width = 3 , status = "info",solidHeader = FALSE,
                           verbatimTextOutput("platuk2")
                       ),
                       box(width =7 , status = "info",solidHeader = FALSE,
                           div( plotOutput ("platuk") )
                       )
                   )
          ),
          tabPanel(h5(strong("Chi square")),
                   box(width = 6, status = "info",solidHeader = FALSE,
                       uiOutput("quali2"),
                       uiOutput("quali3")
                       ),
                   htmlOutput("resCor3")
          )
        )
      )
    }else{  USER$Logged <- FALSE
      USER$pass <- ""
      newvalue <- "acc2"
      updateTabItems(session, "tabs", newvalue)
      addClass(selector = "body", class = "sidebar-collapse")
    }
  })
  output$platuk <- renderPlot({
    attach(prepdataNumeric())
    attach(prepdata())
    first20=prepdataNumeric()[,input$quanti13]
    second21=prepdata()[,input$quali11]
    corrr20=data.frame(first20,second21)
    attach(corrr20)
    aooov= aov(first20~second21,data = corrr20)
    tuk=TukeyHSD(aooov , conf.level=0.95)
    plot(tuk, las=1 , col="blue")
  })
  output$platuk2 <- renderPrint ({
    attach(prepdataNumeric())
    attach(prepdata())
    first20=prepdataNumeric()[,input$quanti13]
    second21=prepdata()[,input$quali11]
    corrr20=data.frame(first20,second21)
    attach(corrr20)
    aooov= aov(first20~second21,data = corrr20)
    tuk=TukeyHSD(aooov , conf.level=0.95)
    tuk$second21
  })

  #########################################################################################
  #                                     Clustering                                        #
  #########################################################################################
  output$clusr=renderPlot({
    acmclust <- dudi.acm(prepdata()[,c(input$acmV)], scannf = FALSE, nf = 5)
    d=dist(acmclust$li,method = "euclidean")
    h=hclust(d,"ward.D2")
    plot(h, labels= cordata()[,"ID_SAMPLE"] )
  })

  ###########################################################################################
  #                                            MOST parts                                   #
  ###########################################################################################
  output$NC=renderPlot({
    Nat_data=sqlQuery(connect,paste("SELECT NATIONALITY from patient"))$NATIONALITY
    Nat_table=as.data.frame(prop.table(table(Nat_data)))
    pie(Nat_table[,2] ,labels =paste(round(100*Nat_table[,2]/sum(Nat_table[,2]), 1),"%") , radius = 1 ,col = rainbow(length(Nat_table[,1])))
    legend("topright",legend=Nat_table[,1], cex = 0.8,fill = rainbow(length( Nat_table[,1])))
  })
  output$WC=renderPlot({
    Species_data=sqlQuery(connect,paste("SELECT SPECIES from sample"))$SPECIES
    Species_table=as.data.frame(prop.table(table(Species_data)))
    pie(Species_table[,2],labels =paste(round(100*Species_table[,2]/sum(Species_table[,2]), 1),"%"), radius = 1,col = rainbow(length(Species_table[,1])))
    legend("topright",legend=Species_table[,1], cex = 0.8,fill = rainbow(length( Species_table[,1])))
  })
  output$MC=renderPlot({
    age = sqlQuery(connect,paste("select AGE from patient"))$AGE
    hist(age, breaks=40 , col=rgb(0.2,0.8,0.5,0.5) , border=F , main="")
  })
  output$Random=renderUI({
    one2=sqlQuery(connect,paste("SELECT DATE_MED,PATIENT_IDENTIFIER from medical_checkup"))
    two2=sqlQuery(connect,paste("SELECT AGE,BIRTH_DATE,PATIENT_IDENTIFIER from patient"))
    three2= sqldf("select one2.PATIENT_IDENTIFIER,AGE,DATE_MED,BIRTH_DATE from  one2, two2
                  where   one2.PATIENT_IDENTIFIER=two2.PATIENT_IDENTIFIER ")
    age= round(as.numeric(as.Date(three2$DATE_MED) - as.Date(three2$BIRTH_DATE))/365)
for(p in 1:dim(three2)[1])
{
  if(is.null(three2[p,]$AGE) | is.na(three2[p,]$AGE) | three2[p,]$AGE==""){
    if(three2[p,]$BIRTH_DATE=="1900-01-01" | three2[p,]$DATE_MED=="1900-01-01"){
      updateQuery=paste0("update patient set AGE='-1' where PATIENT_IDENTIFIER='",three2[p,]$PATIENT_IDENTIFIER,"';")
    }else{
      updateQuery=paste0("update patient set AGE='",age[p],"' where PATIENT_IDENTIFIER='",three2[p,]$PATIENT_IDENTIFIER,"';")
    }
  }else if(as.numeric(three2[p,]$AGE) < 0){
    if(three2[p,]$BIRTH_DATE=="1900-01-01" | three2[p,]$DATE_MED=="1900-01-01"){
      updateQuery=paste0("update patient set AGE='-1' where PATIENT_IDENTIFIER='",three2[p,]$PATIENT_IDENTIFIER,"';")
    }else{
      updateQuery=paste0("update patient set AGE='",age[p],"' where PATIENT_IDENTIFIER='",three2[p,]$PATIENT_IDENTIFIER,"';")
    }
  }
    an.error.occured <- FALSE
    tryCatch( {sqlExecute(connect, updateQuery)}
              , error = function(e) {an.error.occured <<- TRUE}
    )
    if(an.error.occured){
      paste("Error in Update patient",p)
    }else{paste("Patient",p,"age successfully Updated",age[p])}
}
    one=sqlQuery(connect,paste("SELECT DATE_MED,PATIENT_IDENTIFIER from medical_checkup WHERE DATE_MED!='1900-01-01' "))
    two=sqlQuery(connect,paste("SELECT Date_First_Apeard,Lesion_Age,PATIENT_IDENTIFIER from sample WHERE Date_First_Apeard!='1900-01-01' "))
    three= sqldf("select one.PATIENT_IDENTIFIER,DATE_MED,Date_First_Apeard,Lesion_Age from  one, two
                 where   one.PATIENT_IDENTIFIER=two.PATIENT_IDENTIFIER ")
        days= round(as.numeric(as.Date(three$DATE_MED) - as.Date(three$Date_First_Apeard))/7)
for(la in 1:dim(three)[1])
{
  if(is.null(three2[p,]$AGE) | is.na(three2[p,]$AGE) | three2[p,]$AGE==""){
    if(three[la,]$Date_First_Apeard=="1900-01-01" | three[la,]$DATE_MED=="1900-01-01"){
      updateQuery=paste0("update sample set Lesion_Age='-1' where PATIENT_IDENTIFIER='",three[la,]$PATIENT_IDENTIFIER,"';")
    }else{
      updateQuery=paste0("update sample set Lesion_Age='",days[la],"' where PATIENT_IDENTIFIER='",three[la,]$PATIENT_IDENTIFIER,"';")
    }
  }else if(as.numeric(three[la,]$Lesion_Age) < 0){
    if(three[la,]$Date_First_Apeard=="1900-01-01" | three[la,]$DATE_MED=="1900-01-01"){
      updateQuery=paste0("update sample set Lesion_Age='-1' where PATIENT_IDENTIFIER='",three[la,]$PATIENT_IDENTIFIER,"';")
    }else{
      updateQuery=paste0("update sample set Lesion_Age='",days[la],"' where PATIENT_IDENTIFIER='",three[la,]$PATIENT_IDENTIFIER,"';")
    }
  }
    an.error.occured <- FALSE
    tryCatch( {sqlExecute(connect, updateQuery)}
              , error = function(e) {an.error.occured <<- TRUE}
    )
    if(an.error.occured){
      paste("Error in Update Lesion_Age")
    }else{paste("Lesion_Age successfully Updated")}
}
    days=sqlQuery(connect,paste("SELECT Lesion_Age from sample"))$Lesion_Age
    Lesion_Age_in_weeks <- cut(as.numeric(days), c(0, 2, 4, 6, 8, 10, 12, 14),
                               labels = c("< 2 weeks", "2 to 4  ", "4 to 6","6 to 8 ",
                                          "8 to 10 ","10 to 12 ", "more than 3 weeks"))
    if(USER$Logged==TRUE ){
      fluidRow(
        box(width=12, status = "info",solidHeader = FALSE,title = "Patient Age Distribution",
            plotOutput("MC")
        ),
        box(width=6, status = "info",solidHeader = FALSE,title="Patient nationality distribution",
            plotOutput("NC")
        ),
        box(width=6, status = "info",solidHeader = FALSE,title="Species distribution",
            plotOutput("WC")
        )
      )
    }else{  USER$Logged <- FALSE
      USER$pass <- ""
      newvalue <- "acc2"
      updateTabItems(session, "tabs", newvalue)
      addClass(selector = "body", class = "sidebar-collapse")
    }
  })

  ################################################################################################################
  #                                              data management                                                 #
  ################################################################################################################
  output$Managementall=renderUI({
    if(USER$Logged==TRUE ){
      if(paste(USER$name)=='super')
      {h3("Hello in this section.")
        tabBox(
          id="managedatatool",
          title = tagList(""),
          width = 30,
          height = 4,
          tabPanel(h5(strong("Users")),
                   id="formUser",
                   fluidRow (
                     div(
                       id="formUser",
                       box(title = "Add new user",width = 3,
                           uiOutput( "adduserFIN")
                       ),
                       box(title = "Delete user",width = 3,
                           uiOutput( "DeluserFIN")
                       ),
                       box(title = "Update existing user",width = 3,
                           uiOutput( "UpuserFIN")
                       )
                     )
                   )
          ),
          tabPanel(h5(strong("Delete row data")),
                   id="formCleaningtool",
                   fluidRow (
                     div(box(width = 3, status = "info",solidHeader = TRUE,
                             uiOutput("DatadelF666table"),
                             uiOutput("DatadelF666Fil"),
                             uiOutput("DatadelF666tableval"),
                             actionButton("DatadelDone","Delete")
                     ),
                     box(width = 8, status = "info",
                         DT::dataTableOutput("DatadelF666doooooon")
                     )
                     )
                   )
          ),
          tabPanel(h5(strong("Download data")),
                   id="formDownLoadtool",
                   fluidRow (
                     div(box(width = 3, status = "info",solidHeader = TRUE,
                             uiOutput("DataDowLF666table"),
                             uiOutput("DataDowLF666Fil"),
                             uiOutput("DataDowLF666value"),
                             textInput("naamebase","File name",""),
                             actionButton("DataLowLDone","Download"),
                             actionButton("DataLowLDoneAll","Download all table")
                     ),
                     box(width = 8, status = "info",
                         DT::dataTableOutput("DataDowLF666doooooon")
                     )
                     )
                   )
          ),
          tabPanel(h5(strong("View Discrepancys")),
                   id="ViewDiscrepancys",
                   fluidRow ( box(width = 8, status = "info",
                         DT::dataTableOutput("DataDiscrepancys")  )
                   )
          )
        )
      }else{info("ERROR :: Access Denied")}
    }else{ USER$Logged <- FALSE
      USER$pass <- ""
      newvalue <- "acc2"
      updateTabItems(session, "tabs", newvalue)
      addClass(selector = "body", class = "sidebar-collapse")
    }
  })
  output$adduserFIN=renderUI ({
    div(
      box(width = 10, status = "info",solidHeader = TRUE,
          textInput("userLogin","Create Login",""),
          textInput("userpass","Create Password",""),  
          selectInput("NivSec","Data access",choices =  c("normal", "super")),
          textInput("userIns","Institution",""),
          actionButton("subusernew","Submit user")
      )
    )
  })
  output$sel=renderUI({
    selectInput("userLoginF","Select user",choices=c("",as.character(data.frame( sqlQuery(connect,paste("SELECT * from userdata")))$LOGINUSER)))
  })
  output$UpuserFINav=renderUI ({
    div(
      box(width = 11, status = "info",solidHeader = TRUE,
          id="useraddid",
          textInput("userpassF","Change Password",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT * from userdata where LOGINUSER='%s'",paste(input$userLoginF))))$MOTDPASS))),
          selectInput("NivSecF","Choose access level",choices =  c("normal", "super")),
          textInput("userInsF","Change Institution",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT * from userdata where LOGINUSER='%s'",paste(input$userLoginF))))$FROMINST))),
          actionButton("subusernewUp","Update user data")
      )
    )
  })
  output$UpuserFIN=renderUI ({
    div(
      box(width = 10, status = "info",solidHeader = TRUE,
          uiOutput("sel"),
          uiOutput("UpuserFINav")
      )
    )
  })
  output$DeluserFIN=renderUI ({
    div(
      selectInput("Loguserdelete","Select user login",choices =  c(as.character(data.frame( sqlQuery(connect,paste("SELECT LOGINUSER from userdata")))$LOGINUSER))),
      actionButton("subuserDell","Delete user")
    )
  })

  ##########################################################
  #                         tables                         #
  ##########################################################
  output$DatadelF666table=renderUI ({
    taablesDel=sqlTables(connect, errors = FALSE, as.is = TRUE,
                         catalog = NULL, schema = NULL, tableName = NULL,
                         tableType = NULL, literal = FALSE)
    selectInput("tableNameDelete","Select Table",choices = taablesDel[,3]  )
  })
  output$DataDowLF666table=renderUI ({
    taablesDowL=sqlTables(connect, errors = FALSE, as.is = TRUE,
                          catalog = NULL, schema = NULL, tableName = NULL,
                          tableType = NULL, literal = FALSE)
    selectInput("tableNameDown","Select Table",choices =  taablesDowL[,3])

  })

  ##########################################################
  #                         Filters                        #
  ##########################################################
  output$DatadelF666Fil=renderUI ({
    AAllDel=sqlQuery(connect,paste("SELECT * from ",input$tableNameDelete))
    selectInput("filNameDelete","Select Filter",choices =  c(colnames(AAllDel)))
  })
  output$DataDowLF666Fil=renderUI ({
    AAllDowL=sqlQuery(connect,paste("SELECT * from ",input$tableNameDown))
    selectInput("filNameDown","Select Filter",choices =  c( colnames(AAllDowL) ))
  })

  #################################################################
  #                            Values                             #
  #################################################################
  output$DatadelF666tableval=renderUI ({
    AAllDel1=sqlQuery(connect,paste("SELECT * from ",input$tableNameDelete))
    AAllDel2=AAllDel1[,input$filNameDelete]
    selectInput("valNameDelete","Select Value",choices =  c( unique(as.character(AAllDel2) )))
  })
  output$DataDowLF666value=renderUI ({
    AAllDown1=sqlQuery(connect,paste("SELECT * from ",input$tableNameDown))
    AAllDown2=AAllDown1[,input$filNameDown]
    selectInput("valNameDown","Select Value",choices =  c(unique(as.character(AAllDown2))))
  })

  #################################################################
  #                            data results                       #
  #################################################################
  humDown=reactive({
    AAllDown1=sqlQuery(connect,paste("SELECT * from ",input$tableNameDown))
    AAllDown2=AAllDown1[which(AAllDown1[,input$filNameDown]==as.character(input$valNameDown)),]
    data.frame(AAllDown2)
  })
  humDownallall=reactive({
    sqlQuery(connect,paste("SELECT * from ",input$tableNameDown))
  })
  humDel=reactive({
    AAllDel1=sqlQuery(connect,paste("SELECT * from ",input$tableNameDelete))
    AAllDel2=AAllDel1[which(AAllDel1[,input$filNameDelete]==as.character(input$valNameDelete)),]
    data.frame(AAllDel2)
  })
  output$DataDiscrepancys=DT::renderDataTable ({
    DT::datatable(sqlQuery(connect,paste("SELECT * from discrepancy")), options = list(scrollX = TRUE,lengthMenu = c(5, 10,15) ,pageLength = 5))
  })
  output$DataDowLF666doooooon=DT::renderDataTable ({
    DT::datatable(humDown(), options = list(scrollX = TRUE,lengthMenu = c(5, 10,15) ,pageLength = 5))
  })
  output$DatadelF666doooooon=DT::renderDataTable({
    DT::datatable(humDel(), options = list(scrollX = TRUE,lengthMenu = c(5, 10,15) ,pageLength = 5))
  })
  #####################################################################################################
  #                                           button DELETE DATA                                      #
  #####################################################################################################
  observeEvent(input$subuserDell, {
    querydeleteuser <-sprintf("DELETE from userdata where LOGINUSER='%s'",paste(as.character(input$Loguserdelete)))
    sqlQuery(connect,querydeleteuser)
    info("User Deleted")
    observe({updateSelectInput(session,"Loguserdelete","",choices =  c(as.character(data.frame( sqlQuery(connect,paste("SELECT LOGINUSER from userdata")))$LOGINUSER))  )})
    observe({updateSelectInput(session,"userLoginF","",choices =  c("",as.character(data.frame( sqlQuery(connect,paste("SELECT * from userdata")))$LOGINUSER)))})
  })
  observeEvent(input$DatadelDone, {
    querydeleteuser <-sprintf("DELETE from %s where %s='%s'; ",paste(as.character(input$tableNameDelete)),paste(as.character(input$filNameDelete) )   ,paste(as.character(input$valNameDelete)))
    sqlQuery(connect,querydeleteuser)
    info("Data successfully Deleted")
    observe({
      AAllDel1=sqlQuery(connect,paste("SELECT * from ",input$tableNameDelete))
      AAllDel2=AAllDel1[,input$filNameDelete]
      updateSelectInput(session,"valNameDelete","",choices = c( unique(as.character(AAllDel2) ))  )
    })
  })

  #####################################################################################################
  #                                           button Download DATA                                      #
  #####################################################################################################
  observeEvent(input$DataLowLDone, {
    write.csv2( data.frame(humDown()),file =paste(as.character(input$naamebase),".csv"), fileEncoding = "UTF-16LE")
    info("Data successfully stored")
  })
  observeEvent(input$DataLowLDoneAll, {
    write.csv2( data.frame(humDownallall()),file =paste(as.character(input$naamebase),".csv"), fileEncoding = "UTF-16LE")
    info("Data successfully stored")
  })

  #####################################################################################################
  #                                                button add user                                    #
  #####################################################################################################
  observeEvent(input$subusernew, {
    queryuseraddpfe <- paste0(
      "INSERT INTO  userdata
      VALUES ('",as.character( input$userLogin ) ,"','",toString( USER$name ) ,"', '",as.character( input$userpass) ,"', '",as.character( input$NivSec ) ,"', '",as.character( input$userIns ) ,"') ")
    an.error.occured <- FALSE
    tryCatch( {sqlExecute(connect, queryuseraddpfe)}
              , error = function(e) {an.error.occured <<- TRUE}
    )
    if(an.error.occured){
      info("Error : Insert USER")
    }else{info("User successfully added")}
    shinyjs::reset("formUser")
    observe({updateSelectInput(session,"Loguserdelete","",choices =  c(as.character(data.frame( sqlQuery(connect,paste("SELECT LOGINUSER from userdata")))$LOGINUSER))  )})
    observe({updateSelectInput(session,"userLoginF","",choices =  c("",as.character(data.frame( sqlQuery(connect,paste("SELECT LOGINUSER from userdata")))$LOGINUSER))  )
    })
  })

  #####################################################################################################
  #                                             button update user                                    #
  #####################################################################################################
  observeEvent(input$subusernewUp,{
    queryuserUPpfe <- sprintf(" UPDATE userdata SET MOTDPASS='%s',LEVELSECURE='%s',FROMINST='%s',USE_LOGINUSER='%s'
                                WHERE LOGINUSER ='%s';"
                              ,paste(as.character(input$userpassF)),paste(as.character(input$NivSecF)),paste(as.character(input$userInsF)),paste(as.character(USER$name)),
                              paste(as.character(input$userLoginF)))
    an.error.occured <- FALSE
    tryCatch( {sqlExecute(connect, queryuserUPpfe)}
              , error = function(e) {an.error.occured <<- TRUE}
    )
    if(an.error.occured){
      info("Error : Update USER")
    }else{info("User successfully Updated")}
    observe({updateSelectInput(session,"userLoginF","",choices =  c(" ",as.character(data.frame( sqlQuery(connect,paste("SELECT LOGINUSER from userdata")))$LOGINUSER)))
    })
  })

  #####################################################################################################
  #                                             button update species                                 #
  #####################################################################################################
  observeEvent(input$btnUpdateIdentifiedSpecies,{
    queryUpdateIdentifiedSpecies <- sprintf("UPDATE sample SET SPECIES='%s' WHERE ID_SAMPLE='%s'",paste(as.character(input$spece)),paste(as.character(input$upsample),collapse = ", " ))
    if(toString(input$upsample)==""){
      info("You must choose a sample from list")
    }else if(toString(input$spece)==""){
      info("You must specify specy from list")
    }else {
      an.error.occured <- FALSE
      tryCatch( {sqlExecute(connect,queryUpdateIdentifiedSpecies)}
                , error = function(e) {an.error.occured <<- TRUE}
      )
      if(an.error.occured){
        info("Error : Updated species")
      }else{info("Species successfully Updated ")}
    }
    observe({updateSelectInput(session,"upsample","Choose Sample",choices = c("",as.character(dataech()[,1])))})
  })

  #####################################################################################################
  #                                             Select diagnosis data                                 #
  #####################################################################################################
  doneTest=reactive({
    data.frame( sqlQuery(connect,sprintf("SELECT TEST,RESULT,LEISHSUSPECT from diognosis where ID_SAMPLE='%s'",paste(input$upsample))))
  })
  output$testsDone=renderTable ({
    doneTest()
  })

  #####################################################################################################
  #                                              Edit patient data                                    #
  #####################################################################################################
  dataModalUPPatient <- function(failed = FALSE) {
    if(paste(USER$name)=='super')
    {
      modalDialog(
        selectInput("DUPpatient", "Select patient",
                    choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT PATIENT_IDENTIFIER from patient")))$PATIENT_IDENTIFIER)))),
        uiOutput("formUpdatePatient"),
        footer = tagList(
          modalButton("Cancel"),
          actionButton("btnUpdatePatient", "OK")
        )
      )
    }else{
      modalDialog(
        selectInput("DUPpatient", "Select patient",
                    choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT PATIENT_IDENTIFIER from patient where LOGINUSER='%s'",paste(USER$name))))$PATIENT_IDENTIFIER)))),
        uiOutput("formUpdatePatient"),
        footer = tagList(
          modalButton("Cancel"),
          actionButton("btnUpdatePatient", "OK")
        )
      )
    }
  }
  observeEvent(input$editpatient, {
    showModal(dataModalUPPatient())
  })
  UPdatavaluePat=reactive({
    data.frame(sqlQuery(connect,sprintf("SELECT * from patient where PATIENT_IDENTIFIER='%s'",paste(input$DUPpatient) )))
  })
  output$formUpdatePatient=renderUI({
    box(
      #textInput("patientIDUP","patient DB Code",value =UPdatavaluePat()$PATIENT_IDENTIFIER),
      textInput("medfilenumberUP","Patient ID",value =UPdatavaluePat()$MEDICAL_FILE_NUMBER),
      textInput("ConsPatUP","Consentment", value =UPdatavaluePat()$CONSENT),
      #textInput("prenompUP","First name",value =UPdatavaluePat()$FIRST_NAME),
      #textInput("nompUP","Last name",value =UPdatavaluePat()$LAST_NAME),
      dateInput("datenaisspUP","Birth date",value =UPdatavaluePat()$BIRTH_DATE),
      numericInput("AgePatientUP","Or Age",value =UPdatavaluePat()$AGE),
      textInput("nationalpUP","Nationality", value =UPdatavaluePat()$NATIONALITY) ,
      textInput("sexepUP","Gender", value =UPdatavaluePat()$GENDER)#,
      #textInput("phonenumUP","Phone number",value =UPdatavaluePat()$PHONE_NUMBER)
    )
  })

  ########################################################################
  # button update patient                                                #
  ########################################################################
  observeEvent(input$btnUpdatePatient,{
    queryUpdatePatient <- sprintf("
                                 UPDATE patient SET MEDICAL_FILE_NUMBER='%s',BIRTH_DATE='%s',AGE='%s',NATIONALITY='%s',GENDER='%s',CONSENT='%s' WHERE LOGINUSER='%s' and PATIENT_IDENTIFIER='%s';",
                                  paste(as.character(input$medfilenumberUP)),paste(as.character(input$datenaisspUP)),paste(as.character(input$AgePatientUP)),paste(as.character(input$nationalpUP)),paste(as.character(input$sexepUP)),paste(as.character(input$ConsPatUP)),paste(USER$name),paste(as.character(input$DUPpatient)))
    an.error.occured <- FALSE
    tryCatch( {sqlExecute(connect, queryUpdatePatient)}
              , error = function(e) {an.error.occured <<- TRUE}
    )
    if(an.error.occured){
      info("Error : Update patient ")
    }else{info("Patient successfully Updated")}
    removeModal()
  })

  #####################################################################################################
  #                                              Edit checkup data                                    #
  #####################################################################################################
  dataModalUPMEdCheck <- function(failed = FALSE) {
    modalDialog(
      selectInput("DUPcheck", "Select checkup date",
                  choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT DATE_MED from medical_checkup where PATIENT_IDENTIFIER='%s'",paste(input$PatIdentifier))))$DATE_MED))
                  )),
      uiOutput("formUpdateMedicalcheckup"),
      footer = tagList(
        modalButton("Cancel"),
        actionButton("btnUpdateMedicalcheckup", "OK")
      )
    )
  }
  observeEvent(input$editmedcheck, {
    showModal(dataModalUPMEdCheck())
  })
  UPdatavalueCheck=reactive({
    querySelectDataPatient=data.frame(sqlQuery(connect,sprintf("SELECT * from medical_checkup where PATIENT_IDENTIFIER='%s' and DATE_MED='%s'",paste(input$PatIdentifier),paste(as.character(input$DUPcheck)) )))
  })
  output$formUpdateMedicalcheckup=renderUI({
    box(
      p("feilds with asterisk(*) are mandatory", style = "color:red"),
      textInput("interrIDUP","Interrogator ID",value = UPdatavalueCheck()$ID_INTERROGATOR),
      textInput("hospitalUP","Hospital",value = UPdatavalueCheck()$HOSPITAL),
      textInput("pysicienUP","Physician",value = UPdatavalueCheck()$PHYSICIAN ),
      textInput("samplerUP","Sampler",value = UPdatavalueCheck()$SAMPLE ),
      textInput("clinstateUP","Clinical State",value = UPdatavalueCheck()$CLINICAL_STATE),
      textInput("HhostRUP","Surrounding human cases", value = UPdatavalueCheck()$POSSIBLE_HUMAN_HOSTS),
      textInput("HhostLUP","Link with human cases", value = UPdatavalueCheck()$LINK_HUMAN_HOSTS),
      textInput("AhostUP","Possible animal contact" ,value = UPdatavalueCheck()$ANIMAL_AROUND),
      numericInput("Lesion_NumberUP","Number of Lesions*",value = UPdatavalueCheck()$LESNUM ),
      textInput("Lesion_SitesUP","Lesion Sites",value = UPdatavalueCheck()$LESPOSSS )
    )
  })

  ########################################################################
  # button update CheckUp                                                #
  ########################################################################
  observeEvent(input$btnUpdateMedicalcheckup,{
    queryCheckUPpfe <- paste0("UPDATE medical_checkup SET ID_INTERROGATOR='",input$interrIDUP,"' ,HOSPITAL='",input$hospitalUP,"',PHYSICIAN='",input$pysicienUP,"',
                               SAMPLER='",input$samplerUP,"',CLINICAL_STATE='",input$clinstateUP,"',POSSIBLE_HUMAN_HOSTS='",input$HhostRUP,"',
                               LINK_HUMAN_HOSTS='",input$HhostLUP,"',ANIMAL_AROUND='",input$AhostUP,"' ,LESPOSSS ='",input$Lesion_SitesUP,"',
                               LESNUM ='",input$Lesion_NumberUP,"',GENDESC='",input$General_DescriptionUP,"'
                               where PATIENT_IDENTIFIER='",input$PatIdentifier,"' and DATE_MED='",input$DUPcheck,"' and ID_MED='",UPdatavalueCheck()$ID_MED,"' ;" )
    if(is.na(input$Lesion_NumberUP)){
      info("Error : Wrong value lesion number")
    }else if(input$Lesion_NumberUP<(-1)){
      info("Error : Wrong value lesion number")
    }else{
      an.error.occured <- FALSE
      tryCatch( {sqlExecute(connect,queryCheckUPpfe )}
                , error = function(e) {an.error.occured <<- TRUE}
      )
      if(an.error.occured){
        info("Error : Update medical checkup")
      }else{info("Medical Checkup successfully Updated")}
    }
    removeModal()
  })

  #####################################################################################################
  #                                     Edit historical treatment data                                #
  #####################################################################################################
  dataModalUPTreatment <- function(failed = FALSE) {
    modalDialog(
      selectInput("DUPtreat", "Select treatment starting date",
                  choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT START_DATE from treatmenthistory where PATIENT_IDENTIFIER='%s'",paste(input$PatIdentifier))))$START_DATE))
                  )),
      uiOutput("formUpdateTreatment"),
      footer = tagList(
        modalButton("Cancel"),
        actionButton("btnUpdateTreatment", "OK")
      )
    )
  }
  observeEvent(input$edittreatment, {
    showModal(dataModalUPTreatment())
  })
  UPdatavalueTreat=reactive({
    data.frame(sqlQuery(connect,sprintf("SELECT * from treatmenthistory where PATIENT_IDENTIFIER='%s' and START_DATE='%s'",paste(input$PatIdentifier),paste(as.character(input$DUPtreat)) )))
  })
  output$formUpdateTreatment=renderUI({
    box(width = 12,
        textInput("treattypeUP","Treatment type",value = UPdatavalueTreat()$TREATMENT_TYPE),
        textInput("prescribedUP","Prescribed for",value = UPdatavalueTreat()$PRESCRIBEDFOR),
        dateInput("datetreatbegUP","Treatment start date",value = UPdatavalueTreat()$START_DATE),
        textInput("datetreatendUP","Treatment Duration (in weeks, one year = 52 weeks)",value = UPdatavalueTreat()$DURATIONN),

        textInput("PosologyUP","Posology",value = UPdatavalueTreat()$POSOLOGY),
        textInput("adminUP","Administration Root",value = UPdatavalueTreat()$ADMINROUTE),
        numericInput("injectionnumberUP","Number of injections* (for Glucantime)",value = UPdatavalueTreat()$INJECTION_NUMBER),
        dateInput("healingUP","Healing Date",value = UPdatavalueTreat()$HEALING_DATE)
    )
  })

  ########################################################################
  # button update treatment                                              #
  ########################################################################
  observeEvent(input$btnUpdateTreatment,{
    queryUpdateTreatment <- paste0("UPDATE treatmenthistory SET TREATMENT_TYPE='",input$treattypeUP,"' ,PRESCRIBEDFOR='",input$prescribedUP,"',DURATIONN='",input$datetreatendUP,"',
                                    POSOLOGY='",input$PosologyUP,"', ADMINROUTE='",input$adminUP,"',INJECTION_NUMBER='",input$injectionnumberUP,"',HEALING_DATE='",input$healingUP,"',START_DATE='",input$datetreatbegUP,"'
                                    where PATIENT_IDENTIFIER='",input$PatIdentifier,"' and START_DATE='",input$DUPtreat,"' and IDTREATMENT='",UPdatavalueTreat()$IDTREATMENT,"' ;")
    an.error.occured <- FALSE
    tryCatch( {sqlExecute(connect,queryUpdateTreatment)}
              , error = function(e) {an.error.occured <<- TRUE}
    )
    if(an.error.occured){
      info("Error : Update treatment")
    }else{info("Treatment successfully Updated")}
    removeModal()
  })

  #####################################################################################################
  #                                              Edit movement data                                    #
  #####################################################################################################
  dataModalUPRegion <- function(failed = FALSE) {
    modalDialog(
      selectInput("DUPmvt", "Select movement",
                  choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT FROMDate from travel_residency where PATIENT_IDENTIFIER='%s'",paste(input$PatIdentifier))))$FROMDate))
                  )),
      uiOutput("formUpdateTR"),
      footer = tagList(
        modalButton("Cancel"),
        actionButton("btnUpdateT_R", "OK")
      )
    )
  }
  observeEvent(input$editregion, {
    showModal(dataModalUPRegion())
  })
  UPdatavalueMvt=reactive({
    data.frame(sqlQuery(connect,sprintf("SELECT * from travel_residency where PATIENT_IDENTIFIER='%s' and FROMDATE='%s'",paste(input$PatIdentifier),paste(as.character(input$DUPmvt)) )))
  })
  output$formUpdateTR=renderUI({
    box(width = 12,
        textInput("regvisitUP","City", value=UPdatavalueMvt()$CITY),
        textInput("TypeUP","Urban/Rural",value=UPdatavalueMvt()$TYPE),
        textInput("resedentUP","Residency ",value=UPdatavalueMvt()$RESIDENCY),
        textInput("bybyteUP","Bite Notion",value=UPdatavalueMvt()$BYTENOT),
        dateInput("datedatevisitUP","Visit Date",value = UPdatavalueMvt()$FROMDATE),
        textInput("dateleavevisitUP","Duration (In wek)",value = UPdatavalueMvt()$TODATE)
    )
  })

  ########################################################################
  # button update mvt                                                    #
  ########################################################################
  observeEvent(input$btnUpdateT_R,{
    querymvtpfe <- paste0("UPDATE travel_residency SET 	CITY='",as.character(input$regvisitUP),"' ,RESIDENCY='",as.character(input$resedentUP),"',BYTENOT='",as.character(input$bybyteUP),"',
                           TODATE='",as.character(input$dateleavevisitUP),"',TYPE='",as.character(input$TypeUP),"', FROMDATE='",as.character(input$datedatevisitUP),"' where
                           PATIENT_IDENTIFIER='",as.character(input$PatIdentifier),"' and FROMDATE='",as.character(input$DUPmvt),"' and IDMVT='",UPdatavalueMvt()$IDMVT,"'  ;" )
    an.error.occured <- FALSE
    tryCatch( {sqlExecute(connect,querymvtpfe)}
              , error = function(e) {an.error.occured <<- TRUE}
    )
    if(an.error.occured){
      info("Error : Update Mouvement ")
    }else{info("Mouvement successfully Updated")}
    removeModal()
  })

  #####################################################################################################
  #                                              Edit Sample data                                    #
  #####################################################################################################
  dataModalUSample <- function(failed = FALSE) {
    modalDialog(
      selectInput("DUPsample", "Select sample",
                  choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT ID_SAMPLE from sample where PATIENT_IDENTIFIER='%s'",paste(input$PatIdentifier))))$ID_SAMPLE))
                  )),
      uiOutput("formUpdateSample"),
      footer = tagList(
        modalButton("Cancel"),
        actionButton("btnUpdateSample", "OK")
      )
    )
  }
  observeEvent(input$btnUpdateSampleInt, {
    showModal(dataModalUSample())
  })
  UPdatavalueSample=reactive({
    data.frame(sqlQuery(connect,sprintf("SELECT * from sample where PATIENT_IDENTIFIER='%s' and ID_SAMPLE='%s'",paste(input$PatIdentifier),paste(as.character(input$DUPsample)) )))
  })
  output$formUpdateSample=renderUI({
    box(width = 12,
        p("feilds with asterisk(*) are mandatory", style = "color:red"),
        textInput("samplsupportUP","Type of sample support",value = UPdatavalueSample()$TYPE_OF_SAMPLE_SUPPORT_),
        textInput("sammethUP","Sampling Method",value = UPdatavalueSample()$SAMPLING_METHOD),
        textInput("directexamUP","Direct examination result",value = UPdatavalueSample()$DIRECT_EXAMINATION),
        textInput("abandanceUP","Abundance on the smear",value = UPdatavalueSample()$ABUDANCE_ON_THE_SMEAR),
        dateInput("apparitionlesionUP","Lesion first appearence",value = UPdatavalueSample()$Date_First_Apeard) ,
        numericInput("Lesion_AgeUP","Or leision age(in weeks)",value = UPdatavalueSample()$Lesion_Age) ,
        numericInput("diamlesionMaxUP","lesion Diameter Maximal(millimeter)*",value =UPdatavalueSample()$DIAMETREMax) ,
        numericInput("diamlesionMinUP","lesion Diameter Minimal(millimeter)*",value =UPdatavalueSample()$DIAMETREMin) ,
        numericInput("highlesionUP","lesion Hight(millimeter)*",value =UPdatavalueSample()$HIGHT) ,
        # textInput("locallesionUP","Lesion localisation*",value = UPdatavalueSample()$LOCALISATION) ,
        textInput("extractDayUP","Sampling date*",value = UPdatavalueSample()$DATE_EXTRACTION),
        textInput("descriptionlesionUP","Lesion description",value = UPdatavalueSample()$DESCRIPTION)
    )
  })

  ########################################################################
  # button update Sample                                                 #
  ########################################################################
  observeEvent(input$btnUpdateSample,{
    queryUpdateSample <- sprintf("UPDATE sample SET SAMPLING_METHOD='%s',TYPE_OF_SAMPLE_SUPPORT_='%s',
                                  DIRECT_EXAMINATION='%s',ABUDANCE_ON_THE_SMEAR='%s', Date_First_Apeard='%s',  Lesion_Age='%s',
                                  DIAMETREMax='%s',DIAMETREMin='%s',HIGHT='%s',DATE_EXTRACTION='%s',DESCRIPTION='%s'
                                  where PATIENT_IDENTIFIER='%s' and ID_SAMPLE='%s';",
                                 paste(as.character(input$sammethUP)),paste(as.character(input$samplsupportUP)),paste(as.character(input$directexamUP)) ,
                                 paste(as.character(input$abandanceUP)),paste(as.character(input$apparitionlesionUP)),paste(as.character(input$Lesion_AgeUP)),
                                 paste(as.character(input$diamlesionMaxUP)),paste(as.character(input$diamlesionMinUP)),paste(as.character(input$highlesionUP)),
                                 paste(as.character(input$extractDayUP)),paste(as.character(input$descriptionlesionUP)) ,
                                 paste(as.character(input$PatIdentifier)), paste(as.character(input$DUPsample)) )
    an.error.occured <- FALSE
    tryCatch( {sqlExecute(connect,queryUpdateSample)}
              , error = function(e) {an.error.occured <<- TRUE}
    )
    if(an.error.occured){
      info("Error : Update Sample  ")
    }else{info("Sample successfully Updated")}
    removeModal()
  })

  #####################################################################################################
  #                                              Edit Diagnosis data                                 #
  #####################################################################################################
  dataModalUDiagnosis <- function(failed = FALSE) {
    modalDialog(
      selectInput("sampleUPDiag","Sample ID",choices = c("",c(as.character(data.frame( sqlQuery(connect,paste("SELECT ID_SAMPLE from sample", if(toString(input$PatIdentifier)!=""){paste0("where PATIENT_IDENTIFIER='",input$PatIdentifier,"';" )} ) ))[,1])))),
      uiOutput("testdiagTestAndLabName"),
      uiOutput("testdiagFFFFFF"),
      footer = tagList(
        modalButton("Cancel"),
        actionButton("okDiagnosis", "OK")
      )
    )
  }
  observeEvent(input$editDiag, {
    showModal(dataModalUDiagnosis())
  })
  UPdatavalueDiagnosis=reactive({
    ddddddDiag=data.frame(sqlQuery(connect,sprintf("SELECT * from diognosis where ID_SAMPLE='%s' and TEST='%s' and LABORATORY_NAME='%s'",paste(as.character(input$sampleUPDiag)),paste(as.character(input$testupdiag)), paste(as.character(input$labupDiag)))))
  })
  output$testdiagTestAndLabName=renderUI({
    box(width = 12,
        column("",selectInput("testupdiag","Molecular test",choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT TEST from diognosis where ID_SAMPLE='%s'",paste(as.character(input$sampleUPDiag)))))[,1])))),width = 6),
        column("",selectInput("labupDiag","Laboratory name",choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT LABORATORY_NAME from diognosis where ID_SAMPLE='%s' ",paste(as.character(input$sampleUPDiag)) )))[,1])))),width = 6)

    )
  })
  output$testdiagFFFFFF=renderUI({
    box(width = 12,
        textInput("dattestUP","Test date",value = UPdatavalueDiagnosis()$DIAGNOSIS_DATE),
        numericInput("quantityUP","Quantity",value = UPdatavalueDiagnosis()$QUANTITE),
        textInput("restestUP","Test result",value = UPdatavalueDiagnosis()$RESULT),
        textInput("susSpecUP","Suspected Species",value = UPdatavalueDiagnosis()$LEISHSUSPECT)
    )
  })

  ########################################################################
  # button update Diagnosis                                              #
  ########################################################################
  observeEvent(input$okDiagnosis,{
    queryUpdateDiognosis <- sprintf(" UPDATE diognosis SET 	DIAGNOSIS_DATE='%s' ,QUANTITE='%s',
                                      RESULT='%s',	LEISHSUSPECT='%s' where
                                      ID_SAMPLE='%s' and TEST='%s' and LABORATORY_NAME='%s' and IDDIAGNOSIS='%s' ;",
                                    paste(as.character(input$dattestUP)),paste(as.character(input$quantityUP)),
                                    paste(as.character(input$restestUP)),paste(as.character(input$susSpecUP)) ,
                                    paste(as.character(input$sampleUPDiag)),paste(as.character(input$testupdiag)),paste(as.character(input$labupDiag)),paste(as.character(UPdatavalueDiagnosis()$IDDIAGNOSIS)) )
    an.error.occured <- FALSE
    tryCatch( {sqlExecute(connect,queryUpdateDiognosis)}
              , error = function(e) {an.error.occured <<- TRUE}
    )
    if(an.error.occured){
      info("Error : Update Diagnosis   ")
    }else{info("Diagnosis successfully Updated")}
    observe({updateSelectInput(session,"upsample","Choose Sample",choices = c("",as.character(dataech()[,1])))})
    removeModal()
  })

  #####################################################################################################
  #                                            Edit Interrogator data                                 #
  #####################################################################################################
  dataModalUInterrogator <- function(failed = FALSE) {
    modalDialog(
      selectInput("DUPInterrogator", "Select Interrogator",
                  choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT ID_INTERROGATOR from interrogator where LOGINUSER='%s'",paste(USER$name))))$ID_INTERROGATOR)))),
      uiOutput("btnUpdateInterrogator") ,
      footer = tagList(
        modalButton("Cancel"),
        actionButton("btnUpdateInterrogator", "OK")
      )
    )
  }
  observeEvent(input$editinterr, {
    showModal(dataModalUInterrogator())
  })
  UPdatavalueinterrogator=reactive({
    queryDataSelectInterrogator=data.frame(sqlQuery(connect,sprintf("SELECT * from interrogator where ID_INTERROGATOR='%s'",paste(input$DUPInterrogator) )))
  })
  output$btnUpdateInterrogator=renderUI({
    box(width = 12,
        p("feilds with asterisk(*) are mandatory", style = "color:red"),
        textInput("idInterrogatorUP","Identity number*",value =UPdatavalueinterrogator()$ID_Interrogator),
        textInput("nameInterrogatorUP","Last name*",value =UPdatavalueinterrogator()$LAST_NAME_Interrogator),
        textInput("lastNameInterrogatorUP","First name*",value = UPdatavalueinterrogator()$FIRST_NAME_Interrogator),
        textInput("qualityInterrogatorUP","Quality*",value = UPdatavalueinterrogator()$QUALITY)
    )
  })

  ########################################################################
  # button update interrogator                                                    #
  ########################################################################
  observeEvent(input$btnUpdateInterrogator,{
    queryUpdateInterrogator <- sprintf("
                             UPDATE interrogator SET 	ID_INTERROGATOR='%s' ,LAST_NAME_INTERROGATOR='%s',FIRST_NAME_INTERROGATOR='%s',QUALITY='%s' where
                             ID_INTERROGATOR='%s' ;",
                                       paste(as.character(input$idInterrogatorUP)),paste(as.character(input$nameInterrogatorUP)),paste(as.character(input$lastNameInterrogatorUP)),
                                       paste(as.character(input$qualityInterrogatorUP)) , paste(as.character(input$DUPInterrogator)))
    sqlExecute(connect,query = queryUpdateInterrogator)
    info("Interrogator successfully Updated")
    removeModal()
  })

  #####################################################################################################
  #                                              Edit laboratory data                                 #
  #####################################################################################################
  dataModalULabs<- function(failed = FALSE) {
    modalDialog(
      selectInput("DUPLaboratory", "Select Laboratory",
                  choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT LABORATORY_NAME from laboratory where LOGINUSER='%s'",paste(USER$name))))$LABORATORY_NAME)))),

      uiOutput("testlabbbFFFFFF") ,
      footer = tagList(
        modalButton("Cancel"),
        actionButton("okDUPLaboratory", "OK")
      )
    )
  }
  observeEvent(input$editlab, {
    showModal( dataModalULabs())
  })
  UPdatavaluelabo=reactive({
    data.frame(sqlQuery(connect,sprintf("SELECT * from laboratory where LABORATORY_NAME='%s'",paste(input$DUPLaboratory) )))
  })
  output$testlabbbFFFFFF=renderUI({
    box(width = 12,
        textInput("nameLabUP","Laboratory Complete name",value = UPdatavaluelabo()$LABORATORY_NAME),
        textInput("countryLabUP","Country",value = UPdatavaluelabo()$COUNTRY)
    )
  })

  ########################################################################
  # button update laboratory                                             #
  ########################################################################
  observeEvent(input$okDUPLaboratory,{
    queryUpdateLab <- sprintf("
                           UPDATE laboratory SET 	LABORATORY_NAME='%s' ,COUNTRY='%s' where
                           LABORATORY_NAME='%s' ;",
                              paste(as.character(input$nameLabUP)),paste(as.character(input$countryLabUP)),
                              paste(as.character(input$DUPLaboratory)))
    sqlExecute(connect,query = queryUpdateLab )
    info("Laboratory successfully Updated")
    removeModal()
  })

  ##############################################################################################
  output$ttt= renderUI({
    vals=choice$value[which(choice$choiceCat==input$val)]
    selectInput("valL","Rak",choices = c(vals))
  })
  ##############################################################################################################################################################
  #                                                                     The END                                                                                #
  ##############################################################################################################################################################
})