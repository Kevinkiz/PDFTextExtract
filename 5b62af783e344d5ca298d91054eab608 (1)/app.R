#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(pdftools)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Upload PDF"),
      actionButton("extract", "Extract Text")
    ),
    mainPanel(
      uiOutput("text")
    )
  )
)

server <- function(input, output) {
  
  extract_text <- reactive({
    if (is.null(input$file)) return(NULL)
    
    # extract text from pdf
    text <- pdf_text(input$file$datapath)
    
    # return text as a character vector
    return(text)
  })
  
  output$text <- renderText({
    if (is.null(extract_text())) return("Upload a PDF to extract text.")
    
    # concatenate the text into a single string
    text <- paste(extract_text(), collapse = " ")
    
    # return the text
    return(text)
  })
}

shinyApp(ui, server)
