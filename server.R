
library(readr)

world <- read_delim("www/country_list.csv",  ";", escape_double = FALSE, trim_ws = TRUE)
choice <- read_delim("www/choice.csv",  ";", escape_double = FALSE, trim_ws = TRUE)
#library(mailR)
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
#library(Sys)


connect=odbcConnect("MyAppDB", uid='emna', pwd='16souemna')
#connect=odbcConnect("ServeurDSN", uid='root', pwd='16souemna')
#connect=odbcConnect("MyAppDBserver", uid='root', pwd='16souemna')


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
  
  dataalliq=reactive({
    sqlQuery(connect,paste("SELECT * from dbpfedev.alliquot"))
  })
  
  datatestech=reactive({
    sqlQuery(connect,paste("SELECT * from dbpfedev.molecularl_test"))
  })
  
  datalab=reactive({
    sqlQuery(connect,paste("SELECT * from dbpfedev.laboratory"))
  })
  
  pat=reactive({
    sqlQuery(connect,paste("SELECT * from dbpfedev.patient"))
  })
  
  ChUp=reactive({
    sqlQuery(connect,paste("SELECT * from dbpfedev.medical_checkup"))
  })
  
  datareg=reactive({
    sqlQuery(connect,paste("SELECT * from dbpfedev.region"))
  })
  
  dataech=reactive({
    sqlQuery(connect,paste("SELECT * from dbpfedev.sample"))
  })
  
  useee=reactive({
    sqlQuery(connect,paste("SELECT * from dbpfedev.userdata"))
  })
  
  dataetab=reactive({
    sqlQuery(connect,paste("SELECT * from dbpfedev.laboratory"))
  })
  
  datainvv=reactive({
    sqlQuery(connect,paste("SELECT * from dbpfedev.interrogator"))
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
    AAll=sqlQuery(connect,paste("SELECT * from dbpfedev.",input$ttest))
    AAll
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
  
  
  
  
  
  
  observeEvent(input$selecthome2, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "acc2"
    updateTabItems(session, "tabs", newvalue)
  })
  observeEvent(input$selecthome2.1, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "acc2"
    updateTabItems(session, "tabs", newvalue)
  })
  
  observeEvent(input$selecthome2.2, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "acc2"
    updateTabItems(session, "tabs", newvalue)
  })
  observeEvent(input$selecthome2.3, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "acc2"
    updateTabItems(session, "tabs", newvalue)
  })
  observeEvent(input$selecthome2.5, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "acc2"
    updateTabItems(session, "tabs", newvalue)
  })
  
  #######################################################
  
  observeEvent(input$selectDatMang, {
    
    ############################################################################
    #                              Access to Super                             #
    ############################################################################
    security=sqlQuery(connect,paste("SELECT * from dbpfedev.userdata"))
    security=security[which(security[,1]==USER$name),3]
    validate(
      need(security!="normal", "You have to be a super user to access")
    )
    
    
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "cleanD"
    updateTabItems(session, "tabs", newvalue)
  })
  observeEvent(input$selectMang1, {
    ############################################################################
    #                              Access to Super                             #
    ############################################################################
    security=sqlQuery(connect,paste("SELECT * from dbpfedev.userdata"))
    security=security[which(security[,1]==USER$name),3]
    validate(
      need(security!="normal", "You have to be a super user to access")
    )
    
    
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "cleanD"
    updateTabItems(session, "tabs", newvalue)
  })
  observeEvent(input$selectMang2, {
    ############################################################################
    #                              Access to Super                             #
    ############################################################################
    security=sqlQuery(connect,paste("SELECT * from dbpfedev.userdata"))
    security=security[which(security[,1]==USER$name),3]
    validate(
      need(security!="normal", "You have to be a super user to access")
    )
    
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "cleanD"
    updateTabItems(session, "tabs", newvalue)
  })
  
  observeEvent(input$selectMang3, {
    ############################################################################
    #                              Access to Super                             #
    ############################################################################
    security=sqlQuery(connect,paste("SELECT * from dbpfedev.userdata"))
    security=security[which(security[,1]==USER$name),3]
    validate(
      need(security!="normal", "You have to be a super user to access")
    )
    
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "cleanD"
    updateTabItems(session, "tabs", newvalue)
  })
  
  observeEvent(input$selectMang4, {
    ############################################################################
    #                              Access to Super                             #
    ############################################################################
    security=sqlQuery(connect,paste("SELECT * from dbpfedev.userdata"))
    security=security[which(security[,1]==USER$name),3]
    validate(
      need(security!="normal", "You have to be a super user to access")
    )
    
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "cleanD"
    updateTabItems(session, "tabs", newvalue)
  })
  
  observeEvent(input$selectMang5, {
    ############################################################################
    #                              Access to Super                             #
    ############################################################################
    security=sqlQuery(connect,paste("SELECT * from dbpfedev.userdata"))
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
  observeEvent(input$selectDatAdd2.1, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "OTD"
    updateTabItems(session, "tabs", newvalue)
  })
  
  observeEvent(input$selectDatAdd2.2, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "OTD"
    updateTabItems(session, "tabs", newvalue)
  })
  observeEvent(input$selectDatAdd2.3, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "OTD"
    updateTabItems(session, "tabs", newvalue)
  })
  observeEvent(input$selectDatAdd2.4, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "OTD"
    updateTabItems(session, "tabs", newvalue)
  })
  
  observeEvent(input$selectDatAdd2.5, {
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
  observeEvent(input$selectDatView2_1, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "VD"
    updateTabItems(session, "tabs", newvalue)
  })
  observeEvent(input$selectDatView2_2, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "VD"
    updateTabItems(session, "tabs", newvalue)
  })
  observeEvent(input$selectDatView2_3, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "VD"
    updateTabItems(session, "tabs", newvalue)
  })
  observeEvent(input$selectDatView2_4, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "VD"
    updateTabItems(session, "tabs", newvalue)
  })
  
  observeEvent(input$selectDatView2_5, {
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
  observeEvent(input$selectDatAna2_1, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "AnD"
    updateTabItems (session, "tabs", newvalue)
  })
  observeEvent(input$selectDatAna2_2, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "AnD"
    updateTabItems (session, "tabs", newvalue)
  })
  observeEvent(input$selectDatAna2_3, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "AnD"
    updateTabItems (session, "tabs", newvalue)
  })
  observeEvent(input$selectDatAna2_4, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "AnD"
    updateTabItems (session, "tabs", newvalue)
  })
  
  observeEvent(input$selectDatAna2_5, {
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
  observeEvent(input$selectpub2_1, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "UP"
    updateTabItems(session, "tabs", newvalue)
  })
  observeEvent(input$selectpub2_2, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "UP"
    updateTabItems(session, "tabs", newvalue)
  })
  observeEvent(input$selectpub2_3, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "UP"
    updateTabItems(session, "tabs", newvalue)
  })
  observeEvent(input$selectpub2_4, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "UP"
    updateTabItems(session, "tabs", newvalue)
    
  })
  
  observeEvent(input$selectpub2_5, {
    addClass(selector = "body", class = "sidebar-collapse")
    newvalue <- "UP"
    updateTabItems(session, "tabs", newvalue)
    
  })
  #########################################################################
  
  
  userdata=reactive({
    dataU=sqlQuery(connect,"SELECT * from userdata")
    dataU
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
        actionButton("Login", "Login")
      )
      
      
    }
  })
  
  output$pass <- renderText({  
    if (USER$Logged == FALSE) {
      USER$pass
    }  
  })
  
  # Login info during session ----
  output$userPanel <- renderUI({
    if (USER$Logged == TRUE) {
      fluidRow(
        column(2,
               span("User: ", USER$name , style="color:blue")
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
              column(3,  h3(actionLink("selectDatMang",strong("Data Management"),icon = icon("fa fa-american-sign-language-interpreting"))))),
          box(width = 2, status = "info",solidHeader = TRUE,
              column(3,  h3(actionLink("selectDatAdd",strong("Data Entry"),icon = icon("list-alt"))))),
          box(width = 2, status = "info",solidHeader = TRUE,
              column(3,  h3(actionLink("selectDatView",strong("Data Viewer") ,icon = icon("table"))))
          ),
          box(width = 2, status = "info",solidHeader = TRUE,
              column(3,  h3(actionLink("selectDatAna",strong("Data Analysor"),icon = icon("bar-chart-o"))))),
          box(width = 2, status = "info",solidHeader = TRUE,
              column(3,  h3(actionLink("selectpub",strong("Publication Consultor") ,icon = icon("refresh"))))))
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
                 id="formDiagnos",
                 div(
                   id="formDiagnos",
                   fluidRow(
                     box(width = 12,height = 300, status = "info",solidHeader = TRUE,
                         column("",selectInput("chemtest","Molecular test",choices = c("",as.character(datatestech()[,1]))),width = 4),
                         column("",selectInput("labname","Laboratory",choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT LABORATORY_NAME from dbpfedev.laboratory")))$LABORATORY_NAME)))),width = 4),
                         column("",selectInput("sample","Sample",choices = c("",as.character(dataech()[,1]))),width = 4),
                         
                         column("",dateInput("dattest","Test date",value = "1900-01-01"),width = 6),
                         column("",textInput("quantity","DNA volume (in micoL)",""),width = 6),
                         column("",selectInput("restest","Test result",choices = c("","+","-","N/A")),width = 6),
                         #column("",selectInput("susSpec","Suspected Species",choices = c("",c(as.character(data.frame(sqlQuery(connect,sprintf("SELECT SPECIES from dbpfedev.leishmania_species")))$SPECIES))),multiple=TRUE),width = 6)
                         column("",selectInput("susSpec","Suspected Species",choices = c("",c(as.character(data.frame(sqlQuery(connect,sprintf("SELECT SPECIES from dbpfedev.leishmania_species")))$SPECIES)))),width = 6)
                     ),
                     actionButton("submitDiag", "Submit Data",  class = "btn-primary"),
                     actionButton("editDiag", "Edit",  class = "btn-primary")
                   ))),
        tabPanel(h3(strong("Identified Species")),
                 
                 fluidRow(
                   div(
                     id="formSpec",
                     box(width = 7, status = "info",solidHeader = TRUE,
                         column("", selectInput("upsample","Choose Sample",choices = c("",as.character(dataech()[,1]))),width = 4),
                         tableOutput("testsDone")
                     ),
                     column("",selectInput("spece","Identified Species",choices =c("",c(as.character(data.frame(sqlQuery(connect,sprintf("SELECT SPECIES from dbpfedev.leishmania_species")))$SPECIES)))),width = 4),
                     
                     actionButton("update","Update Leishmania species")
                   ))),
        
        tabPanel(h3(strong("Add Interrogator")),
                 
                 fluidRow(
                   div(
                     shinyjs::useShinyjs(),
                     id="forminv",
                     box(width = 12, status = "info",solidHeader = TRUE,
                         
                         column("",textInput("cini","Identity Card number",  ""),width = 4),
                         column("",textInput("nomi","Last name",""),width = 4),
                         column("",textInput("prenomi","First name",""),width = 4),
                         column("",selectInput("qual","Quality",c("","Doctor","Nurse","Researcher","Resident doctor","Technicien","N/A")),width = 4)
                         
                     ),
                     actionButton("submitIDpfe", "Submit Data",  class = "btn-primary"),
                     actionButton("editinterr", "Edit",  class = "btn-primary")
                   )) ),
        
        tabPanel(h3(strong("Add laboratory")),
                 id="formlaab",
                 div(
                   id="formlaab",
                   fluidRow(
                     column("",textInput("labnamo","Laboratory Complete name",""),width=3),
                     column("",selectInput("counlab","Country",choices = c("",world[-1,1])),width=3)
                   ),
                   actionButton("subpfelab", "Submit",  class = "btn-primary"),
                   actionButton("editlab", "Edit",  class = "btn-primary")
                 )
        )
      )
    }else{  USER$Logged <- FALSE
    USER$pass <- ""
    newvalue <- "acc2"
    updateTabItems(session, "tabs", newvalue)
    addClass(selector = "body", class = "sidebar-collapse")}
  })
  
  output$viewtable=renderUI({
    if(USER$Logged==TRUE ){
      fluidRow(
        box(width = 4, status = "info",solidHeader = TRUE,
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
                                 width=1075, height=400))}
    
    
  })
  
  output$map2=renderGvis ({
    if(USER$Logged==TRUE ){
      box(
        gvisGeoChart(mydata, locationvar="Country" ,colorvar="Score",
                     options=list(
                       projection="kavrayskiy-vii", 
                       colorAxis="{colors:['white', 'blue']}", 
                       backgroundColor="steelblue",
                       width=1000, height=200,region="145" )))}
    
    
  })
  
  
  
  output$hhhh=renderUI ({
    if(USER$Logged==FALSE ){
      
      imm=  tags$img(src="adnlove.png",width=150, height=490)
      imm 
    }
  })
  
  output$hhmm=renderUI ({
    if(USER$Logged==FALSE ){
      
      imm1=  tags$img(src="wiw.png",width=800, height=450)
      imm1 
    }
  })
  
  output$ipt=renderUI ({
    if(USER$Logged==FALSE ){
      
      imIPT=  tags$img(src="logo-IPT.png",width=90, height=450)
      imIPT 
    }
  })
  
  output$mail=renderUI({
    if(USER$Logged==FALSE ){
      column("", actionButton("mail", "Email us ",width = 237, icon("paper-plane"), 
                              style="yellow: #fff; background-color: white ; border-color: #2e6da4"),width = 4)
    } 
  })
  
  
  
  observeEvent( input$mail, {
    output$mailcontent=renderUI({
      
      if(USER$Logged==FALSE  ){
        div(
          box( width = 16,status = "info",solidHeader = TRUE,
               id="mail",
               div(
                 column("", textInput("usermail","Please enter your E-mail adress",""),width = 4),
                 column("", textInput("userwork","Institution",""),width = 4),
                 column("",selectInput("topic","Please precise your mail topic",choices = c("","Report problem","Join Leisionia network")),width = 4),
                 column("", textAreaInput("Content1","Mail body",""),width = 4),
                 column("", actionButton("sendthemail","Send the mail"),width = 2),
                 column("", actionButton("cancelmail","Cancel") ,width = 2 ))))
        
      }
    })
  })
  
  observeEvent( input$sendthemail, {
    from <- c("<hajjiyessin@gmail.com>")
    to <- c("<hajjiyessin@gmail.com>")
    subject <- toString(input$topic)
    body <- paste0("This mail was sent from ",toString(input$usermail), " working at ",toString(input$userwork),"                                                                                                                                                                                                              Topic :  ",toString(input$topic) ,"                                                                                                                                                                                                                                                                  Mail body :  ","                                                                                                                                                                                                                                                                                                   ",toString(input$Content1))
    
    send.mail(from, to, subject, body,
              smtp = list(host.name = "smtp.gmail.com", port = 587, user.name = "hajjiyessin@gmail.com", passwd = "appLesion", ssl = TRUE),
              authenticate = TRUE,
              send = TRUE  )
    info("Mail sent successfully")
    shinyjs::reset("mail")
    
  })
  
  observeEvent( input$cancelmail, {
    output$mailcontent=renderUI({
      
      if(USER$Logged==FALSE  ){
        
        
      }
    })
  })
  
  observe({
    if (is.null(input$cini) || input$cini ==0 || input$cini < 0 ) {
      shinyjs::disable("submitID")
    } else {
      shinyjs::enable("submitID")
    }
  })
  
  
  output$patdataout=renderUI ({
    if(paste(USER$name)=='super')
    {
      quer=sprintf("SELECT * from dbpfedev.patient")
    }else{
      quer=sprintf("SELECT * from dbpfedev.patient where LOGINUSER='%s'",paste(USER$name))
    }
    datpat=sqlQuery(connect,quer)
    
    
    if ( input$PatIdentifier %in% datpat[,1] ) {
      
      output$datt=renderDataTable({
        A=datpat[which(datpat$PATIENT_IDENTIFIER==input$PatIdentifier),c(1,6:8)]
        DT::datatable(A, options = list(scrollX = TRUE,lengthMenu = c(1) ,pageLength = 1))
      })
      
      div(
        DT::dataTableOutput("datt"),
        actionButton("addregion","Travel/Residency"),
        actionButton("addcheckup","Add Medical check-UP"),
        actionButton("addhisttreat","Add Historical Treatment "),
        actionButton("addhisttreat2","Add Treatment "),
        actionButton("addsample","Add Sample "),
        actionButton("gotofirst","Quit")
      )} else{
        div(
          actionButton("addpatient","Add Patient"),
          actionButton("editpatient", "Edit Patient")) }
    
  })
  
  observeEvent( input$gotofirst, {
    output$firsttimeID=renderUI({
      textInput("PatIdentifier","Please Enter the Patient DB Code",placeholder = 'XXXNNN******')
    })
    output$patdataout=renderUI ({
      
      datpat=sqlQuery(connect,paste("SELECT * from dbpfedev.patient"))
      
      
      if ( input$PatIdentifier %in% datpat[,1] ) {
        
        output$datt=renderDataTable({
          A=datpat[which(datpat$PATIENT_IDENTIFIER==input$PatIdentifier),c(1,5,7:8)]
          
          DT::datatable(A, options = list(scrollX = TRUE,lengthMenu = c(1) ,pageLength = 1))
        })
        
        div(
          DT::dataTableOutput("datt"),
          actionButton("addregion","Travel/Residency"),
          actionButton("addcheckup","Add Medical check-UP"),
          actionButton("addhisttreat","Add Historical Treatment "),
          actionButton("addhisttreat2","Add Treatment "),
          actionButton("addsample","Add Sample "),
          actionButton("gotofirst","Quit")
        )} else{
          div(
            actionButton("addpatient","Add Patient"),
            actionButton("editpatient", "Edit Patient")) }
      
    })
  })
  
  
  
  observeEvent( input$addpatient, {
    
    output$patennt=renderUI({
      
      
      output$firsttimeID=renderUI({
        
      })
      div(
        
        id="formPat1",
        #SELECT  FROM `patient` WHERE `LOGINUSER`="maaoui" ORDER BY `PATIENT_IDENTIFIER` DESC LIMIT 1;
        #datpat=sqlQuery(connect,paste("SELECT PATIENT_IDENTIFIER from dbpfedev.patient  WHERE `LOGINUSER`="%s" ORDER BY `PATIENT_IDENTIFIER` DESC LIMIT 1;",paste(USER$name)))
        
        box(width = 12, status = "info",solidHeader = TRUE,
            column("",textInput("idPattt","Patient DB Code (*)",placeholder = 'PPPLL****'), width = 4 ),
            column("",textInput("medfilenumber","Patient ID",""), width = 4 ),
            column("",selectInput("ConsPat","Consentment", c("", "Yes","No","N/A")), width = 4),
            #column("",textInput("prenomp","First name",""), width = 4),
            column("",dateInput("datenaissp","Birth date",value = "1900-01-01"), width = 4),
            column("",selectInput("nationalp","Nationality", c("", "TN","LB", "SY", "MA", "DZ", "other","N/A")), width = 4),
            #column("",textInput("nomp","Last name",""), width = 4 ),                         
            column("",selectInput("sexep","Gender", c("", "Female","Male","Other","N/A")), width = 4),
            #column("",textInput("phonenum","Phone number"), width = 4),
            
            
            box(width = 12, status = "info",solidHeader = TRUE,
                column("", textInput("regvisitPA","City of Residency (The last 6 months)",placeholder = 'Country, State, City'), width = 4),
                column("",selectInput("TypePA","Urban/Rural",choices =  c("", "Urban","Rural","N/A")), width = 4),
                
                #column("",selectInput("resedent","Residency ",choices =  c("", "Yes","No","N/A")), width = 4),
                column("",selectInput("bybytePA","Bite Notion",choices =  c("", "Yes","No","N/A")), width = 4)#,
                
                #column("",dateInput("datedatevisit","Visit Date",value = data.frame(sqlQuery(connect,sprintf("SELECT 	BIRTH_DATE from dbpfedev.patient where PATIENT_IDENTIFIER='%s'",as.character(input$PatIdentifier))))$BIRTH_DATE), width = 4) ,
                #column("",textInput("dateleavevisit","Duration (In week)"), width = 4)
                
            )
            
        ),
        actionButton("subb","Submit"),
        actionButton("cansAdd","Cancel")
      )
    })
  })
  
  observeEvent( input$subb, {
    
    queryIpfe <- paste0(
      "INSERT INTO patient
      VALUES ('",toString(input$idPattt)  ,"','",toString(USER$name)  ,"', '",toString( input$medfilenumber) ,"','','','",toString( input$datenaissp) ,"','",toString( input$nationalp) ,"','",toString( input$sexep) ,"','",toString( input$ConsPat) ,"','') ")
    validate(
      need(input$idPattt!="PPPLL****"  , "Error : Missing values")
    )
    validate(
      need(input$idPattt!=""  , "Error : Missing values")
    )
    validate(
      need(try( sqlExecute(connect,query = queryIpfe)  ), "Error : Row already exists")
    )
    
    
    datatrav=sqlQuery(connect,paste("SELECT * from dbpfedev.travel_residency"))
    
    querytravinpfe <- paste0(
      "INSERT INTO  travel_residency(`IDMVT`, `CITY`, `LOGINUSER` ,`PATIENT_IDENTIFIER`, `FROMDATE`, `BYTENOT`, `RESIDENCY`,`TYPE`)
      VALUES ('", toString(paste0(input$idPattt,"-",length(datatrav[,1])+1)) ,"', '",input$regvisitPA ,"', '",paste0(USER$name),"','",toString(input$PatIdentifier),"', '",as.character( input$datenaissp )  ,"', '",toString( input$bybytePA ) ,"', '",paste0( "Yes" ) ,"','",toString(input$TypePA),"') ")
    
    validate(
      need(try(    sqlExecute(connect,query = querytravinpfe)), "Error : row already exists")
    )
    
    info("Patient successfully stored")
    shinyjs::reset("formPat1")
    
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
  
  
  observeEvent(input$addsample, {
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
              #column("",selectInput("Lesionsite","Lesion Sites",choices = c("",-1,1:45),multiple=TRUE), width = 4),
              #column("",selectInput("Lesionsite","Lesion site sampled",choices = c("","Face", "Upper limbs","Lower limbs","Trunc","Other","N/A"),multiple = TRUE), width = 4 ),
              column("",selectInput("samplsupport","Type of sample support",choices = c("","TE","Slide", "Filter paper","Saline","RNA later","N/A"),multiple = TRUE), width = 4),
              column("",selectInput("sammeth","Sampling Method",choices = c("","Scrapping","aspiration","biopsy","Dental broch","Swab","N/A"),multiple = TRUE), width = 4),

              column("",selectInput("directexam","Direct examination result",choices = c("","Positive","Negative","N/A")), width = 4),
              column("",selectInput("abandance","Abundance on the smear", c("", "+","++","+++","++++","+++++","++++++","N/A")), width = 4),
              column("",dateInput("apparitionlesion","Lesion first appearence",value="1900-01-01") , width = 4),
             
              column("",numericInput("diamlesionMax","lesion Diameter Maximal(millimeter) (*)","") , width = 4),
              column("",numericInput("diamlesionMin","lesion Diameter Minimal(millimeter) (*)","") , width = 4),
              column("",numericInput("highlesion","lesion Hight(millimeter) (*)","") , width = 4),
             
              column("",selectInput("locallesion","Lesion localisation",choices = c("",-1,1:45)) , width = 2),
              column("",selectInput("extractDay","Sampling date",choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT DATE_MED from medical_checkup where PATIENT_IDENTIFIER = '%s'",as.character(input$PatIdentifier))))$DATE_MED))) ), width = 2),
              column("",selectizeInput("descriptionlesion","Lesion description",choices=c("","Ulcerative crusty","Dry","Wet","Surrounded by a hyperpigmented rim","Nodules pseudosporotrichoides","Pseudotumoral","Infected","Surrounded by a erythematouseruption","lupoid","Other","N/A"),multiple=TRUE) , width = 4)
        ),
        actionButton("subSampleQ","Submit and Quit"),
        actionButton("subballiq","Enter Alliquot data"),
        actionButton("otherSampleAdd"," Submit and add other samples"),
        actionButton("editsample","Edit"),
        actionButton("cansAddinfo","Cancel")
      )
      
    })
  })
  
  
  observeEvent(input$addregion, {
    
    
    output$AdddRegion=renderUI({
      output$firsttimeID=renderUI({
      })
      output$patennt=renderUI({
      })
      
      output$patdataout=renderUI ({
      })
      
      div(
        
        id="formtravel",
        
        box(width = 12, status = "info",solidHeader = TRUE,
            #column("",selectInput("regvisit","City",choices =c("",as.character(datareg()[,1]))), width = 4),
            column("", textInput("regvisit","City",placeholder = 'Country, State, City'), width = 4),
            column("",selectInput("Type","Urban/Rural",choices =  c("", "Urban","Rural","N/A")), width = 4),
            column("",selectInput("resedent","Residency ",choices =  c("", "Yes","No","N/A")), width = 4),
            
            column("",selectInput("bybyte","Bite Notion",choices =  c("", "Yes","No","N/A")), width = 4),
            column("",dateInput("datedatevisit","Visit Date",value = data.frame(sqlQuery(connect,sprintf("SELECT 	BIRTH_DATE from dbpfedev.patient where PATIENT_IDENTIFIER='%s'",as.character(input$PatIdentifier))))$BIRTH_DATE), width = 4) ,
            column("",textInput("dateleavevisit","Duration (In week)",""), width = 4)
            
        ),
        actionButton("subregionQ","Submit and Quit"),
        actionButton("otherregionAdd"," Submit and add other regions"),
        actionButton("editregion","Edit"),
        actionButton("cansAddinfo","Cancel")
      )
    })
  })
 
  
  observeEvent(input$addhisttreat2, {
    output$AdddTreatment=renderUI({
      output$firsttimeID=renderUI({
      })
      output$patennt=renderUI({
      })
      
      output$patdataout=renderUI ({
      })
      
      div(
        id="formTreatment",
        
        
        box(width = 12, status = "info",solidHeader = TRUE,
            column("",selectInput("treattype","Treatment type",choices = c("","Antibiotics","Glucantime","No treatment","Other","N/A"),multiple = TRUE), width = 4 ), 
            column("",selectInput("prescribed","Prescribed for",choices = c("","Leishmania","Other","N/A")), width = 4 ), 
            column("",dateInput("datetreatbeg","Treatment start date",value = "1900-01-01"), width = 4),
            column("",textInput("datetreatend","Treatment Duration (in weeks)",""), width = 4),
            
            column("",textInput("Posology","Posology",""), width = 4),
            column("",textInput("admin","Administaration Root",""), width = 4),
            
            column("",numericInput("injectionnumber","Injection number (*)",""), width = 4)
            
        ),
        actionButton("subtreatmentQ","Submit and Quit"),
        actionButton("otheryreatmentAdd"," Submit and Add Treatment"),
        actionButton("edittreatment","Edit"),
        actionButton("cansAddinfo","Cancel")
      )
      
    })
  }) 
  
  observeEvent(input$addhisttreat, {
    output$AdddTreatment=renderUI({
      output$firsttimeID=renderUI({
      })
      output$patennt=renderUI({
      })
      
      output$patdataout=renderUI ({
      })
      
      div(
        id="formTreatment",
        
        
        box(width = 12, status = "info",solidHeader = TRUE,
            column("",selectInput("treattype","Treatment type",choices = c("","Antibiotics","Glucantime","No treatment","Other","N/A"),multiple = TRUE), width = 4 ), 
            column("",selectInput("prescribed","Prescribed for",choices = c("","Leishmania","Other","N/A")), width = 4 ), 
            column("",dateInput("datetreatbeg","Treatment start date",value = "1900-01-01"), width = 4),
            column("",textInput("datetreatend","Treatment Duration (in weeks)",""), width = 4),
            
            column("",textInput("Posology","Posology",""), width = 4),
            column("",textInput("admin","Administaration Root",""), width = 4),
            
            column("",numericInput("injectionnumber","Injection number (*)",""), width = 4),
            column("",dateInput("healing","Healing Date",value = "1900-01-01"), width = 4)
            
        ),
        actionButton("subtreatmentQ","Submit and Quit"),
        actionButton("otheryreatmentAdd"," Submit and Add Treatment"),
        actionButton("edittreatment","Edit"),
        actionButton("cansAddinfo","Cancel")
      )
    })
  })
  
  observeEvent(input$addcheckup , {
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
            column("",selectInput("interrID","Interrogator ID",choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT ID_INTERROGATOR from dbpfedev.interrogator")))$ID_INTERROGATOR)))), width = 4 ),
            column("",textInput("hospital","Hospital",""), width = 4 ),  
            column("",textInput("pysicien","Physician",""), width = 4 ),
            column("",textInput("sampler","Sampler",""), width = 4),
            column("",dateInput("datecheck","Medical check-Up date",value = "1900-01-01"), width = 4),
            column("",selectizeInput("clinstate","Clinical State",choices =  c("", "High blood pressure","Diabetes","Allergy","Pregnancy","Nothing to Report","Other","N/A"), multiple = TRUE), width = 4),
            column("",selectizeInput("HhostR","Surrounding human cases", c("","Family","Neighbour","Colleague","Yes","No","N/A"), multiple = TRUE), width = 4),
            column("",selectizeInput("HhostL","Link with human cases", c("","Household","Neighborhood","Workplace","Travel","No","N/A"), multiple = TRUE), width = 4),
            column("",selectizeInput("Ahost","Possible animal contact", c("",  "Bovines","Ovins","Caprins","Camels","Equids","Hares","Cats","Dogs","Foxs","Other Canids","Sandrats","Meriones","Other rodents","Gondis","Hedgehogs","Bates","Hyrax","Cattle","Other","No","N/A"), multiple = TRUE), width = 4),
            column("",numericInput("Lesion_Number","Number of Lesions (*)",value = ""), width = 4),
            column("",selectInput("Lesion_Sites","Lesion localisation",choices = c("","Face", "Upper limbs","Lower limbs","Trunc","Other","N/A"),multiple = TRUE), width = 4 )
            #column("",selectInput("Lesion_Sites","Lesion Sites",choices = c("",-1,1:45),multiple=TRUE), width = 4)
            
            #column("",selectInput("General_Description","General Description",choices=c("","Ulcerative crusty","Dry","Wet","Surrounded by a hyperpigmented rim","Nodules pseudosporotrichoides","Pseudotumoral","Infected","Surrounded by a erythematouseruption","lupoid","Other","N/A"),multiple=TRUE), width = 6)
            
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
        DT::dataTableOutput("datt"),
        actionButton("addregion","Travel/Residency"),
        actionButton("addcheckup","Add Medical check-UP"),
        actionButton("addhisttreat","Add Historical Treatment "),
        actionButton("addhisttreat2","Add Treatment "),
        actionButton("addsample","Add Sample "),
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
    #
    datacheck=sqlQuery(connect,paste("SELECT * from dbpfedev.medical_checkup"))
    
    info(input$Lesion_Number)
    validate(
      need(input$Lesion_Number>= -1, info("Error : Missing values"))
    )
    querycheckinpfe <- paste0(
      "INSERT INTO  medical_checkup
      VALUES ('", toString(paste0("Medical-check",length(datacheck[,1])+1)) ,"', '",toString( input$datecheck ) ,"','",toString(input$interrID)  ,"', '",toString( input$PatIdentifier) ,"','",toString( USER$name ) ,"','",toString( input$hospital) ,"', '",toString( input$pysicien ) ,"','",toString( input$sampler) ,"','",toString( input$Ahost) ,"','",toString( input$Hhost) ,"','",toString( input$clinstate) ,"','",toString( input$Lesion_Number) ,"','",toString(input$Lesion_Sites) ,"','NULL') ")
    
    validate(
      need(try(  sqlExecute(connect,query = querycheckinpfe)  ), info("Error : Row already exists"))
    )
    #
    info("Medical checkUp successfully added")
    shinyjs::reset("formCh")
    
  })
  
  
  observeEvent(input$subchekupQ, {
    #
    datacheck=sqlQuery(connect,paste("SELECT * from dbpfedev.medical_checkup"))
    
    validate(
      need(input$Lesion_Number>= -1, "Error : Missing values")
    )

        querycheckinpfe <- paste0(
      "INSERT INTO  medical_checkup
      VALUES ('", toString(paste0("Medical-check",length(datacheck[,1])+1)) ,"', '",toString( input$datecheck ) ,"','",toString(input$interrID)  ,"', '",toString( input$PatIdentifier) ,"','",toString( USER$name ) ,"','",toString( input$hospital) ,"', '",toString( input$pysicien ) ,"','",toString( input$sampler) ,"','",toString( input$Ahost) ,"','",toString( input$HhostR) ,"','",toString( input$HhostL) ,"','",toString( input$clinstate) ,"','",input$Lesion_Number ,"','",toString(input$Lesion_Sites) ,"',NULL) ") 
    
    validate(
      need(try(   sqlExecute(connect,query = querycheckinpfe) ), info("Error : Row already exists"))
    )
    
    info("Medical checkUp successfully added")
    
    output$patdataout=renderUI ({
      div(
        DT::dataTableOutput("datt"),
        actionButton("addregion","Travel/Residency"),
        actionButton("addcheckup","Add Medical check-UP"),
        actionButton("addhisttreat","Add Historical Treatment "),
        actionButton("addhisttreat2","Add Treatment "),
        actionButton("addsample","Add Sample "),
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
  
  observeEvent(input$otheryreatmentAdd, {
    
    ############
    validate( need(input$injectionnumber>=-1, info("Error : Missing values")) )
    datamytreatment2=sqlQuery(connect,paste("SELECT * from dbpfedev.treatmenthistory"))
    
    querytreatpfe <- paste0(
      "INSERT INTO  treatmenthistory
      VALUES ( '", toString(paste0("Treatment",length(datamytreatment2[,1])+1)) ,"','", toString(input$PatIdentifier) ,"', '",toString( input$treattype) ,"', '",toString( input$prescribed) ,"', '",as.character( input$datetreatbeg) ,"', '",toString( input$Posology) ,"', '",toString( input$admin) ,"','",input$injectionnumber ,"','",as.character( input$datetreatend) ,"','",as.character( input$healing) ,"') ")
    
    validate(
      need(try(   sqlExecute(connect,query = querytreatpfe) ), "Error : row already exists")
    )
    info("Treatment successfully stored")
    shinyjs::reset("formTreatment")
  })
  
  observeEvent(input$subtreatmentQ, {
    
    ############
    validate(
      need(input$injectionnumber>=-1, "Error : Missing values")
    )
    treatmenthistory=sqlQuery(connect,paste("SELECT * from dbpfedev.treatmenthistory"))
    
    querytreatpfe <- paste0(
      "INSERT INTO  treatmenthistory
      VALUES ( '", toString(paste0("Treatment",length(treatmenthistory[,1])+1)) ,"','", toString(input$PatIdentifier) ,"', '",toString( input$treattype) ,"', '",toString( input$prescribed) ,"', '",as.character( input$datetreatbeg) ,"', '",toString( input$Posology) ,"', '",toString( input$admin) ,"','",input$injectionnumber ,"','",as.character( input$datetreatend) ,"','",as.character( input$healing) ,"') ")
    
    validate(
      need(try(   sqlExecute(connect,query = querytreatpfe)), "Error : Row already exists")
    )
    info("Treatment successfully stored")
    shinyjs::reset("formTreatment")
    ################
    
    output$patdataout=renderUI ({
      div(
        DT::dataTableOutput("datt"),
        actionButton("addregion","Travel/Residency"),
        actionButton("addcheckup","Add Medical check-UP"),
        actionButton("addhisttreat","Add Historical Treatment "),
        actionButton("addhisttreat2","Add Treatment "),
        actionButton("addsample","Add Sample "),
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
    
    datatrav=sqlQuery(connect,paste("SELECT * from dbpfedev.travel_residency"))
    #validate(need( input$datedatevisit < input$dateleavevisit  ,"Incorrect dates"))
    #validate(need(as.character(input$dateleavevisit) !="","Incorrect dates"))
    if((!as.character(input$datedatevisit) <= Sys.Date()) && (as.character(input$datedatevisit) !=""))
    {info("Incorrect dates")}
    validate(need(as.character(input$datedatevisit) <= Sys.Date(),"Incorrect dates"))
    validate(need(as.character(input$datedatevisit) !="","Incorrect dates"))
    querytravinpfe <- paste0(
      "INSERT INTO  travel_residency(`IDMVT`, `CITY`, `LOGINUSER` ,`PATIENT_IDENTIFIER`, `FROMDATE`,`TODATE`, `BYTENOT`, `RESIDENCY`,`TYPE`)
      VALUES ('", toString(paste0(input$PatIdentifier,"-",length(datatrav[,1])+1)) ,"', '",input$regvisit ,"', '",paste0(USER$name),"','",toString(input$PatIdentifier),"', '",as.character( input$datedatevisit )  ,"', '",as.character( input$dateleavevisit )  ,"', '",toString( input$bybyte ) ,"', '",toString( input$resedent ) ,"', '",toString( input$Type ) ,"') ")
    
    
    
    validate(
      need(try(    sqlExecute(connect,query = querytravinpfe)), "Error : Row already exists")
    )
    
    
    info(" successfully added")
    shinyjs::reset("formtravel")
  })
  
  observeEvent(input$subregionQ, {
    
    datatrav=sqlQuery(connect,paste("SELECT * from dbpfedev.travel_residency"))
    #validate(need(as.character(input$dateleavevisit) !="","Incorrect dates"))
    if((!as.character(input$datedatevisit) <= Sys.Date()) && (as.character(input$datedatevisit) !=""))
    {info("Incorrect dates")}
    validate(need(as.character(input$datedatevisit) <= Sys.Date(),"Incorrect dates"))
    validate(need(as.character(input$datedatevisit) !="","Incorrect dates"))
    
    querytravinpfe <- paste0(
      "INSERT INTO  travel_residency(`IDMVT`, `CITY`, `LOGINUSER`, `PATIENT_IDENTIFIER`, `FROMDATE`,`TODATE`, `BYTENOT`, `RESIDENCY`,`TYPE`)
      VALUES ( '", toString(paste0(input$PatIdentifier,"-",length(datatrav[,1])+1)) ,"','",input$regvisit ,"', '",paste0(USER$name),"','",toString( input$PatIdentifier ) ,"', '",as.character( input$datedatevisit ) ,"', '",as.character( input$dateleavevisit ) ,"', '",toString( input$bybyte ) ,"', '",toString( input$resedent ) ,"', '",toString( input$Type ) ,"') ")
    
    
    validate(
      need(try(    sqlExecute(connect,query = querytravinpfe)), "Error : Row already exists")
    )
    info(" successfully added")
    #shinyjs::reset("formtravel")
    output$patdataout=renderUI ({
      div(
        DT::dataTableOutput("datt"),
        actionButton("addregion","Travel/Residency"),
        actionButton("addcheckup","Add Medical check-UP"),
        actionButton("addhisttreat","Add Historical Treatment "),
        actionButton("addhisttreat2","Add Treatment "),
        actionButton("addsample","Add Sample "),
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
  
  
  
  observeEvent(input$subSampleQ, {
    
    #
    datasample=sqlQuery(connect,paste("SELECT  * from dbpfedev.sample "))
    
    validate(
      need(input$diamlesionMax>=-1, "Error : Missing values")
    )
    validate(
      need(input$diamlesionMin>=-1, "Error : Missing values")
    )
    validate(
      need(input$highlesion>=-1, "Error : Missing values")
    )
    #############################################################""
    ###########################################################""
    ############################################################""
    datasample=sqlQuery(connect,paste("SELECT  * from dbpfedev.sample "))
    querysampleinpfe <- paste0(
      "INSERT INTO  sample
      VALUES ('", paste0(paste0(input$PatIdentifier,"-",length(datasample[,1])+1)) ,"', '",toString( input$PatIdentifier ) ,"', '",toString("Not Identified") ,"', '",toString( USER$name ) ,"', '",toString( input$Lesionsite) ,"', '",toString( input$sammeth ) ,"','",toString( input$samplsupport) ,"','",toString( input$directexam) ,"','",toString( input$abandance) ,"','",toString( input$apparitionlesion) ,"','",input$diamlesionMax,"','",input$diamlesionMin,"','",input$highlesion,"','",toString( input$locallesion) ,"','",toString( input$descriptionlesion) ,"','",as.character( input$extractDay),"') ")
    validate(
      need(try(     sqlExecute(connect,query = querysampleinpfe)), "Error : Row already exists")
    )
    observe({updateSelectInput(session,"sample","",choices =  c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT ID_SAMPLE from dbpfedev.sample where PATIENT_IDENTIFIER='%s'",paste(input$PatIdentifier))))$ID_SAMPLE))  )})
    
    output$patdataout=renderUI ({
      div(
        DT::dataTableOutput("datt"),
        actionButton("addregion","Travel/Residency"),
        actionButton("addcheckup","Add Medical check-UP"),
        actionButton("addhisttreat","Add Historical Treatment "),
        actionButton("addhisttreat2","Add Treatment "),
        actionButton("addsample","Add Sample "),
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
    alert(paste0(paste0(input$PatIdentifier,"-",length(datasample[,1])+1)))
    
  })
  
  observeEvent(input$otherSampleAdd, {
    
    
    
    datasample=sqlQuery(connect,paste("SELECT * from dbpfedev.sample "))
    
    validate(
      need(input$diamlesionMax>=-1, "Error : Missing values")
    )
    validate(
      need(input$diamlesionMin>=-1, "Error : Missing values")
    )
    validate(
      need(input$highlesion>=-1, "Error : Missing values")
    )
    
    querysampleinpfe <- paste0(
      "INSERT INTO  sample
      VALUES ('",paste0(paste0(input$PatIdentifier,"-",length(datasample[,1])+1)),"', '",toString( input$PatIdentifier ) ,"', '",toString("Not Identified") ,"', '",toString( USER$name ) ,"', 'N/A', '",toString( input$sammeth ) ,"','",toString( input$samplsupport) ,"','",toString( input$directexam) ,"','",toString( input$abandance) ,"','",toString( input$apparitionlesion) ,"','",input$diamlesionMax,"','",input$diamlesionMin,"','",input$highlesion,"','",toString( input$locallesion) ,"','",toString( input$descriptionlesion) ,"','",as.character( input$extractDay),"')  ")
    
    validate(
      need(try(     sqlExecute(connect,query = querysampleinpfe)), "Error : Row already exists")
    )
    info("Sample successfully added")
    observe({updateSelectInput(session,"sample","",choices =  c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT ID_SAMPLE from dbpfedev.sample where PATIENT_IDENTIFIER='%s'",paste(input$PatIdentifier))))[,"ID_SAMPLE"]))  )})
    
    #
    alert(paste0("Sample Added",length(datasample[,1])+1))
    output$AdddSample=renderUI({
      output$firsttimeID=renderUI({
      })
      output$patennt=renderUI({
      })
      
      output$patdataout=renderUI ({
      })
      alert(paste0(paste0(input$PatIdentifier,"-",length(datasample[,1])+1)))
      
      
      
      
      
      
      div(
        
        box( width = 12, status = "info",solidHeader = TRUE,
              #column("",selectInput("Lesionsite","Lesion site sampled",choices = c("","Face", "Upper limbs","Lower limbs","Trunc","Other","N/A"),multiple = TRUE), width = 4 ),
              #column("",selectInput("Lesionsite","Lesion Sites",choices = c("",-1,1:45),multiple=TRUE), width = 4),
              column("",selectInput("samplsupport","Type of sample support",choices = c("","TE","Slide", "Filter paper","Saline","RNA later","N/A"),multiple = TRUE), width = 4),
              column("",selectInput("sammeth","Sampling Method",choices = c("","Scrapping","aspiration","biopsy","Dental broch","Swab","N/A"),multiple = TRUE), width = 4),
        
              column("",selectInput("directexam","Direct examination result",choices = c("","Positive","Negative","N/A")), width = 4),
              column("",selectInput("abandance","Abundance on the smear", c("", "+","++","+++","++++","+++++","++++++","N/A")), width = 4),
              column("",dateInput("apparitionlesion","Lesion first appearence",value="1900-01-01") , width = 4),
        
             
             column("",numericInput("diamlesionMax","lesion Diameter Maximal(millimeter) (*)","") , width = 4),
             column("",numericInput("diamlesionMin","lesion Diameter Minimal(millimeter) (*)","") , width = 4),
             column("",numericInput("highlesion","lesion Hight(millimeter) (*)","") , width = 4),
             
              column("",selectInput("locallesion","Lesion localisation",choices = c("",-1,1:45)) , width = 2),
              column("",selectInput("extractDay","Sampling date",choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT DATE_MED from medical_checkup where PATIENT_IDENTIFIER = '%s'",as.character(input$PatIdentifier))))$DATE_MED))) ), width = 2),
              column("",selectizeInput("descriptionlesion","Lesion description",choices=c("","Ulcerative crusty","Dry","Wet","Surrounded by a hyperpigmented rim","Nodules pseudosporotrichoides","Pseudotumoral","Infected","Surrounded by a erythematouseruption","lupoid","Papulo-nodular","Other","N/A"),multiple=TRUE) , width = 4)
        ),
        actionButton("subSampleQ","Submit and Quit"),
        actionButton("subballiq","Enter Alliquot data"),
        actionButton("otherSampleAdd"," Submit and add other samples"),
        actionButton("editsample","Edit"),
        actionButton("cansAddinfo","Cancel")
      )
    })
    
  })
  
  observeEvent(input$submitIDpfe, {
    
    shinyjs::reset("forminv")
    
  })
  observeEvent(input$submitIDpfe, {
    queryinterrpfe <- paste0(
      "INSERT INTO  interrogator
      VALUES ('", input$cini ,"', '",toString( USER$name ) ,"', '",toString( input$nomi ) ,"', '",toString(input$prenomi) ,"','",toString( input$qual) ,"') ")
    
    validate(
      need(try(       sqlExecute(connect,query = queryinterrpfe)), "Error : Row already exists")
    )
    info("Interrogator successfully added")
    updateSelectInput (session,"interrID",label="Interrogator ID",choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT ID_INTERROGATOR from dbpfedev.interrogator")))$ID_INTERROGATOR))))
    
    
  })
  
  observeEvent(input$submitDiag, {
    datadiagnosis=sqlQuery(connect,paste("SELECT * from dbpfedev.diognosis"))
    querydiagpfe <- paste0(
      "INSERT INTO  diognosis
      VALUES ( '", toString(paste0("Diagnosis",length(datadiagnosis[,1])+1)) ,"','",toString( input$chemtest ) ,"','", toString(input$labname) ,"', '",toString(input$sample) ,"','",toString( input$dattest) ,"','",toString( input$quantity) ,"','",toString( input$restest) ,"','", toString(input$susSpec) ,"') ")
    
    validate(
      need(try(      sqlExecute(connect,query = querydiagpfe)), "Error : Row already exists")
    )
    
    info("Diagnosis successfully added")
    shinyjs::reset("formDiagnos")
  })
  
  observeEvent(input$subpfelab , {
    querylabpfe <- paste0(
      "INSERT INTO laboratory
      VALUES ('", toString( input$labnamo ) ,"', '",toString( USER$name ) ,"', '",toString( input$counlab ) ,"') ")
    
    validate(
      need(try(       sqlExecute(connect, querylabpfe)), "Error : Row already exists")
    )
    info("Laboratory successfully added" )
    shinyjs::reset("formlaab")
    updateSelectInput(session,"labname","Laboratory",choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT LABORATORY_NAME from dbpfedev.laboratory")))$LABORATORY_NAME))))
    
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
                  column(3,  h5(actionLink("selecthome2","Home page",icon = icon("list-alt"))))),
              box(width = 2, status = "info",solidHeader = TRUE,
                  column(3,  h5(actionLink("selectMang1","Data Management",icon = icon("list-alt"))))),
              box(width = 2, status = "info",solidHeader = TRUE,
                  column(3,  h5(actionLink("selectDatAdd2.1","Data Entry",icon = icon("list-alt"))))),
              box(width = 2, status = "info",solidHeader = TRUE,
                  column(3,  h5(actionLink("selectDatView2_1","Data Viewer" ,icon = icon("table"))))),
              box(width = 2, status = "info",solidHeader = TRUE,
                  column(3,  h5(actionLink("selectDatAna2_1","Data Analysor",icon = icon("bar-chart-o"))))),
              box(width = 2, status = "info",solidHeader = TRUE,
                  column(3,  h5(actionLink("selectpub2_1","Publication Consultor" ,icon = icon("refresh"))))))
          )
          
      )
    }
  })
  
  
  output$appkey2=renderUI({
    if (USER$Logged == TRUE) {
      box(width = 4 , status = "info",solidHeader = TRUE,
          div(
            fluidRow(
              box(width = 12, status = "info",solidHeader = TRUE,
                  column(8,  h5(actionLink("selecthome2.1","Home page",icon = icon("list-alt"))))),
              box(width = 12, status = "info",solidHeader = TRUE,
                  column(8,  h5(actionLink("selectMang2","Data Management",icon = icon("list-alt"))))),
              box(width = 12, status = "info",solidHeader = TRUE,
                  column(8,  h5(actionLink("selectDatAdd2.2","Data Entry",icon = icon("list-alt"))))),
              box(width = 12, status = "info",solidHeader = TRUE,
                  column(8,  h5(actionLink("selectDatView2_2","Data Viewer" ,icon = icon("table"))))),
              box(width = 12, status = "info",solidHeader = TRUE,
                  column(8,  h5(actionLink("selectDatAna2_2","Data Analysor",icon = icon("bar-chart-o"))))),
              box(width = 12, status = "info",solidHeader = TRUE,
                  column(8,  h5(actionLink("selectpub2_2","Publication Consultor" ,icon = icon("refresh"))))))
          )
          
      )
    }
  })
  
  output$appkey3=renderUI({
    if (USER$Logged == TRUE) {
      box(width = 4 , status = "info",solidHeader = TRUE,
          div(
            fluidRow(
              box(width = 12, status = "info",solidHeader = TRUE,
                  column(8,  h5(actionLink("selecthome2.2","Home page",icon = icon("list-alt"))))),
              box(width = 12, status = "info",solidHeader = TRUE,
                  column(8,  h5(actionLink("selectMang3","Data Management",icon = icon("list-alt"))))),
              box(width = 12, status = "info",solidHeader = TRUE,
                  column(8,  h5(actionLink("selectDatAdd2.3","Data Entry",icon = icon("list-alt"))))),
              box(width = 12, status = "info",solidHeader = TRUE,
                  column(8,  h5(actionLink("selectDatView2_3","Data Viewer" ,icon = icon("table"))))),
              box(width = 12, status = "info",solidHeader = TRUE,
                  column(8,  h5(actionLink("selectDatAna2_3","Data Analysor",icon = icon("bar-chart-o"))))),
              box(width = 12, status = "info",solidHeader = TRUE,
                  column(8,  h5(actionLink("selectpub2_3","Publication Consultor" ,icon = icon("refresh"))))))
          )
          
      )
    }else{  USER$Logged <- FALSE
    USER$pass <- ""
    newvalue <- "acc2"
    updateTabItems(session, "tabs", newvalue)
    addClass(selector = "body", class = "sidebar-collapse")}
  })
  output$appkey4=renderUI({
    if (USER$Logged == TRUE) {
      box(width = 4 , status = "info",solidHeader = TRUE,
          div(
            fluidRow(
              box(width = 12, status = "info",solidHeader = TRUE,
                  column(8,  h5(actionLink("selecthome2.3","Home page",icon = icon("list-alt"))))),
              box(width = 12, status = "info",solidHeader = TRUE,
                  column(8,  h5(actionLink("selectMang4","Data Management",icon = icon("list-alt"))))),
              box(width = 12, status = "info",solidHeader = TRUE,
                  column(8,  h5(actionLink("selectDatAdd2.4","Data Entry",icon = icon("list-alt"))))),
              box(width = 12, status = "info",solidHeader = TRUE,
                  column(8,  h5(actionLink("selectDatView2_4","Data Viewer" ,icon = icon("table"))))),
              box(width = 12, status = "info",solidHeader = TRUE,
                  column(8,  h5(actionLink("selectDatAna2_4","Data Analysor",icon = icon("bar-chart-o"))))),
              box(width = 12, status = "info",solidHeader = TRUE,
                  column(8,  h5(actionLink("selectpub2_4","Publication Consultor" ,icon = icon("refresh"))))))
          )
          
      )
    }else{  USER$Logged <- FALSE
    USER$pass <- ""
    newvalue <- "acc2"
    updateTabItems(session, "tabs", newvalue)
    addClass(selector = "body", class = "sidebar-collapse")}
  })
  
  output$appkey5=renderUI({
    if (USER$Logged == TRUE) {
      box(width =15 , status = "info",solidHeader = TRUE,
          div(
            fluidRow(
              box(width = 12, status = "info",solidHeader = TRUE,
                  column(8,  h5(actionLink("selecthome2.5","Home page",icon = icon("list-alt"))))),
              box(width = 12, status = "info",solidHeader = TRUE,
                  column(8,  h5(actionLink("selectMang5","Data Management",icon = icon("list-alt"))))),
              box(width = 12, status = "info",solidHeader = TRUE,
                  column(8,  h5(actionLink("selectDatAdd2.5","Data Entry",icon = icon("list-alt"))))),
              box(width = 12, status = "info",solidHeader = TRUE,
                  column(8,  h5(actionLink("selectDatView2_5","Data Viewer" ,icon = icon("table"))))),
              box(width = 12, status = "info",solidHeader = TRUE,
                  column(8,  h5(actionLink("selectDatAna2_5","Data Analysor",icon = icon("bar-chart-o"))))),
              box(width = 12, status = "info",solidHeader = TRUE,
                  column(8,  h5(actionLink("selectpub2_5","Publication Consultor" ,icon = icon("refresh"))))))
          )
          
      )
    }else{  USER$Logged <- FALSE
    USER$pass <- ""
    newvalue <- "acc2"
    updateTabItems(session, "tabs", newvalue)
    addClass(selector = "body", class = "sidebar-collapse")}
  })
  
  observeEvent(input$subballiq, {
    
    output$AdddSample=renderUI({
    })
    output$alliquot=renderUI({
      
      if (USER$Logged == TRUE) {
        div(
          id="formAlliquote",
          box(width = 12, status = "info",solidHeader = TRUE,
              column("",selectInput("sampleIDD","Sample",
                                    
                                    choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT ID_SAMPLE from dbpfedev.sample where PATIENT_IDENTIFIER='%s'",paste(input$PatIdentifier))))$ID_SAMPLE))
                                    ))
                     , width = 4 ),
              column("",numericInput("voll","Quantity in nanogramme",""), width = 4),
              
              column("",selectInput("val","Type",choices = c('Azote','R80',"N/A")), width = 4),
              column("",selectInput("RakPFE","Container",choices = c(1:4)), width = 4),
              column("",uiOutput("ttt"), width = 4),
              column("",textInput("conserve","Boite",""), width = 4),
              column("",selectInput("posPFE","Position",choices = c(1:100)), width = 12)
          ),
          actionButton("suballiquotQ","Submit"),
          actionButton("cansAddalliquot","Cancel")
        )
      }
    })
  })
  
  #  observeEvent(input$suballiquotQ, {
  #    dataall=sqlQuery(connect,paste("SELECT * from dbpfedev.alliquot"))
  #    queryall= paste0("INSERT INTO alliquot
  #                     VALUES ('", toString(paste0("Alliquot",length(dataall[,1])+1)) ,"','",toString(input$sampleIDD)  ,"', '",toString( USER$name ) ,"','",input$voll,"','",toString(paste0( input$val, "/", input$RakPFE,"/", input$valL,"/", input$conserve,"/", input$posPFE))  ,"') ")
  #    
  #    validate(
  #      need(try(       sqlExecute(connect,query = queryall)), "Error : Missing values or User already exists")
  #    )
  #    info("Alliquot successfully stored")
  #    shinyjs::reset("formAlliquote")
  #  })
  
  observeEvent(input$suballiquotQ, {
    dataall=sqlQuery(connect,paste("SELECT * from dbpfedev.alliquot"))
    queryall= paste0("INSERT INTO alliquot
                     VALUES ('", toString(paste0(input$sampleIDD,length(dataall[,1])+1)) ,"','",toString(input$sampleIDD)  ,"', '",toString( USER$name ) ,"','",input$voll,"','",toString(paste0( input$val, "/", input$RakPFE,"/", input$valL,"/", input$conserve,"/", input$posPFE))  ,"') ")
    
    validate(
      need(try(       sqlExecute(connect,query = queryall)), "Error : Row already exists")
    )
    info("Alliquot successfully stored")
    shinyjs::reset("formAlliquote")
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
      alert(paste0(paste0(input$PatIdentifier,"-",length(datasample[,1])+1)))
      
      div(
        
        id="formSample2",
        
        box( width = 12, status = "info",solidHeader = TRUE,
              #column("",selectInput("Lesionsite","Lesion site sampled",choices = c("","Face", "Upper limbs","Lower limbs","Trunc","Other","N/A"),multiple = TRUE), width = 4 ),
              #column("",selectInput("Lesionsite","Lesion Sites",choices = c("",-1,1:45),multiple=TRUE), width = 4),
              column("",selectInput("samplsupport","Type of sample support",choices = c("","TE","Slide", "Filter paper","Saline","RNA later","N/A"),multiple = TRUE), width = 4),
              column("",selectInput("sammeth","Sampling Method",choices = c("","Scrapping","aspiration","biopsy","Dental broch","Swab","N/A"),multiple = TRUE), width = 4),

               column("",selectInput("directexam","Direct examination result",choices = c("","Positive","Negative","N/A")), width = 4),
               column("",selectInput("abandance","Abundance on the smear", c("", "+","++","+++","++++","+++++","++++++","N/A")), width = 4),
               column("",dateInput("apparitionlesion","Lesion first appearence",value="1900-01-01") , width = 4),
      
             
             column("",numericInput("diamlesionMax","lesion Diameter Maximal(millimeter) (*)","") , width = 4),
             column("",numericInput("diamlesionMin","lesion Diameter Minimal(millimeter) (*)","") , width = 4),
             column("",numericInput("highlesion","lesion Hight(millimeter) (*)","") , width = 4),
             
               column("",selectInput("locallesion","Lesion localisation",choices = c("",-1,1:45)) , width = 2 ),
               column("",selectInput("extractDay","Sampling date",choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT DATE_MED from medical_checkup where PATIENT_IDENTIFIER = '%s'",as.character(input$PatIdentifier))))$DATE_MED))) ), width = 2),
               column("",selectizeInput("descriptionlesion","Lesion description",choices=c("","Ulcerative crusty","Dry","Wet","Surrounded by a hyperpigmented rim","Nodules pseudosporotrichoides","Pseudotumoral","Infected","Surrounded by a erythematouseruption","lupoid","Other","N/A"),multiple=TRUE) , width = 4)
        ),
        actionButton("subSampleQ","Submit and Quit"),
        actionButton("subballiq","Enter Alliquot data"),
        actionButton("otherSampleAdd"," Submit and add other samples"),
        actionButton("editsample","Edit"),
        actionButton("cansAddinfo","Cancel")
      )
    })
  })
  
  output$visualisation=renderUI({
    if (USER$Logged == TRUE) {
      
      
      who=sqlQuery(connect ,paste("SELECT * from userdata "))
      if (who[which(who[,1]== USER$name ),4]== "super" ){
        tabBox(
          id="viewdata",
          title = tagList( ""),
          width = 10,
          height = 4,
          
          tabPanel(h4(strong("Tables View")),
                   uiOutput("viewtable")),
          
          tabPanel(h4(strong("Patients Calendar")),
                   
                   div(htmlOutput("calendar"),
                       uiOutput("calendarDB"))),
          tabPanel(h4(strong("Monthly patients")),
                   
                   dygraphOutput("monthview"),
                   uiOutput("MPNuDB")),
          tabPanel(h4(strong("Partition")),
                   uiOutput("PieChart"),
                   uiOutput("PieNvDB")),
          tabPanel(h4(strong("Patients map")),
                   uiOutput("SpeciesMapView"),
                   uiOutput("MapDB"))
          
        )
      }else{
        
        tabBox(
          id="viewdata",
          title = tagList( ""),
          width = 10,
          height = 4,
          tabPanel(h4(strong("Tables View")),
                   uiOutput("viewtable2"))#,
          
          #tabPanel(h4(strong("Patients Calendar")),
          #         div( htmlOutput("calendar2"),
          #              uiOutput("calendarDB2"))),
          #tabPanel(h4(strong("Monthly patients")),
          #         dygraphOutput("monthview2"),
          #         uiOutput("MPNuDB2")),
          
          #tabPanel(h4(strong("Partition")),
          #         uiOutput("PieChart2"),
          #         uiOutput("PieNvDB2")),
          #tabPanel(h4(strong("Patients map")),
          #         uiOutput("SpeciesMapViewN"),
          #         uiOutput("MapDB2"))
          
          
        )
        
      }
      
      
      
    }else{ USER$Logged <- FALSE
    USER$pass <- ""
    newvalue <- "acc2"
    updateTabItems(session, "tabs", newvalue)
    addClass(selector = "body", class = "sidebar-collapse")}
  })
  
  
  
  
  output$tables2=renderUI({
    taables=sqlTables(connect, errors = FALSE, as.is = TRUE,
                      catalog = NULL, schema = NULL, tableName = NULL,
                      tableType = NULL, literal = FALSE)
    opt=taables[,3]
    cho=opt[c(1,3,4,6,8,10,11)]
    selectInput("ttest2", "",choices=cho)
    
  })
  
  
  
  
  
  
  datas2= reactive({
    
    
    All=sqlQuery(connect,paste("SELECT * from dbpfedev.",input$ttest2))
    #hhh= All[which(All[,"LOGINUSER"]==USER$name),]
    #hhh=All
  })
  
  output$datas2= DT::renderDataTable ({
    
    DT::datatable(datas2(), options = list(scrollX = TRUE,lengthMenu = c(5, 10,15) ,pageLength = 5))
    
  })
  
  output$viewtable2=renderUI({
    if(USER$Logged==TRUE ){
      fluidRow(
        box(width = 4, status = "info",solidHeader = TRUE,
            title = "Choose table to View",
            helpText(tags$b("This section enable you to see content of all tables of data base  ")),
            tags$hr(),
            uiOutput("tables2")
        ),
        box(width = 7, status = "info",solidHeader = FALSE,
            DT::dataTableOutput("datas2")
        )
      )}else{  USER$Logged <- FALSE
      USER$pass <- ""
      newvalue <- "acc2"
      updateTabItems(session, "tabs", newvalue)
      addClass(selector = "body", class = "sidebar-collapse")}
    
    
  })
  
  
  
  
  output$monthview=renderDygraph({
    totalChUp=sqlQuery(connect,paste("SELECT * from dbpfedev.medical_checkup"))
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
    totalChUp2=sqlQuery(connect,paste("SELECT * from dbpfedev.medical_checkup"))
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
                 uiOutput("Random")),
        tabPanel(h4(strong("Patient cases Prediction")),
                 plotOutput("boxmP"),
                 uiOutput("PCP1DB"),
                 uiOutput("tSSS"),
                 uiOutput("PCP2DB")),
        tabPanel(h4(strong("Correlation")),
                 uiOutput("CrossTablecor"),
                 uiOutput("CorrDB")),
        tabPanel(h4(strong("Regression")),
                 uiOutput("Reg")),
        tabPanel(h4(strong("ACM")),
                 fluidRow(div(   uiOutput("CAMM") ) ))
      )
    }else{ USER$Logged <- FALSE
    USER$pass <- ""
    newvalue <- "acc2"
    updateTabItems(session, "tabs", newvalue)
    addClass(selector = "body", class = "sidebar-collapse")}
  })
  
  preddata=reactive({
    totalChUp2=sqlQuery(connect,paste("SELECT * from dbpfedev.medical_checkup"))
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
    totalChUp2=sqlQuery(connect,paste("SELECT * from dbpfedev.medical_checkup"))
    TSD=totalChUp2[,"DATE_MED"]
    TSD2=ts(preddata(),start =as.numeric(format(as.Date(TSD[length(TSD)], format="%Y/%m/%d"),"%Y"))+1,frequency = 12) 
    
    dygraph(TSD2)%>% dyOptions(stackedGraph = TRUE) %>% dyRangeSelector() })
  
  
  
  
  
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
    AAllPIE=sqlQuery(connect,paste("SELECT * from dbpfedev.",input$ttestPIE))
    is.fact10 <- sapply(AAllPIE, is.factor)
    AAllPIE=data.frame( AAllPIE[, is.fact10])
    selectInput("ttestPIEnames", "",choices=c(colnames(AAllPIE)))
    
  })
  
  output$pie=renderPlot({
    dataPIE=sqlQuery(connect,paste("SELECT * from dbpfedev.",input$ttestPIE))
    
    Levels=dataPIE[,input$ttestPIEnames] 
    ggplot(dataPIE, aes(x = factor(1),fill =Levels )) + geom_bar(width = 1)+ coord_polar(theta = "y")
  })
  
  output$PieChart=renderUI({
    if(USER$Logged==TRUE ){
      fluidRow(
        box(width = 4, status = "info",solidHeader = TRUE,
            title = "Choose table to View",
            
            tags$hr(),
            uiOutput("tableschartPIE")
        ),
        box(width = 4, status = "info",solidHeader = TRUE,
            title = "Choose table to View",
            tags$hr(),
            uiOutput("nameschartPIE")
        ),
        box(width = 6, status = "info",solidHeader = FALSE,
            plotOutput("pie")
        )
      )}else{  USER$Logged <- FALSE
      USER$pass <- ""
      newvalue <- "acc2"
      updateTabItems(session, "tabs", newvalue)
      addClass(selector = "body", class = "sidebar-collapse")}
    
    
  })
  
  
  #############################################
  output$tableschartPIE2=renderUI({
    taablesPIE2=sqlTables(connect, errors = FALSE, as.is = TRUE,
                          catalog = NULL, schema = NULL, tableName = NULL,
                          tableType = NULL, literal = FALSE)
    selectInput("ttestPIE2", "",choices=taablesPIE2[c(1,3,4,10,8,6),3])
    
  })
  
  
  output$nameschartPIE2= renderUI({
    AAllPIE2=sqlQuery(connect,paste("SELECT * from dbpfedev.",input$ttestPIE2))
    is.fact11 <- sapply(AAllPIE2, is.factor)
    AAllPIE2=data.frame( AAllPIE2[, is.fact11])
    selectInput("ttestPIEnames2", "",choices=c(colnames(AAllPIE2)))
    
  })
  
  output$pie2=renderPlot({
    dataPIE2=sqlQuery(connect,paste("SELECT * from dbpfedev.",input$ttestPIE2))
    dataPIE2N=dataPIE2[c(which(dataPIE2$LOGINUSER== USER$name)),]
    
    Levels=dataPIE2N[,input$ttestPIEnames2] 
    ggplot(dataPIE2N, aes(x = factor(1),fill =Levels )) + geom_bar(width = 1)+ coord_polar(theta = "y")
  })
  
  output$PieChart2=renderUI({
    if(USER$Logged==TRUE ){
      fluidRow(
        box(width = 4, status = "info",solidHeader = TRUE,
            title = "Choose table to View",
            
            tags$hr(),
            uiOutput("tableschartPIE2")
        ),
        box(width = 4, status = "info",solidHeader = TRUE,
            title = "Choose table to View",
            tags$hr(),
            uiOutput("nameschartPIE2")
        ),
        box(width = 6, status = "info",solidHeader = FALSE,
            plotOutput("pie2")
        )
      )}else{  USER$Logged <- FALSE
      USER$pass <- ""
      newvalue <- "acc2"
      updateTabItems(session, "tabs", newvalue)
      addClass(selector = "body", class = "sidebar-collapse")}
    
  })
  
  ###########################################################################
  
  
  
  #############################################################################
  #calandar#
  #############################################################################
  output$calendar=renderGvis ({
    dateMed=as.data.frame( table( sqlQuery(connect,paste("SELECT 	DATE_MED from dbpfedev.medical_checkup"))))
    dateMed$Var1=as.Date(dateMed$Var1)
    
    
    Cal <- gvisCalendar(dateMed, 
                        datevar="Var1", 
                        numvar="Freq",
                        options=list(
                          title="Daily Patients",
                          height=320,
                          calendar="{yearLabel: { fontName: 'Times-Roman',
                          fontSize: 32, color: '#1A8763', bold: true},
                          cellSize: 10,
                          cellColor: { stroke: 'red', strokeOpacity: 0.2 },
                          focusedCellColor: {stroke:'red'}}")
                        )
    
})
  ###############################################################################
  output$calendar2=renderGvis ({
    dateMed=as.data.frame( table( sqlQuery(connect,paste("SELECT 	DATE_MED,LOGINUSER from dbpfedev.medical_checkup"))))
    dateMed$DATE_MED=as.Date(dateMed$DATE_MED)
    dateMed=dateMed[which(dateMed$LOGINUSER==USER$name),]
    
    Cal <- gvisCalendar(dateMed, 
                        datevar="DATE_MED", 
                        numvar="Freq",
                        options=list(
                          title="Daily Patients",
                          height=320,
                          calendar="{yearLabel: { fontName: 'Times-Roman',
                          fontSize: 32, color: '#1A8763', bold: true},
                          cellSize: 10,
                          cellColor: { stroke: 'red', strokeOpacity: 0.2 },
                          focusedCellColor: {stroke:'red'}}")
                        )
    
    })
  
  ##########################################################################################
  #MAP#
  ##########################################################################################
  
  output$CountriesShopUI=renderUI({
    countrie= unique( sqlQuery(connect,paste("SELECT COUNTRY_	 from dbpfedev.region")))
    
    selectInput("countriesshop", "",choices=countrie$COUNTRY_)
    
  })
  
  output$especeUI=renderUI({
    espece= unique( sqlQuery(connect,paste("SELECT SPECIES	 from dbpfedev.sample")))
    
    selectInput("especesshop", "",choices=espece$SPECIES)
    
  })
  
  
  output$SpeciesMAP=renderPlot ({
    
    
    
    sam= sqlQuery(connect,paste("SELECT SPECIES,PATIENT_IDENTIFIER	 from dbpfedev.sample"))
    reg=sqlQuery(connect,paste("SELECT COUNTRY_,CITY	 from dbpfedev.region"))
    town=sqlQuery(connect,paste("SELECT CITY,PATIENT_IDENTIFIER	 from dbpfedev.travel_residency"))
    
    regC=reg[which(reg[,"COUNTRY_"]== input$countriesshop) ,]
    
    
    Tab=sqldf("select CITY,SPECIES from  sam, town
              
              where   sam.PATIENT_IDENTIFIER=town.PATIENT_IDENTIFIER ")
    TabPl=Tab[which(Tab$CITY %in% regC$CITY),]
    TabSl=TabPl[which(TabPl[,"SPECIES"]== input$especesshop),]
    TabSl=as.data.frame(TabSl)
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
        box(width = 4, status = "info",solidHeader = TRUE,
            title = "Choose Country",
            
            tags$hr(),
            uiOutput("CountriesShopUI")
        ),
        box(width = 4, status = "info",solidHeader = TRUE,
            title = "Choose Species",
            tags$hr(),
            uiOutput("especeUI")
        ),
        box(width = 6, status = "info",solidHeader = FALSE,
            plotOutput("SpeciesMAP")
        )
      )}else{  USER$Logged <- FALSE
      USER$pass <- ""
      newvalue <- "acc2"
      updateTabItems(session, "tabs", newvalue)
      addClass(selector = "body", class = "sidebar-collapse")}
    
  })
  
  ###########################################################################################
  
  
  output$SpeciesMAPN=renderPlot ({
    
    mapK <- get_map(location = input$countriesshop, zoom = 6)
    
    sam= sqlQuery(connect,paste("SELECT SPECIES,PATIENT_IDENTIFIER,LOGINUSER	 from dbpfedev.sample"))
    sam=sam[which(sam[,"LOGINUSER"]==USER$name),]
    reg=sqlQuery(connect,paste("SELECT COUNTRY_,CITY	 from dbpfedev.region"))
    town=sqlQuery(connect,paste("SELECT CITY,PATIENT_IDENTIFIER	 from dbpfedev.travel_residency"))
    
    regC=reg[which(reg[,"COUNTRY_"]== input$countriesshop) ,]
    
    
    Tab=sqldf("select CITY,SPECIES from  sam, town
              
              where   sam.PATIENT_IDENTIFIER=town.PATIENT_IDENTIFIER ")
    TabPl=Tab[which(Tab$CITY %in% regC$CITY),]
    TabSl=TabPl[which(TabPl[,"SPECIES"]== input$especesshop),]
    TabSl=as.data.frame(TabSl)
    testttttttt=summaryBy(SPECIES~.,data =TabSl, FUN = length )
    TabOl=as.data.frame(testttttttt)
    
    df2 <- data.frame(location = as.character(TabOl$CITY),
                      values = TabOl$SPECIES.length,
                      stringsAsFactors = FALSE)
    
    
    locs_geo <- geocode(df2$location)
    df2 <- cbind(df2, locs_geo)
    
    
    ggmap(mapK) +
      geom_point(data = df2, aes(x = lon, y = lat, size = values,colour = values))
    
  })
  output$SpeciesMapViewN=renderUI({
    if(USER$Logged==TRUE ){
      fluidRow(
        box(width = 4, status = "info",solidHeader = TRUE,
            title = "Choose Country",
            
            tags$hr(),
            uiOutput("CountriesShopUI")
        ),
        box(width = 4, status = "info",solidHeader = TRUE,
            title = "Choose Species",
            tags$hr(),
            uiOutput("especeUI")
        ),
        box(width = 6, status = "info",solidHeader = FALSE,
            plotOutput("SpeciesMAPN")
        )
      )}else{  USER$Logged <- FALSE
      USER$pass <- ""
      newvalue <- "acc2"
      updateTabItems(session, "tabs", newvalue)
      addClass(selector = "body", class = "sidebar-collapse")}
    
  })
  
  ###########################################################################
  #Time series data#
  ###########################################################################
  
  output$tSSS=renderUI({
    if(USER$Logged==TRUE ){
      fluidRow(
        div(column(1,tableOutput("Predicted"),width = 4),
            column(1,dygraphOutput("Timeseriesplot"),width = 7))
      )}else{  USER$Logged <- FALSE
      USER$pass <- ""
      newvalue <- "acc2"
      updateTabItems(session, "tabs", newvalue)
      addClass(selector = "body", class = "sidebar-collapse")}
  })
  ##############################################################################################
  # Correlation plot#
  ##############################################################################################
  
  cordata=reactive({
    cor1=sqlQuery(connect,paste("SELECT PATIENT_IDENTIFIER,BIRTH_DATE,NATIONALITY,GENDER from dbpfedev.patient"))
    cor3=sqlQuery(connect,paste("SELECT * from dbpfedev.sample"))
    
    
    
    cordataall=sqldf("select * from  cor3, cor1
                     
                     where   cor3.PATIENT_IDENTIFIER=cor1.PATIENT_IDENTIFIER ")
    
    
    PAITIENT_AGE=as.numeric(round((as.Date(cordataall$DATE_EXTRACTION ) - as.Date(cordataall$BIRTH_DATE))/365))
    LESION_AGE=as.numeric(abs(round((as.Date(cordataall$DATE_EXTRACTION ) - as.Date(cordataall$LESION_AGE)))))
    datatot=data.frame(cordataall,PAITIENT_AGE,LESION_AGE)
    datatot$LOCALISATION=as.factor(datatot$LOCALISATION)
    datatot
    
  })
  
  output$corVarUI=renderUI({
    
    
    selectizeInput("corvarstoplot", label=h4("Choose and combine Variables,SPECIES is necessary"), selected = c("SPECIES","GENDER"),choices=c(colnames(cordata()[,-c(1,2,4,6,10,12,13,14,15,16)])),multiple=TRUE)
    
  })
  
  
  output$corrr=renderPlot ({
    Variables=c(input$corvarstoplot)
    d=ggpairs(cordata()[,Variables], mapping = aes(color = SPECIES) , title = "Crossed variables")
    
    d
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
    
    Totlalacm1=cordata()[,-c(1,2,4,6,10,12,13,14,15,16)]
    Age_Class <- cut(round(as.numeric(cordata()$PAITIENT_AGE)), c(0,10,20,30,40,50,60,70,80,120),
                     labels = c("Moins de 10 ans","11-20 ans","21-30 ans","31-40 ans","41-50 ans","51-60 ans", "61-70ans","71-80 ans ","plus de 80 ans" ))
    Lesion_Age_Class <- cut(as.numeric(cordata()$LESION_AGE.1), c(0, 15, 30, 45, 60, 75,90,105),
                            labels = c("moins de deux semaines", "2 - 4 semaines ", "4 - 6 semaines","6 - 8 semaines", 
                                       "8- 10 semaines","10 - 12 ", "plus de 3 mois"))
    
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
                              plotOutput("ACM0" ),
                              uiOutput("ACM_EigDB"))),
                 tabPanel(h5(strong(" Distribution of Modalities")),
                          plotOutput("ACM1"),
                          uiOutput("ACM_DMDB")),
                 tabPanel(h5(strong("Individuels map")),
                          plotOutput("ACM2"),
                          uiOutput("ACM_IMapDB")),
                 tabPanel(h5(strong("Clustring")),
                          plotOutput("clusr"),
                          uiOutput("ACM_ClusDB"))))
      ))
      
    }else{  USER$Logged <- FALSE
    USER$pass <- ""
    newvalue <- "acc2"
    updateTabItems(session, "tabs", newvalue)
    addClass(selector = "body", class = "sidebar-collapse")}
  })
  
  
  
  ###################################################################################
  #                               Relation variables                                #
  ###################################################################################
  
  prepdataNumeric=reactive({
    Totlal=cordata()
    is.num1 <- sapply(Totlal, is.numeric)
    daaaaat=data.frame( Totlal[, is.num1])
    daaaaat
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
                   box(width = 4, status = "info",solidHeader = FALSE,
                       uiOutput("quanti1"),
                       uiOutput("quanti2")),
                   box(width = 8,status = "info",solidHeader = FALSE,
                       div( verbatimTextOutput("resCor1")))
                   
          ),
          tabPanel(h5(strong("ANOVA")),
                   box(width = 4, status = "info",solidHeader = FALSE,
                       uiOutput("quanti3"),
                       uiOutput("quali1")),
                   box(width =9  , status = "info",solidHeader = TRUE, 
                       tableOutput("resCor2")),
                   box(title = "Tukey HSD test", width =12 , status = "info",solidHeader = FALSE,
                       box(width = 4 , status = "info",solidHeader = FALSE,
                           verbatimTextOutput("platuk2")),
                       box(width =7 , status = "info",solidHeader = FALSE,
                           div( plotOutput ("platuk") ) ))),
          tabPanel(h5(strong("Chi square")),
                   box(width = 6, status = "info",solidHeader = FALSE,
                       uiOutput("quali2"),
                       uiOutput("quali3")),
                   htmlOutput("resCor3")  )
          
        )
        
      )
    }else{  USER$Logged <- FALSE
    USER$pass <- ""
    newvalue <- "acc2"
    updateTabItems(session, "tabs", newvalue)
    addClass(selector = "body", class = "sidebar-collapse")}
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
  output$WC=renderPlot({
    
    one=sqlQuery(connect,paste("SELECT DATE_MED,PATIENT_IDENTIFIER from dbpfedev.medical_checkup"))     
    two=sqlQuery(connect,paste("SELECT LESION_AGE,PATIENT_IDENTIFIER from dbpfedev.sample"))
    three= sqldf("select DATE_MED,LESION_AGE from  one, two
                 
                 where   one.PATIENT_IDENTIFIER=two.PATIENT_IDENTIFIER ")
    days=    three$DATE_MED-three$LESION_AGE
    Lesion_Age_in_weeks <- cut(as.numeric(days), c(0, 15, 30, 45, 60, 75,90,105),
                               labels = c("< 2 weeks", "2 to 4  ", "4 to 6","6 to 8 ", 
                                          "8 to 10 ","10 to 12 ", "more than 3 weeks"))
    h=as.data.frame( table(Lesion_Age_in_weeks))
    d=as.data.frame(h)
    
    p10 <- ggplot(d, aes(x= Lesion_Age_in_weeks ,y=Freq)) + geom_boxplot()
    p10
    
  })
  output$MC=renderPlot({
    one2=sqlQuery(connect,paste("SELECT DATE_MED,PATIENT_IDENTIFIER from dbpfedev.medical_checkup"))     
    two2=sqlQuery(connect,paste("SELECT BIRTH_DATE,PATIENT_IDENTIFIER from dbpfedev.patient"))
    three2= sqldf("select DATE_MED,BIRTH_DATE from  one2, two2
                  
                  where   one2.PATIENT_IDENTIFIER=two2.PATIENT_IDENTIFIER ")
    age= three2$DATE_MED - three2$BIRTH_DATE
    Patient_Age <- cut(round(as.numeric(age)/360), c(0,10,20,30,40,50,60,70,80,120),
                       labels = c("< 10 years","11-20","21-30","31-40","41-50","51-60", "61-70","71-80",">80 years" ))
    hage=as.data.frame( table(Patient_Age))
    dage=as.data.frame(hage)
    
    p100 <- ggplot(dage, aes(x= Patient_Age ,y=Freq)) + geom_boxplot()+geom_jitter()
    p100
    
  })
  
  output$Random=renderUI({
    if(USER$Logged==TRUE ){
      fluidRow(
        box(width = 6, status = "info",solidHeader = FALSE,title = "Patient Age Distribution",
            plotOutput("MC")
        ),
        box(width = 6,  status = "info",solidHeader = FALSE,title="Lesion Age per weeks",
            plotOutput("WC")
        ),
        
        uiOutput("PADB")
        
        
        
      )
      
    }else{  USER$Logged <- FALSE
    USER$pass <- ""
    newvalue <- "acc2"
    updateTabItems(session, "tabs", newvalue)
    addClass(selector = "body", class = "sidebar-collapse")}
  })
  
  
  
  ################################################################################################################
  #                                               boxplot patient                                                #
  ################################################################################################################
  
  output$boxmP=renderPlot({
    MP=sqlQuery(connect,paste("SELECT DATE_MED from dbpfedev.medical_checkup"))
    CheckUp_Month=format(MP, "%Y-%m")
    
    databoxdateT=as.data.frame( table(CheckUp_Month))
    
    CheckUp_Month_=format(as.yearmon(as.character.Date(databoxdateT$CheckUp_Month),"%Y-%m"), "%m")
    CheckUp_Month_<- ordered(sort(as.numeric(CheckUp_Month_)),
                             levels = sort(unique(as.numeric(CheckUp_Month_))),
                             labels = c("Jan", "Feb", "Mar","Apr", 
                                        "May","Jun", "Jul","Aug","Sep","Oct","Nov","Dec"))
    
    
    
    databoxdate=cbind(databoxdateT,CheckUp_Month_)
    
    
    ggplot(databoxdate, aes(x=CheckUp_Month_  ,y=Freq,color=CheckUp_Month_)) + geom_boxplot()+geom_jitter()
  })
  
  ################################################################################################################
  #                                              data management                                                 #
  ################################################################################################################
  
  output$Managementall=renderUI({
    if(USER$Logged==TRUE ){
      
      if(paste(USER$name)=='super')
      {
        h3("Hello in this section.")
        
        tabBox(
          id="managedatatool",
          title = tagList( ""),
          width = 40,
          height = 4,
          
          
          tabPanel(h5(strong("Users")),
                   id="formUser",
                   fluidRow (
                     div(
                       id="formUser",
                       box(title = "Add new user",width = 4,
                           uiOutput( "adduserFIN")),
                       box(title = "Delete user",width = 4,
                           uiOutput( "DeluserFIN")),
                       box(title = "Update existing user",width = 4,
                           uiOutput( "UpuserFIN"))
                       
                     ))
          ),
          
          tabPanel(h5(strong("Delete row data")),
                   id="formCleaningtool",
                   fluidRow (
                     div(box(width = 4, status = "info",solidHeader = TRUE,
                             uiOutput("DatadelF666table"),
                             uiOutput("DatadelF666Fil"),
                             uiOutput("DatadelF666tableval"),
                             actionButton("DatadelDone","Delete")
                     ),
                     box(width = 8, status = "info",
                         DT::dataTableOutput("DatadelF666doooooon") )))
          ),
          tabPanel(h5(strong("Download data")),
                   id="formDownLoadtool",
                   fluidRow (
                     div(box(width = 4, status = "info",solidHeader = TRUE,
                             uiOutput("DataDowLF666table"),
                             uiOutput("DataDowLF666Fil"),
                             uiOutput("DataDowLF666value"),
                             textInput("naamebase","File name",""),
                             actionButton("DataLowLDone","Download"),
                             actionButton("DataLowLDoneAll","Download all table")
                     ),
                     box(width = 8, status = "info",
                         DT::dataTableOutput("DataDowLF666doooooon")  )))
          )
          
        )
      }else{info("ERROR :: Access Denied")}
    }else{ USER$Logged <- FALSE
    USER$pass <- ""
    newvalue <- "acc2"
    updateTabItems(session, "tabs", newvalue)
    addClass(selector = "body", class = "sidebar-collapse")}
  })
  
  
  
  
  output$adduserFIN=renderUI ({
    
    
    div(
      
      
      
      box(width = 10, status = "info",solidHeader = TRUE,
          textInput("userLogin","Create Login",""),
          textInput("userpass","Create Password",""),  
          selectInput("NivSec","Data access",choices =  c("", "super","normal")),
          textInput("userIns","Institution",""), 
          
          
          
          actionButton("subusernew","Submit user")
      ))
  })
  
  output$sel=renderUI({
    selectInput("userLoginF","Select user",choices=c("",as.character(data.frame( sqlQuery(connect,paste("SELECT * from dbpfedev.userdata")))$LOGINUSER)))
  })
  
  
  
  output$UpuserFINav=renderUI ({
    
    
    
    
    div(
      
      
      
      box(width = 11, status = "info",solidHeader = TRUE,
          id="useraddid",
          
          textInput("userpassF","Change Password",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT * from dbpfedev.userdata where LOGINUSER='%s'",paste(input$userLoginF))))$MOTDPASS))),  
          selectInput("NivSecF","Choose access level",choices =  c("", "super","normal")),
          textInput("userInsF","Change Institution",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT * from dbpfedev.userdata where LOGINUSER='%s'",paste(input$userLoginF))))$FROMINST))), 
          
          
          
          actionButton("subusernewUp","Update user data")
      ))
  })
  
  
  output$UpuserFIN=renderUI ({
    
    
    
    
    div(
      
      
      
      box(width = 10, status = "info",solidHeader = TRUE,
          uiOutput("sel"),
          uiOutput("UpuserFINav")
          
          
      ))
  })
  
  
  
  output$DeluserFIN=renderUI ({
    
    
    div(
      
      
      selectInput("Loguserdelete","Select user login",choices =  c(as.character(data.frame( sqlQuery(connect,paste("SELECT LOGINUSER from dbpfedev.userdata")))$LOGINUSER))),
      
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
    AAllDel=sqlQuery(connect,paste("SELECT * from dbpfedev.",input$tableNameDelete))
    
    selectInput("filNameDelete","Select Filter",choices =  c(colnames(AAllDel)))
    
  }) 
  
  
  output$DataDowLF666Fil=renderUI ({
    AAllDowL=sqlQuery(connect,paste("SELECT * from dbpfedev.",input$tableNameDown))
    selectInput("filNameDown","Select Filter",choices =  c( colnames(AAllDowL) ))
    
  })
  
  #################################################################
  #                            Values                             #
  #################################################################
  output$DatadelF666tableval=renderUI ({
    AAllDel1=sqlQuery(connect,paste("SELECT * from dbpfedev.",input$tableNameDelete))
    AAllDel2=AAllDel1[,input$filNameDelete]
    
    selectInput("valNameDelete","Select Value",choices =  c( unique(as.character(AAllDel2) )))
    
  }) 
  
  output$DataDowLF666value=renderUI ({
    AAllDown1=sqlQuery(connect,paste("SELECT * from dbpfedev.",input$tableNameDown))
    AAllDown2=AAllDown1[,input$filNameDown]
    selectInput("valNameDown","Select Value",choices =  c(unique(as.character(AAllDown2))))
    
  })
  
  #################################################################
  #                            data results                       #
  #################################################################
  humDown=reactive({
    AAllDown1=sqlQuery(connect,paste("SELECT * from dbpfedev.",input$tableNameDown))
    
    AAllDown2=AAllDown1[which(AAllDown1[,input$filNameDown]==as.character(input$valNameDown)),]
    data.frame(AAllDown2)
  })
  
  humDownallall=reactive({
    AAllDown1=sqlQuery(connect,paste("SELECT * from dbpfedev.",input$tableNameDown))
    AAllDown1
    
  })
  
  humDel=reactive({
    AAllDel1=sqlQuery(connect,paste("SELECT * from dbpfedev.",input$tableNameDelete))
    AAllDel2=AAllDel1[which(AAllDel1[,input$filNameDelete]==as.character(input$valNameDelete)),]
    data.frame(AAllDel2)
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
    querydeleteuser <-sprintf("DELETE from userdata where LOGINUSER='%s%s",paste(as.character(input$Loguserdelete),collapse = ", "),paste("'",collapse = " ,"))
    sqlQuery(connect,querydeleteuser)
    info("User Deleted")
    observe({updateSelectInput(session,"Loguserdelete","",choices =  c(as.character(data.frame( sqlQuery(connect,paste("SELECT LOGINUSER from dbpfedev.userdata")))$LOGINUSER))  )})
    observe({updateSelectInput(session,"userLoginF","",choices =  c("",as.character(data.frame( sqlQuery(connect,paste("SELECT * from dbpfedev.userdata")))$LOGINUSER)))})
  })
  
  observeEvent(input$DatadelDone, {
    querydeleteuser <-sprintf("DELETE from %s where %s='%s%s",paste(as.character(input$tableNameDelete)),paste(as.character(input$filNameDelete),collapse = ", " )   ,paste(as.character(input$valNameDelete),collapse = ", "),paste("'",collapse = " ,"))
    sqlQuery(connect,querydeleteuser)
    info("Data successfully Deleted")
    observe({
      AAllDel1=sqlQuery(connect,paste("SELECT * from dbpfedev.",input$tableNameDelete))
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
    
    validate(
      need(try(sqlExecute(connect,query = queryuseraddpfe)  ), "Error : row already exists")
    )
    
    info("User successfully added")
    shinyjs::reset("formUser")
    observe({updateSelectInput(session,"Loguserdelete","",choices =  c(as.character(data.frame( sqlQuery(connect,paste("SELECT LOGINUSER from dbpfedev.userdata")))$LOGINUSER))  )})
    observe({updateSelectInput(session,"userLoginF","",choices =  c("",as.character(data.frame( sqlQuery(connect,paste("SELECT LOGINUSER from dbpfedev.userdata")))$LOGINUSER))  )
    })
  })
  
  #####################################################################################################
  #                                             button update user                                    #
  ##################################################################################################### 
  observeEvent(input$subusernewUp,{
    queryuserUPpfe <- sprintf("
                              UPDATE userdata SET MOTDPASS='%s',LEVELSECURE='%s',FROMINST='%s',USE_LOGINUSER='%s' WHERE LOGINUSER ='%s%s",paste(as.character(input$userpassF)),paste(as.character(input$NivSecF)),paste(as.character(input$userInsF)),paste(as.character(USER$name)),paste(as.character(input$userLoginF),collapse = ", " ),paste("'",collapse = " ,"))
    sqlExecute(connect,query = queryuserUPpfe)
    info("User successfully Updated")
    observe({updateSelectInput(session,"userLoginF","",choices =  c(" ",as.character(data.frame( sqlQuery(connect,paste("SELECT LOGINUSER from dbpfedev.userdata")))$LOGINUSER)))  
      
    })
  })
  
  #####################################################################################################
  #                                             button update species                                 #
  ##################################################################################################### 
  observeEvent(input$update,{
    queryesppfe <- sprintf("UPDATE sample SET SPECIES='%s' WHERE ID_SAMPLE='%s'",paste(as.character(input$spece)),paste(as.character(input$upsample),collapse = ", " ))
    validate(
      need(input$upsample!="", "You must choose a sample from list")
    )
    validate(
      need(input$spece!="", "You must specify specy from list")
    )
    sqlExecute(connect,query = queryesppfe)
    info("Species successfully Updated")
    observe({updateSelectInput(session,"upsample","Choose Sample",choices = c("",as.character(dataech()[,1])))})
    
  })
  
  
  #####################################################################################################
  #                                             Select diagnosis data                                 #
  ##################################################################################################### 
  doneTest=reactive({
    f=data.frame( sqlQuery(connect,sprintf("SELECT TEST,RESULT,LEISHSUSPECT from dbpfedev.diognosis where ID_SAMPLE='%s'",paste(input$upsample)))) 
    f
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
                    choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT PATIENT_IDENTIFIER from dbpfedev.patient")))$PATIENT_IDENTIFIER)))),
        
        uiOutput("testpat"),
        
        
        
        footer = tagList(
          modalButton("Cancel"),
          actionButton("okpatient", "OK")
        )
      )
    }else{
      modalDialog(
        selectInput("DUPpatient", "Select patient",
                    choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT PATIENT_IDENTIFIER from dbpfedev.patient where LOGINUSER='%s'",paste(USER$name))))$PATIENT_IDENTIFIER)))),
        
        uiOutput("testpat"),
        
        
        
        footer = tagList(
          modalButton("Cancel"),
          actionButton("okpatient", "OK")
        )
      )
    }
  }
  observeEvent(input$editpatient, {
    
    showModal(dataModalUPPatient())
  })
  
  UPdatavaluePat=reactive({
    ddddddd=data.frame(sqlQuery(connect,sprintf("SELECT * from dbpfedev.patient where PATIENT_IDENTIFIER='%s'",paste(USER$name),paste(input$DUPpatient) )))
    ddddddd
  })
  output$testpat=renderUI({
    box(
      #textInput("patientIDUP","patient DB Code",value =UPdatavaluePat()$PATIENT_IDENTIFIER),
      textInput("medfilenumberUP","Patient ID",value =UPdatavaluePat()$MEDICAL_FILE_NUMBER),
      textInput("ConsPatUP","Consentment", value =UPdatavaluePat()$CONSENT),
      #textInput("prenompUP","First name",value =UPdatavaluePat()$FIRST_NAME),
      #textInput("nompUP","Last name",value =UPdatavaluePat()$LAST_NAME),  
      dateInput("datenaisspUP","Birth date",value =UPdatavaluePat()$BIRTH_DATE),
      textInput("nationalpUP","Nationality", value =UPdatavaluePat()$NATIONALITY) ,
      textInput("sexepUP","Gender", value =UPdatavaluePat()$GENDER)#,
      #textInput("phonenumUP","Phone number",value =UPdatavaluePat()$PHONE_NUMBER)
    )
  })
  ########################################################################
  # button update patient                                                #
  ########################################################################
  
  observeEvent(input$okpatient,{
    querypatientUPpfe <- sprintf("
                                 UPDATE patient SET PATIENT_IDENTIFIER='%s' ,MEDICAL_FILE_NUMBER='%s',FIRST_NAME='%s',LAST_NAME='%s',BIRTH_DATE='%s',NATIONALITY='%s',GENDER='%s',CONSENT='%s' ,PHONE_NUMBER='%s' WHERE LOGINUSER='%s' and PATIENT_IDENTIFIER='%s%s",
                                 paste(as.character(input$patientIDUP)),paste(as.character(input$medfilenumberUP)),paste(as.character(input$prenompUP)),paste(as.character(input$nompUP)) ,paste(as.character(input$datenaisspUP)),paste(as.character(input$nationalpUP)),paste(as.character(input$sexepUP)),paste(as.character(input$ConsPatUP)) ,paste(input$phonenumUP)  ,paste(USER$name),paste(as.character(input$DUPpatient),collapse = ", " ),paste("'",collapse = " ,"))
    sqlExecute(connect,query = querypatientUPpfe)
    info("Patient successfully Updated")
    removeModal()
    
  })
  
  
  #####################################################################################################
  #                                              Edit checkup data                                    #
  ##################################################################################################### 
  
  dataModalUPMEdCheck <- function(failed = FALSE) {
    modalDialog(
      selectInput("DUPcheck", "Select checkUp date",
                  choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT DATE_MED from dbpfedev.medical_checkup where PATIENT_IDENTIFIER='%s'",paste(input$PatIdentifier))))$DATE_MED))
                  )),
      
      uiOutput("testCheckFFFFFF"),
      
      
      footer = tagList(
        modalButton("Cancel"),
        actionButton("okCheck", "OK")
      )
    )
  }
  observeEvent(input$editmedcheck, {
    showModal(dataModalUPMEdCheck())
  })
  
  UPdatavalueCheck=reactive({
    dddddddC=data.frame(sqlQuery(connect,sprintf("SELECT * from dbpfedev.medical_checkup where PATIENT_IDENTIFIER='%s' and DATE_MED='%s'",paste(input$PatIdentifier),paste(as.character(input$DUPcheck)) )))
    dddddddC
  })
  output$testCheckFFFFFF=renderUI({
    box(
      textInput("interrIDUP","Interrogator ID",value = UPdatavalueCheck()$ID_INTERROGATOR), 
      textInput("hospitalUP","Hospital",value = UPdatavalueCheck()$HOSPITAL),
      textInput("pysicienUP","Physician",value = UPdatavalueCheck()$PHYSICIAN ), 
      textInput("samplerUP","Sampler",value = UPdatavalueCheck()$SAMPLE ), 
      textInput("clinstateUP","Clinical State",value = UPdatavalueCheck()$CLINICAL_STATE), 
      textInput("HhostRUP","Surrounding human cases", value = UPdatavalueCheck()$POSSIBLE_HUMAN_HOSTS),
      textInput("HhostLUP","Link with human cases", value = UPdatavalueCheck()$LINK_HUMAN_HOSTS), 
      textInput("AhostUP","Possible animal contact" ,value = UPdatavalueCheck()$ANIMAL_AROUND),
      numericInput("Lesion_NumberUP","Number of Lesions (*)",value = UPdatavalueCheck()$LESNUM ), 
      textInput("Lesion_SitesUP","Lesion Sites",value = UPdatavalueCheck()$LESPOSSS )
      #textInput("General_DescriptionUP","General Description",value = UPdatavalueCheck()$GENDESC)
      
    )
  })
  
  
  ########################################################################
  # button update CheckUp                                                #
  ########################################################################
  
  observeEvent(input$okCheck,{
    
    validate(
      need(input$Lesion_NumberUP>= -1, info("Error : Missing values"))
    )
    
    queryCheckUPpfe <- sprintf("
                               UPDATE medical_checkup SET ID_INTERROGATOR='%s' ,HOSPITAL='%s',PHYSICIAN='%s',SAMPLER='%s',CLINICAL_STATE='%s',POSSIBLE_HUMAN_HOSTS='%s',LINK_HUMAN_HOSTS='%s',ANIMAL_AROUND='%s' ,LESPOSSS ='%s',LESNUM ='%s',GENDESC='%s'where PATIENT_IDENTIFIER='%s' and DATE_MED='%s%s",
                               paste(as.character(input$interrIDUP)),paste(as.character(input$hospitalUP)),paste(as.character(input$pysicienUP)),
                               paste(as.character(input$samplerUP)) ,paste(as.character(input$clinstateUP)),paste(as.character(input$HhostRUP)),
                               paste(as.character(input$HhostLUP)),paste(as.character(input$AhostUP)) , toString(input$Lesion_SitesUP) ,paste(input$Lesion_NumberUP)  ,paste(as.character(input$General_DescriptionUP)),
                               paste(as.character(input$PatIdentifier)), paste(as.character(input$DUPcheck),collapse = ", " ),paste("'",collapse = " ,"))
    sqlExecute(connect,query = queryCheckUPpfe )
    info("CheckUp successfully Updated")
    removeModal()
  })
  
  
  #####################################################################################################
  #                                     Edit historical treatment data                                #
  ##################################################################################################### 
  
  dataModalUPTreatment <- function(failed = FALSE) {
    modalDialog(
      selectInput("DUPtreat", "Select treatment starting date",
                  choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT START_DATE from dbpfedev.treatmenthistory where PATIENT_IDENTIFIER='%s'",paste(input$PatIdentifier))))$START_DATE))
                  )),
      
      uiOutput("testtreatFFFFFF"),
      
      footer = tagList(
        modalButton("Cancel"),
        actionButton("okDUPtreat", "OK")
      )
    )
  }
  observeEvent(input$edittreatment, {
    showModal(dataModalUPTreatment())
  })
  
  UPdatavalueTreat=reactive({
    dddddddT=data.frame(sqlQuery(connect,sprintf("SELECT * from dbpfedev.treatmenthistory where PATIENT_IDENTIFIER='%s' and START_DATE='%s'",paste(input$PatIdentifier),paste(as.character(input$DUPtreat)) )))
    dddddddT
  })
  
  output$testtreatFFFFFF=renderUI({
    box(width = 12,
        column("",textInput("treattypeUP","Treatment type",value = UPdatavalueTreat()$TREATMENT_TYPE), width = 4 ), 
        column("",textInput("prescribedUP","Prescribed for",value = UPdatavalueTreat()$PRESCRIBEDFOR), width = 4 ), 
        column("",dateInput("datetreatbegUP","Treatment start date",value = UPdatavalueTreat()$START_DATE), width = 4),
        column("",textInput("datetreatendUP","Treatment Duration (in weeks)",value = UPdatavalueTreat()$DURATIONN), width = 4),
        
        column("",textInput("PosologyUP","Posology",value = UPdatavalueTreat()$POSOLOGY), width = 4),
        column("",textInput("adminUP","Administaration Root",value = UPdatavalueTreat()$ADMINROUTE), width = 4),
        
        column("",numericInput("injectionnumberUP","Injection number (*)",value = UPdatavalueTreat()$INJECTION_NUMBER), width = 4),
        column("",dateInput("healingUP","Healing Date",value = UPdatavalueTreat()$HEALING_DATE), width = 4)
    )
  })
  
  
  ########################################################################
  # button update treatment                                              #
  ########################################################################
  
  observeEvent(input$okDUPtreat,{
    querytreatmentpfe <- sprintf("
                                 UPDATE treatmenthistory SET TREATMENT_TYPE='%s' ,PRESCRIBEDFOR='%s',START_DATE='%s',DURATIONN='%s',POSOLOGY='%s',
                                 ADMINROUTE='%s',INJECTION_NUMBER='%s',HEALING_DATE='%s' where PATIENT_IDENTIFIER='%s' and START_DATE='%s%s",
                                 paste(as.character(input$treattypeUP)),paste(as.character(input$prescribedUP)),paste(as.character(input$datetreatbegUP)),
                                 paste(as.character(input$datetreatendUP)) ,paste(as.character(input$PosologyUP)),paste(as.character(input$adminUP)),
                                 paste(as.character(input$injectionnumberUP)),paste(as.character(input$healingUP)) ,
                                 paste(as.character(input$PatIdentifier)), paste(as.character(input$DUPtreat),collapse = ", " ),paste("'",collapse = " ,"))
    sqlExecute(connect,query = querytreatmentpfe )
    info("Treatment successfully Updated")
    removeModal()
  })
  
  
  #####################################################################################################
  #                                              Edit movement data                                    #
  ##################################################################################################### 
  
  dataModalUPRegion <- function(failed = FALSE) {
    modalDialog(
      selectInput("DUPmvt", "Select movement",
                  choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT FROMDate from dbpfedev.travel_residency where PATIENT_IDENTIFIER='%s'",paste(input$PatIdentifier))))$FROMDate))
                  )),
      
      uiOutput("testmvtFFFFFF"),
      
      
      footer = tagList(
        modalButton("Cancel"),
        actionButton("okDUPmvt", "OK")
      )
    )
  }
  observeEvent(input$editregion, {
    showModal(dataModalUPRegion())
  })
  
  
  UPdatavalueMvt=reactive({
    dddddddMV=data.frame(sqlQuery(connect,sprintf("SELECT * from dbpfedev.travel_residency where PATIENT_IDENTIFIER='%s' and FROMDate='%s'",paste(input$PatIdentifier),paste(as.character(input$DUPmvt)) )))
    dddddddMV
  })
  output$testmvtFFFFFF=renderUI({
    box(width = 12,
        column("",textInput("regvisitUP","City", value=UPdatavalueMvt()$CITY), width = 4),
        column("",selectInput("TypeUP","Urban/Rural",choices =  c("", "Urban","Rural","N/A")), width = 4),
        column("",textInput("resedentUP","Residency ",value=UPdatavalueMvt()$RESIDENCY), width = 4),
        
        column("",textInput("bybyteUP","Bite Notion",value=UPdatavalueMvt()$BYTENOT), width = 4),
        column("",dateInput("datedatevisitUP","Visit Date",value = UPdatavalueMvt()$FROMDATE), width = 4) ,
        column("",textInput("dateleavevisitUP","Duration (In wek)",value = UPdatavalueMvt()$TODATE), width = 4)
        
    )
  })
  
  
  ########################################################################
  # button update mvt                                                    #
  ########################################################################
  
  observeEvent(input$okDUPmvt,{
    querymvtpfe <- sprintf("
                           UPDATE travel_residency SET 	CITY='%s' ,RESIDENCY='%s',BYTENOT='%s',FROMDATE='%s', TODATE='%s',TYPE='%s' where 
                           PATIENT_IDENTIFIER='%s' and FROMDate='%s%s",
                           paste(as.character(input$regvisitUP)),paste(as.character(input$resedentUP)),paste(as.character(input$bybyteUP)),
                           paste(as.character(input$datedatevisitUP)),paste(as.character(input$dateleavevisitUP)),paste(as.character(input$TypeUP)),
                           paste(as.character(input$PatIdentifier)), paste(as.character(input$DUPmvt),collapse = ", " ),paste("'",collapse = " ,"))
    sqlExecute(connect,query = querymvtpfe)
    info("Mouvement successfully Updated")
    removeModal()
  })
  
  #####################################################################################################
  #                                              Edit Sample data                                    #
  ##################################################################################################### 
  
  dataModalUSample <- function(failed = FALSE) {
    modalDialog(
      selectInput("DUPsample", "Select sample",
                  choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT ID_SAMPLE from dbpfedev.sample where PATIENT_IDENTIFIER='%s'",paste(input$PatIdentifier))))$ID_SAMPLE))
                  )),
      
      uiOutput("testsamFFFFFF"),
      
      footer = tagList(
        modalButton("Cancel"),
        actionButton("okDUPsample", "OK")
      )
    )
  }
  observeEvent(input$editsample, {
    showModal(dataModalUSample())
  })
  UPdatavalueSample=reactive({
    dddddddSam=data.frame(sqlQuery(connect,sprintf("SELECT * from dbpfedev.sample where PATIENT_IDENTIFIER='%s' and ID_SAMPLE='%s'",paste(input$PatIdentifier),paste(as.character(input$DUPsample)) )))
    dddddddSam
  })
  output$testsamFFFFFF=renderUI({
    box(width = 12,
        textInput("LesionsiteUP","Lesion site sampled",value = UPdatavalueSample()$LESION_SITE_SAMPLED), 
        textInput("samplsupportUP","Type of sample support",value = UPdatavalueSample()$TYPE_OF_SAMPLE_SUPPORT_), 
        textInput("sammethUP","Sampling Method",value = UPdatavalueSample()$SAMPLING_METHOD), 
        textInput("directexamUP","Direct examination result",value = UPdatavalueSample()$DIRECT_EXAMINATION),
        textInput("abandanceUP","Abundance on the smear",value = UPdatavalueSample()$ABUDANCE_ON_THE_SMEAR), 
        dateInput("apparitionlesionUP","Lesion first appearence",value = UPdatavalueSample()$LESION_AGE) ,

        numericInput("diamlesionMaxUP","lesion Diameter Maximal(millimeter) (*)",value =UPdatavalueSample()$DIAMETRE) , 
        numericInput("diamlesionMinUP","lesion Diameter Minimal(millimeter) (*)",value =UPdatavalueSample()$DIAMETRE) , 
        numericInput("highlesionUP","lesion Hight(millimeter) (*)",value =UPdatavalueSample()$DIAMETRE) , 
        
        textInput("locallesionUP","Lesion localisation",value = UPdatavalueSample()$LOCALISATION) , 
        textInput("extractDayUP","Sampling date",value = UPdatavalueSample()$LESION_AGE ),
        textInput("descriptionlesionUP","Lesion description",value = UPdatavalueSample()$DESCRIPTION) 
        
    )
  })
  
  
  ########################################################################
  # button update Sample                                                 #
  ########################################################################
  
  observeEvent(input$okDUPsample,{
    querySamplepfe <- sprintf("
                              UPDATE sample SET LESION_SITE_SAMPLED='%s' ,SAMPLING_METHOD='%s',TYPE_OF_SAMPLE_SUPPORT_='%s',
                              DIRECT_EXAMINATION='%s',ABUDANCE_ON_THE_SMEAR='%s', LESION_AGE='%s', 
                              DIAMETREMax='%s',DIAMETREMin='%s',HIGHT='%s',
                              LOCALISATION='%s', DATE_EXTRACTION='%s',DESCRIPTION='%s' where PATIENT_IDENTIFIER='%s' and ID_SAMPLE='%s%s",
                              paste(as.character(input$LesionsiteUP)),paste(as.character(input$sammethUP)),paste(as.character(input$samplsupportUP)),
                              paste(as.character(input$directexamUP)) ,paste(as.character(input$abandanceUP)),paste(as.character(input$apparitionlesionUP)),
                              paste(as.character(input$diamlesionMaxUP)),paste(as.character(input$diamlesionMinUP)),paste(as.character(input$highlesionUP)),
                              paste(as.character(input$locallesionUP)) ,paste(as.character(input$extractDayUP)),paste(as.character(input$descriptionlesionUP)) ,
                              paste(as.character(input$PatIdentifier)), paste(as.character(input$DUPsample),collapse = ", " ),paste("'",collapse = " ,"))
    sqlExecute(connect,query = querySamplepfe )
    info("Sample successfully Updated")
    removeModal()
  })
  
  
  
  #####################################################################################################
  #                                              Edit Diagnosis data                                 #
  ##################################################################################################### 
  
  dataModalUDiagnosis <- function(failed = FALSE) {
    modalDialog(
      
      column("", selectInput("sampleUPDiag","Sample ID",choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT ID_SAMPLE from diognosis where ID_SAMPLE=(SELECT ID_SAMPLE from sample where PATIENT_IDENTIFIER='%s')",paste(input$PatIdentifier) )))[,1])))),width = 4),
      column("",selectInput("testupdiag","Molecular est",choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT TEST from diognosis where ID_SAMPLE=(SELECT ID_SAMPLE from sample where PATIENT_IDENTIFIER='%s')",paste(input$PatIdentifier)  )))[,1])))),width = 4),
      column("",selectInput("labupDiag","Laboratory",choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT LABORATORY_NAME from laboratory " )))[,1])))),width = 4),
      
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
    dddddddDiag=data.frame(sqlQuery(connect,sprintf("SELECT * from dbpfedev.diognosis where ID_SAMPLE='%s' and TEST='%s' and LABORATORY_NAME='%s'",paste(as.character(input$sampleUPDiag)),paste(as.character(input$testupdiag)), paste(as.character(input$labupDiag)))))
    dddddddDiag
  })
  output$testdiagFFFFFF=renderUI({
    box(width = 12,
        column("",textInput("dattestUP","Test date",value = UPdatavalueDiagnosis()$DIAGNOSIS_DATE),width = 6),
        column("",numericInput("quantityUP","Quantity",value = UPdatavalueDiagnosis()$QUANTITE),width = 6),
        column("",textInput("restestUP","Test result",value = UPdatavalueDiagnosis()$RESULT),width = 6),
        column("",textInput("susSpecUP","Suspected Species",value = UPdatavalueDiagnosis()$LEISHSUSPECT),width = 6)
        
    )
  })
  ########################################################################
  # button update Diagnosis                                              #
  ########################################################################
  
  observeEvent(input$okDiagnosis,{
    querydiagpfe <- sprintf("
                            UPDATE diognosis SET 	DIAGNOSIS_DATE='%s' ,QUANTITE='%s',RESULT='%s',	LEISHSUSPECT='%s' where 
                            ID_SAMPLE='%s' and TEST='%s' and LABORATORY_NAME='%s%s",
                            paste(as.character(input$dattestUP)),paste(as.character(input$quantityUP)),paste(as.character(input$restestUP)),
                            paste(as.character(input$susSpecUP)) ,paste(as.character(input$sampleUPDiag)) ,paste(as.character(input$testupdiag)) , paste(as.character(input$labupDiag),collapse = ", " ),paste("'",collapse = " ,"))
    sqlExecute(connect,query =querydiagpfe)
    info("Diagnosis successfully Updated")
    observe({updateSelectInput(session,"upsample","Choose Sample",choices = c("",as.character(dataech()[,1])))})
    removeModal()
  })
  
  #####################################################################################################
  #                                            Edit Interrogator data                                 #
  ##################################################################################################### 
  
  dataModalUInterrogator <- function(failed = FALSE) {
    modalDialog(
      selectInput("DUPInterrogator", "Select Interrogator",
                  choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT ID_INTERROGATOR from dbpfedev.interrogator where LOGINUSER='%s'",paste(USER$name))))$ID_INTERROGATOR)))),
      
      uiOutput("testInterFFFFFF") ,
      
      footer = tagList(
        modalButton("Cancel"),
        actionButton("okDUPInterrogator", "OK")
      )
    )
  }
  observeEvent(input$editinterr, {
    showModal(dataModalUInterrogator())
  })
  UPdatavalueinterrrogator=reactive({
    dddddddinter=data.frame(sqlQuery(connect,sprintf("SELECT * from dbpfedev.interrogator where ID_INTERROGATOR='%s'",paste(input$DUPInterrogator) )))
    dddddddinter
  })
  output$testInterFFFFFF=renderUI({
    box(width = 12,
        textInput("ciniUP","Identity Card number",value =UPdatavalueinterrrogator()$ID_INTERROGATOR),
        textInput("nomiUP","Last name",value =UPdatavalueinterrrogator()$LAST_NAME_INTERROGATOR),
        textInput("prenomiUP","First name",value = UPdatavalueinterrrogator()$FIRST_NAME_INTERROGATOR),
        textInput("qualUP","Quality",value = UPdatavalueinterrrogator()$QUALITY)
    )
  })
  ########################################################################
  # button update interrogator                                                    #
  ########################################################################
  
  observeEvent(input$okDUPInterrogator,{
    queryinterpfe <- sprintf("
                             UPDATE interrogator SET 	ID_INTERROGATOR='%s' ,LAST_NAME_INTERROGATOR='%s',FIRST_NAME_INTERROGATOR='%s',QUALITY='%s' where 
                             ID_INTERROGATOR='%s%s",
                             paste(as.character(input$ciniUP)),paste(as.character(input$nomiUP)),paste(as.character(input$prenomiUP)),
                             paste(as.character(input$qualUP)) , paste(as.character(input$DUPInterrogator),collapse = ", " ),paste("'",collapse = " ,"))
    sqlExecute(connect,query = queryinterpfe)
    info("Interrogator successfully Updated")
    removeModal()
  })
  #####################################################################################################
  #                                              Edit laboratory data                                 #
  ##################################################################################################### 
  
  dataModalULabs<- function(failed = FALSE) {
    modalDialog(
      selectInput("DUPLaboratory", "Select Laboratory",
                  choices = c("",c(as.character(data.frame( sqlQuery(connect,sprintf("SELECT LABORATORY_NAME from dbpfedev.laboratory where LOGINUSER='%s'",paste(USER$name))))$LABORATORY_NAME)))),
      
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
    dddddddlab=data.frame(sqlQuery(connect,sprintf("SELECT * from dbpfedev.laboratory where LABORATORY_NAME='%s'",paste(input$DUPLaboratory) )))
    dddddddlab
  })
  output$testlabbbFFFFFF=renderUI({
    box(width = 12,
        textInput("labnamoUP","Laboratory Complete name",value = UPdatavaluelabo()$LABORATORY_NAME),
        textInput("counlabUP","Country",value = UPdatavaluelabo()$COUNTRY)
    )
  })
  ########################################################################
  # button update laboratory                                             #
  ########################################################################
  
  observeEvent(input$okDUPLaboratory,{
    querylabpfe <- sprintf("
                           UPDATE laboratory SET 	LABORATORY_NAME='%s' ,COUNTRY='%s' where 
                           LABORATORY_NAME='%s%s",
                           paste(as.character(input$labnamoUP)),paste(as.character(input$counlabUP)),
                           paste(as.character(input$DUPLaboratory),collapse = ", " ),paste("'",collapse = " ,"))
    sqlExecute(connect,query = querylabpfe)
    info("Laboratory successfully Updated")
    removeModal()
    
    
  })
  
  
  
  #####################################################################################################################################
  #                                                Download buttons                                                                    #
  #####################################################################################################################################
  
  #                                         ViZ                                     #
  
  ######################################## super ####################################
  output$calendarDB= renderUI({
    div(
      textInput("label_cal", "", value = "",placeholder = "Plot label"),
      actionButton("CalendarD", "Download")
    )
  })
  
  
  output$MPNuDB= renderUI({
    div(
      textInput("label_MPNu", "", value = "",placeholder = "Plot label"),
      actionButton("MPNuD", "Download")
    )
  })
  
  output$PieNvDB= renderUI({
    div(
      textInput("label_PieNvD", "", value = "",placeholder = "Plot label"),
      actionButton("PieNvD", "Download")
    )
  })
  
  output$MapDB= renderUI({
    div(
      actionButton("ZoomMapD", "Zoom"),
      textInput("label_MapD", "", value = "",placeholder = "Plot label"),
      actionButton("MapD", "Download")
    )
  })
  ################################# normal #####################################
  output$calendarDB2= renderUI({
    div(
      textInput("label_cal2", "", value = "",placeholder = "Plot label"),
      actionButton("CalendarD2", "Download")
    )
  })
  
  
  output$MPNuDB2= renderUI({
    div(
      textInput("label_MPNu2", "", value = "",placeholder = "Plot label"),
      actionButton("MPNuD2", "Download")
    )
  })
  
  output$PieNvDB2= renderUI({
    div(
      textInput("label_PieNvD2", "", value = "",placeholder = "Plot label"),
      actionButton("PieNvD2", "Download")
    )
  })
  
  output$MapDB2= renderUI({
    div(
      actionButton("ZoomMapD2", "Zoom"),
      textInput("label_MapD2", "", value = "",placeholder = "Plot label"),
      actionButton("MapD2", "Download")
    )
  })
  
  #                                         Analysis                                         #
  
  output$PADB= renderUI({
    div(
      
      column("", textInput("label_PAD1", "", value = "",placeholder = "Plot 1 label"),width = 2),
      column("", actionButton("PAD", "Download plot 1"),width = 4),
      column("", textInput("label_PAD2", "", value = "",placeholder = "Plot 2 label"),width = 2),
      column("", actionButton("PAD2", "Download plot 2"),width = 4)
    )
  })
  
  output$PCP1DB= renderUI({
    div(
      textInput("label_PCP1D", "", value = "",placeholder = "Plot label"),
      actionButton("PCP1D", "Download")
    )
  })
  output$PCP2DB= renderUI({
    div(
      textInput("label_PCP2D", "", value = "",placeholder = "Plot label"),
      actionButton("PCP2D", "Download")
    )
  })
  
  output$CorrDB= renderUI({
    div(
      textInput("label_CorrD", "", value = "",placeholder = "Plot label"),
      actionButton("CorrD", "Download")
    )
  })
  
  output$ACM_EigDB= renderUI({
    div(
      textInput("label_ACM_EigD", "", value = "",placeholder = "Plot label"),
      actionButton("ACM_EigD", "Download")
    )
  })
  output$ACM_DMDB= renderUI({
    div(
      textInput("label_ACM_DMD", "", value = "",placeholder = "Plot label"),
      actionButton("ACM_DMD", "Download")
    )
  })
  output$ACM_IMapDB= renderUI({
    div(
      textInput("label_ACM_IMapD", "", value = "",placeholder = "Plot label"),
      actionButton("ACM_IMapD", "Download")
    )
  })
  
  output$ACM_ClusDB= renderUI({
    div(
      textInput("label_ACM_ClusD", "", value = "",placeholder = "Plot label"),
      actionButton("ACM_ClusD", "Download")
    )
  })
  
  #############################################################################
  
  observeEvent(input$ACM_EigD,{
    pdf(paste(input$label_ACM_EigD,".pdf"),width = 15,height = 5)
    acm20 <- dudi.acm(prepdata()[,c(input$acmV)], scannf = FALSE, nf = 5)
    scatterutil.eigen(acm20$eig,nf=3,box=T)
    info("Download success")
    dev.off()
  })
  
  observeEvent(input$ACM_DMD,{
    pdf(paste(input$label_ACM_DMD,".pdf"),width = 15,height = 10)
    acm21 <- dudi.acm(prepdata()[,c(input$acmV)], scannf = FALSE, nf = 5)
    s.label(acm21$co,clabel = 0.7)
    info("Download success")
    dev.off()
  })
  
  observeEvent(input$ACM_IMapD,{
    pdf(paste(input$label_ACM_IMapD,".pdf"),width = 15,height = 10)
    acm22 <- dudi.acm(prepdata()[,c(input$acmV)], scannf = FALSE, nf = 5)
    s.class(acm22$li, prepdata()$SPECIES, col = brewer.pal(4, "Set1"))
    info("Download success")
    dev.off()
  })
  
  observeEvent(input$ACM_ClusD,{
    pdf(paste(input$label_ACM_ClusD,".pdf"),width = 15,height = 10)
    acmclust <- dudi.acm(prepdata()[,c(input$acmV)], scannf = FALSE, nf = 5)
    d=dist(acmclust$li,method = "euclidean")
    h=hclust(d,"ward.D2")
    plot(h, labels= cordata()[,"ID_SAMPLE"] )
    info("Download success")
    dev.off()
  })
  
  observeEvent(input$CorrD,{
    pdf(paste(input$label_CorrD,".pdf"),width = 15,height = 10)
    Variables=c(input$corvarstoplot)
    d=ggpairs(cordata()[,Variables], mapping = aes(color = SPECIES) , title = "Crossed variables")
    print(d)
    info("Download success")
    dev.off()
  })
  
  
  observeEvent(input$PCP2D,{
    
    totalChUp2=sqlQuery(connect,paste("SELECT * from dbpfedev.medical_checkup"))
    TSD=totalChUp2[,"DATE_MED"]
    TSD2=ts(preddata(),start =as.numeric(format(as.Date(TSD[length(TSD)], format="%Y/%m/%d"),"%Y"))+1,frequency = 12) 
    
    printDy= dygraph(TSD2) %>% dyOptions(stackedGraph = TRUE) %>% dyRangeSelector()
    htmlwidgets::saveWidget(printDy, paste(input$label_PCP2D,".html"))
    info("Download success")
    
  })
  
  observeEvent(input$PCP1D,{
    pdf(paste(input$label_PCP1D,".pdf"),width = 15,height = 10)
    MP=sqlQuery(connect,paste("SELECT DATE_MED from dbpfedev.medical_checkup"))
    CheckUp_Month=format(MP, "%Y-%m")
    
    databoxdateT=as.data.frame( table(CheckUp_Month))
    
    CheckUp_Month_=format(as.yearmon(as.character.Date(databoxdateT$CheckUp_Month),"%Y-%m"), "%m")
    CheckUp_Month_<- ordered(sort(as.numeric(CheckUp_Month_)),
                             levels = sort(unique(as.numeric(CheckUp_Month_))),
                             labels = c("Jan", "Feb", "Mar","Apr", 
                                        "May","Jun", "Jul","Aug","Sep","Oct","Nov","Dec"))
    
    
    
    databoxdate=cbind(databoxdateT,CheckUp_Month_)
    
    
    print(ggplot(databoxdate, aes(x=CheckUp_Month_  ,y=Freq,color=CheckUp_Month_)) + geom_boxplot()+geom_jitter())
    
    
    info("Download success")
    dev.off()
  })
  
  observeEvent(input$PAD,{
    pdf(paste(input$label_PAD1,".pdf"),width = 15,height = 10)
    
    one2=sqlQuery(connect,paste("SELECT DATE_MED,PATIENT_IDENTIFIER from dbpfedev.medical_checkup"))     
    two2=sqlQuery(connect,paste("SELECT BIRTH_DATE,PATIENT_IDENTIFIER from dbpfedev.patient"))
    three2= sqldf("select DATE_MED,BIRTH_DATE from  one2, two2
                  
                  where   one2.PATIENT_IDENTIFIER=two2.PATIENT_IDENTIFIER ")
    age= three2$DATE_MED - three2$BIRTH_DATE
    Patient_Age <- cut(round(as.numeric(age)/360), c(0,10,20,30,40,50,60,70,80,120),
                       labels = c("< 10 years","11-20","21-30","31-40","41-50","51-60", "61-70","71-80",">80 years" ))
    hage=as.data.frame( table(Patient_Age))
    dage=as.data.frame(hage)
    
    print(  ggplot(dage, aes(x= Patient_Age ,y=Freq)) + geom_boxplot()+geom_jitter() )
    
    
    
    info("Download success")
    dev.off()
  })
  
  
  observeEvent(input$PAD2,{
    pdf(paste(input$label_PAD2,".pdf"),width = 4,height = 5)
    
    one=sqlQuery(connect,paste("SELECT DATE_MED,PATIENT_IDENTIFIER from dbpfedev.medical_checkup"))     
    two=sqlQuery(connect,paste("SELECT LESION_AGE,PATIENT_IDENTIFIER from dbpfedev.sample"))
    three= sqldf("select DATE_MED,LESION_AGE from  one, two
                 
                 where   one.PATIENT_IDENTIFIER=two.PATIENT_IDENTIFIER ")
    days=    three$DATE_MED-three$LESION_AGE
    Lesion_Age_in_weeks <- cut(as.numeric(days), c(0, 15, 30, 45, 60, 75,90,105),
                               labels = c("< 2 weeks", "2 to 4  ", "4 to 6","6 to 8 ", 
                                          "8 to 10 ","10 to 12 ", "more than 3 weeks"))
    h=as.data.frame( table(Lesion_Age_in_weeks))
    d=as.data.frame(h)
    
    print(ggplot(d, aes(x= Lesion_Age_in_weeks ,y=Freq)) + geom_boxplot())
    
    
    info("Download success")
    dev.off()
  })
  
  observeEvent(input$CalendarD,{
    
    dateMed=as.data.frame( table( sqlQuery(connect,paste("SELECT 	DATE_MED from dbpfedev.medical_checkup"))))
    dateMed$Var1=as.Date(dateMed$Var1)
    
    
    Cal <- gvisCalendar(dateMed, 
                        datevar="Var1", 
                        numvar="Freq",
                        options=list(
                          title="Daily Patients",
                          height=320,
                          calendar="{yearLabel: { fontName: 'Times-Roman',
                          fontSize: 32, color: '#1A8763', bold: true},
                          cellSize: 10,
                          cellColor: { stroke: 'red', strokeOpacity: 0.2 },
                          focusedCellColor: {stroke:'red'}}")
                        )
    print(Cal, tag="chart", paste(input$label_cal,".html"))
    info("Download success")
    
    })
  
  observeEvent(input$CalendarD2,{
    
    dateMed=as.data.frame( table( sqlQuery(connect,paste("SELECT 	DATE_MED,LOGINUSER from dbpfedev.medical_checkup"))))
    dateMed$DATE_MED=as.Date(dateMed$DATE_MED)
    dateMed=dateMed[which(dateMed$LOGINUSER==USER$name),]
    
    Cal <- gvisCalendar(dateMed, 
                        datevar="DATE_MED", 
                        numvar="Freq",
                        options=list(
                          title="Daily Patients",
                          height=320,
                          calendar="{yearLabel: { fontName: 'Times-Roman',
                          fontSize: 32, color: '#1A8763', bold: true},
                          cellSize: 10,
                          cellColor: { stroke: 'red', strokeOpacity: 0.2 },
                          focusedCellColor: {stroke:'red'}}")
                        )
    print(Cal, tag="chart", paste(input$label_cal2,".html"))
    info("Download success")
    
    
})
  
  observeEvent(input$MPNuD,{
    
    totalChUp=sqlQuery(connect,paste("SELECT * from dbpfedev.medical_checkup"))
    TS=totalChUp[,"DATE_MED"]
    TS <- c(TS,seq(as.Date(TS[1]), as.Date(TS[length(TS)]), "month") )
    Month=as.yearmon(TS)
    PM=table(Month)
    number=as.data.frame( PM)
    number[,2]=number[,2]-1
    TSSD=zoo(number[,2],seq(as.Date(TS[1]),as.Date(TS[length(TS)]),by="month") )
    MVG=dygraph(TSSD) %>% dyOptions(stackedGraph = TRUE) %>%   dyRangeSelector()
    
    htmlwidgets::saveWidget(MVG,  paste(input$label_MPNu,".html"))
    
    info("Download success") 
    
  })
  
  observeEvent(input$MPNuD2,{
    
    totalChUp2=sqlQuery(connect,paste("SELECT * from dbpfedev.medical_checkup"))
    TS2=totalChUp2[,"DATE_MED"][which(totalChUp2$LOGINUSER==USER$name  )]
    TS2 <- c(TS2,seq(as.Date(TS2[1]), as.Date(TS2[length(TS2)]), "month") )
    Month2=as.yearmon(TS2)
    PM2=table(Month2)
    number2=as.data.frame( PM2)
    number2[,2]=number2[,2]-1
    TSSD2=zoo(number2[,2],seq(as.Date(TS2[1]),as.Date(TS2[length(TS2)]),by="month") )
    MVG2=dygraph(TSSD2) %>% dyOptions(stackedGraph = TRUE) %>% dyRangeSelector()
    
    htmlwidgets::saveWidget(MVG2,  paste(input$label_MPNu2,".html"))
    info("Download success")
    
  })
  
  
  observeEvent(input$PieNvD,{
    pdf(paste(input$label_PieNvD,".pdf"),width = 15,height = 10)
    dataPIE=sqlQuery(connect,paste("SELECT * from dbpfedev.",input$ttestPIE))
    
    Levels=dataPIE[,input$ttestPIEnames] 
    print( ggplot(dataPIE, aes(x = factor(1),fill =Levels )) + geom_bar(width = 1)+ coord_polar(theta = "y") )
    
    info("Download success")
    dev.off()
  })
  
  observeEvent(input$PieNvD2,{
    pdf(paste(input$label_PieNvD2,".pdf"),width = 15,height = 10)
    
    dataPIE2=sqlQuery(connect,paste("SELECT * from dbpfedev.",input$ttestPIE2))
    dataPIE2N=dataPIE2[c(which(dataPIE2$LOGINUSER== USER$name)),]
    
    Levels=dataPIE2N[,input$ttestPIEnames2] 
    print( ggplot(dataPIE2N, aes(x = factor(1),fill =Levels )) + geom_bar(width = 1)+ coord_polar(theta = "y") )
    
    info("Download success")
    dev.off()
  })
  
  observeEvent(input$MapD,{
    pdf(paste(input$label_MapD,".pdf"),width = 15,height = 10)
    
    sam= sqlQuery(connect,paste("SELECT SPECIES,PATIENT_IDENTIFIER	 from dbpfedev.sample"))
    reg=sqlQuery(connect,paste("SELECT COUNTRY_,CITY	 from dbpfedev.region"))
    town=sqlQuery(connect,paste("SELECT CITY,PATIENT_IDENTIFIER	 from dbpfedev.travel_residency"))
    
    regC=reg[which(reg[,"COUNTRY_"]== input$countriesshop) ,]
    
    
    Tab=sqldf("select CITY,SPECIES from  sam, town
              
              where   sam.PATIENT_IDENTIFIER=town.PATIENT_IDENTIFIER ")
    TabPl=Tab[which(Tab$CITY %in% regC$CITY),]
    TabSl=TabPl[which(TabPl[,"SPECIES"]== input$especesshop),]
    TabSl=as.data.frame(TabSl)
    testttttttt=summaryBy(SPECIES~.,data =TabSl, FUN = length )
    TabOl=as.data.frame(testttttttt)
    
    df2 <- data.frame(location = as.character(TabOl$CITY),
                      values = TabOl$SPECIES.length,
                      stringsAsFactors = FALSE)
    
    
    locs_geo <- geocode(df2$location)
    df2 <- cbind(df2, locs_geo)
    
    mapK <- get_map(location = input$countriesshop, zoom = 6)
    MO= ggmap(mapK) + geom_point(data = df2, aes(x = lon, y = lat, size = values,colour = values)) 
    print(MO)
    
    info("Download success")
    dev.off()
  })
  
  observeEvent(input$MapD2,{
    pdf(paste(input$label_MapD2,".pdf"),width = 15,height = 10)
    
    mapK <- get_map(location = input$countriesshop, zoom = 6)
    
    sam= sqlQuery(connect,paste("SELECT SPECIES,PATIENT_IDENTIFIER,LOGINUSER	 from dbpfedev.sample"))
    sam=sam[which(sam[,"LOGINUSER"]==USER$name),]
    reg=sqlQuery(connect,paste("SELECT COUNTRY_,CITY	 from dbpfedev.region"))
    town=sqlQuery(connect,paste("SELECT CITY,PATIENT_IDENTIFIER	 from dbpfedev.travel_residency"))
    
    regC=reg[which(reg[,"COUNTRY_"]== input$countriesshop) ,]
    
    
    Tab=sqldf("select CITY,SPECIES from  sam, town
              
              where   sam.PATIENT_IDENTIFIER=town.PATIENT_IDENTIFIER ")
    TabPl=Tab[which(Tab$CITY %in% regC$CITY),]
    TabSl=TabPl[which(TabPl[,"SPECIES"]== input$especesshop),]
    TabSl=as.data.frame(TabSl)
    testttttttt=summaryBy(SPECIES~.,data =TabSl, FUN = length )
    TabOl=as.data.frame(testttttttt)
    
    df2 <- data.frame(location = as.character(TabOl$CITY),
                      values = TabOl$SPECIES.length,
                      stringsAsFactors = FALSE)
    
    
    locs_geo <- geocode(df2$location)
    df2 <- cbind(df2, locs_geo)
    
    
    M= ggmap(mapK) + geom_point(data = df2, aes(x = lon, y = lat, size = values,colour = values)) 
    print(M)
    
    info("Download success")
    dev.off()
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
