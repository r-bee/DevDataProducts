
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(ggplot2)
library(scales)

shinyServer(function(input, output) {
  strCriteria2 <-""
  output$sopPlot <- renderPlot({
    

    # Read the data    
    data <- read.csv("FactTable.csv")
    
    # Select here the categories of interest.
    strCriteria <- paste ("C == '",input$category1,"' | ", sep ="", collapse = '')
    strCriteria <- strtrim(strCriteria, nchar(strCriteria)-2)
    catCriteria <- parse(text = c(strCriteria))
    subData <- subset(data, eval(catCriteria))
    
    # Select here the years of interest.
    startYear = input$startYear
    endYear = as.integer(input$endYear)
    subData <- subset(subData, Y>=startYear & Y<=endYear)
    
    # Plot!
    g <- ggplot(subData,aes(x=Y, y=Q, color=C, group=C)) + geom_line() + geom_point()
    g + scale_y_continuous("Amount", label = dollar) + scale_x_continuous("Year") + scale_color_discrete(name="Categories:")
    
    
  })
#  output$debug <- renderPrint({
 #   st <- paste (input$category1, sep= " ", collapse = ', ')
#    st <- paste ("Displaying:",st)
#    st
#    })
})
