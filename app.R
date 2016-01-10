
setwd("C:/Users/Ricky/Desktop/StockPrice")

script_list <- list("start.R","StockCode.R")

for (loop_variable in 1:length(script_list)){
  try(source(script_list[[loop_variable]]))
}


library(shiny)
library (tseries)
library (xts)
library (zoo)
library (quantmod)

ui <- fluidPage(
  titlePanel(title = "Stock Prediction Model"),
  
  sidebarLayout(
    sidebarPanel( helpText("Select a stock to examine. 
                           Information will be collected from yahoo finance."),
                  
          
                  dateRangeInput("dates", 
                                 "Date range",
                                 start = "2013-01-01", 
                                 end = as.character(Sys.Date())),
                  
                  br(),
                  br(),
                  
                  actionButton(inputId = "go",
                               label = "Predict")
    ),
    mainPanel(
      plotOutput("plot"),
      verbatimTextOutput(outputId = "text_form")
              )
   
  )
)

  
  
server <- function(input, output){
  
  output$plot <- renderPlot({
    data <- getSymbols(code_stock, src = "yahoo", 
                       from = input$dates[1],
                       to = input$dates[2],
                       auto.assign = FALSE)
    
    chartSeries(data, theme = chartTheme("white"), 
                type = "line", TA = NULL)
  })
  
  data1 <- eventReactive(input$go, Close_rate)
  output$text_form <- renderText({paste("The Closing Rate for ",Sys.Date(),"will be around: ",data1())})
}

shinyApp(ui = ui, server = server)
