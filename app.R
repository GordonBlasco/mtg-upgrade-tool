#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(shinydashboard)
#library(shinyWidgets)
library(DT)

comp_df <- read_csv("test_data.csv")

#### Sidebar ####
sidebar <- dashboardSidebar(
  #collapsed = TRUE,
  sidebarMenu(
    menuItem("Upload Data", 
             tabName = "upload_data", 
             icon = icon("redo", lib = "font-awesome")
    ),
    menuItem("Summary of Changes", 
             #icon = icon("th"), 
             tabName = "sum_of_changes"
             #badgeLabel = "new", 
             #badgeColor = "green"
    ),
    menuItem("Card Changes", 
             tabName = "card_table"#, 
             #icon = icon("dashboard")
    ),
    menuItem("Upgrade Path", 
             tabName = "upgrade_path"#, 
             #icon = icon("dashboard")
    )
  )
)


#### Table Body ####
body <- dashboardBody(
  tabItems(
    tabItem(tabName = "upload_data",
            fluidRow(
              column(width = 3,
                     box(width = NULL),
              
              column(width = 9,
                     box(width = NULL))
            ))),
    
    tabItem(tabName = "sum_of_changes",
            fluidRow(
              column(width = 3,
                     box(width = NULL),
              
              column(width = 9,
                     box(width = NULL))
            ))),
    
    tabItem(tabName = "card_table",
            fluidRow(
              column(width = 3,
                     box(width = NULL),
                     
                     column(width = 9,
                            box(width = NULL,
                                DTOutput('card_kept')))
              ))),
    
    tabItem(tabName = "upgrade_path",
            fluidRow(
              column(width = 3,
                     box(width = NULL),
                     
                     column(width = 9,
                            box(width = NULL))
              )))
    ))



# Define UI for application that draws a histogram
ui <- dashboardPage(
  dashboardHeader(title = "mtg comp tool"),
  skin = "red",
  sidebar,
  body
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  
  
  output$card_kept = renderDT(
    iris, options = list(lengthChange = FALSE)
  )

}

# Run the application 
shinyApp(ui = ui, server = server)
