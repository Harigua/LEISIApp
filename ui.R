
library(shiny)
library(shinydashboard)
library(shinyjs)



mydashboardHeader <- function(..., title = NULL, disable = FALSE,title.navbar=NULL, .list = NULL) {
  items <- c(list(...), .list)
  tags$header(class = "main-header",
              tags$style(HTML("
                              @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
                              
                              h1 {
                              font-family: 'Lobster', cursive;
                              font-weight: 500;
                              line-height: 1.1;
                              
                              color: #B0C4DE;
                              }
                              
                              ")),
              
              
              style = if (disable) "display: none;",
              uiOutput("userPanel"),
              span(class = "logo", title),
              tags$nav(class = "navbar navbar-static-top", role = "navigation",
                       span(shiny::icon("bars"), style = "display:none;"),
                       
                       title.navbar,
                       
                       div(class = "navbar-custom-menu",
                           tags$ul(class = "nav navbar-nav",
                                   items
                           )
                       )
              )
              )
}

shinyUI(
  dashboardPage(skin = "black",
                
                title="Lesionia",
                
                
                mydashboardHeader(title= "Lesionia", tags$img(src="logologo.png",height=40,widht=70,style="margin:5px 1300px 5px 3px;") ),
                
                
                
                
                
                
                
                
                dashboardSidebar(
                  
                  
                  sidebarSearchForm(label = "insert subject", "searchText", "searchButton"),
                  
                  
                  sidebarMenu(
                    
                    id= "tabs" ,
                    
                    
                    
                    
                    menuItem(h4("Home"),tabName = "acc2"),
                    
                    menuItem( h4("Data Management"),tabName = "dataMang",
                              
                              menuSubItem("Data Cleaning",tabName = "cleanD")),
                    
                    menuItem( h4("Data Input"),tabName = "datain",
                              menuSubItem("Add data",tabName = "OTD"),
                              menuSubItem("Update data",tabName = "SD")),
                    
                    
                    
                    menuItem(h4("Data Load"),tabName = "dataup",
                             menuSubItem("View Data",tabName = "VD"),
                             menuSubItem("Data General statistics  ",tabName = "DGS")),
                    
                    menuItem(h4("Data Analysis"),tabName = "dataup",
                             menuSubItem("Analyse Data",tabName = "AnD")),
                    menuItem(h4("Professionals recommand"),tabName = "doc",
                             menuSubItem("upload publication",tabName = "UP"))
                    
                    
                  )),
                
                
                
                dashboardBody(
                  tags$style(".nav-tabs {
                             background-color: 	#B0C4DE;
                             
                             }
                             .tabs-above > .nav > li[class=active] > a {
                             background-color: white;                              
                             color: white;
                             }
                             
                             .nav-tabs-custom .nav-tabs li.active:hover a, .nav-tabs-custom .nav-tabs li.active a {
                             background-color:white ;
                             border-color:transparent ;
                             }
                             
                             .nav-tabs-custom .nav-tabs li.active {
                             border-top-color: light-blue;
                             }"),
       
                  
                  tags$style(HTML("
                                  .content-wrapper,
                                  .right-side {
                                  background-color: #2F4F4F ;
                                  }
                                  
                                  
                                  ")),
                  
                  useShinyjs(),
                  
                  
                  tabItems(
                    
                    
                    tabItem(tabName = "VD",
                            
                            
                            column("", uiOutput("visualisation"),style="margin:5px 400px 5px 5px",width = 12),
                            column("",uiOutput("appkey2"),style="margin:5px 50px 100px 1065px",width = 6)
                            
                            
                            
                            
                            
                            
                    ),
                    
                    tabItem(tabName = "cleanD",
                            
                            
                            fluidRow (
                              uiOutput("Managementall",style="margin:5px 400px 5px 5px",width = 12),
                              uiOutput("appkey5",style="margin:5px 50px 100px 1065px",width = 6)
                            )
                    ),
                    
                    tabItem(tabName = "acc2",
                            
                            div(class = "login",
                                uiOutput("uiLogin"),
                                textOutput("pass"),
                                tags$head(tags$style("#pass{color: red;")),
                                
                                column(10, uiOutput("mail",style="margin:0px 0px 5px 140px;")),
                                column(10,uiOutput("mailcontent",style="margin:0px 0px 5px 120px;")),
                                column(12, uiOutput("imgslide",style="margin:50px 0px 5px 100px;"))
                            ),
                            
                            
                            
                            
                            
                            
                            column(12, uiOutput("homenav"),style="margin:5px 28px 5px 150px;"),
                            
                            
                            div(
                              column(4,htmlOutput("map1"),style="margin:5px 380px 5px 150px;")
                            )
                    ),
                    
                    tabItem("OTD",
                            column("",uiOutput("Patient"),style="margin:50px 400px 5px 105px",width = 12),
                            column("",uiOutput("appkey"),style="margin:390px 400px 5px 105px",width = 12)
                            
                            
                    ),
                    tabItem("AnD",
                            column("", uiOutput("DataAnalysis"),style="margin:5px 400px 5px 5px",width = 12),
                            column("",uiOutput("appkey3"),style="margin:5px 50px 5px 1065px",width = 6)
                            
                            
                    ),
                    
                    
                    tabItem("UP",
                            column("",uiOutput("appkey4"),style="margin:5px 0px 5px 1050px",width = 6)
                            
                            
                    )
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                  ))))



