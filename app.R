# Load packages
library(shiny)
library(shinythemes)

# Define UI
ui <- fluidPage(theme = shinytheme("flatly"),
    navbarPage("Forest Volume Calculator",
         tabPanel("Tree Volume",
                  sidebarPanel(
                    tags$h5("Input your values"),
                    numericInput("dbh", "Diameter (cm):", ""),
                    numericInput("height", "Height (m):", "")
                  ), # sidebarPanel
                  mainPanel(
                    h2("Volume Calculator"),
                    h5("result"),
                    verbatimTextOutput("result", placeholder =  T),
                  ) # mainpanel
          ), # Volume Calculator, tabPanel
         
         tabPanel("Tree Basal Area",
                  sidebarPanel(
                    tags$h5("Input your values"),
                    numericInput("dbh2", "Diameter (cm):", "")
                  ), #sidebarPanel2
                  mainPanel(
                    h2("Basal Area Calculator"),
                    h5("result"),
                    verbatimTextOutput("result2", placeholder = T),
                  ) # mainPanel2
          ), # Basal Area Calculator, tabPanel
         
         tabPanel("Volume per Hectare",
                  sidebarPanel(
                    tags$h5("Input your values"),
                    numericInput("meanvol", "Mean plot volume (cm)³:", ""),
                    numericInput("plotsize", "Plot size (m²):", "")
                  ), #sidebarPanel3
                  mainPanel(
                    h2("Volume per Hectare Calculator"),
                    h5("result"),
                    verbatimTextOutput("result3", placeholder = T)
                  ) #mainpanel3
                  ), # Volume per hectare calculator, tabpanel
         
         tabPanel("Stand Volume",
                  sidebarPanel(
                    tags$h5("Input your values"),
                    numericInput("standsize", "Stand size (ha):", ""),
                    numericInput("volha", "Volume per hectare (m³/ha):", "")
                  ), # sidebarPanel4
                  mainPanel(
                    h2("Stand Volume"),
                    h3("result"),
                    verbatimTextOutput("result4", placeholder = T)
                  )
                  )
        ) #navlistbar
    ) #fluid page

# Define Server Function
server <- function(input, output, session){
  output$result <- renderPrint(
    {paste((pi * (input$dbh/200)^2 * input$height), "m")}
    ) #volume output
  
  output$result2 <- renderPrint(
    {paste((pi * (input$dbh2/2)^2/1000), "m²")}
    ) #basal area output
  
  output$result3 <- renderPrint(
    {paste((input$meanvol * 10000/input$plotsize), "m³/ha")}
    ) #volume per hectare output
  
  output$result4 <- renderPrint(
    {paste(input$standsize * input$volha, "m³")}
  ) #stand volume output
} # server

# Create Shiny object
shinyApp(ui, server)