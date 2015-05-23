# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

data <- read.csv("FactTable.csv")
categories <- as.character(unique(data$C))
years <- as.integer(data$Y)

shinyUI(pageWithSidebar(
  

  # Application title
  headerPanel("Statement of Operations for VWX Consulting"),
  
  # Sidebar with a selectize box for choosing categories and two sliders for the year from and to.
  sidebarPanel(
      h3("Overview:"),
      helpText("VWX Consulting is a not-for-profit that provides consulting services. Its Annual Statement of Operations displays VWX's performance in major Revenue and Expense categories. 
               This application allows you to select one or more of those categories and display their changes over a specified period of time."),
      hr(),
      h3("Select Categories to Display:"),
      helpText("Please select from the list the Expense and/or Revenue categories you are interested in."),
      
      selectizeInput("category1",
                   "Category:",
                   choices = categories,
                   multiple = TRUE),
      hr(),
      h3("Select Year Range:"),
      helpText("Please select the year range for which you want to display data of the above categories."),    
      sliderInput("startYear",
                  "Start Year:",
                min = 2004,
                max = max(years),
                value = 2004, 
                step = 1,
                sep = "",
                round = TRUE),
      sliderInput("endYear",
                "End Year:",
                min = 2004,
                max =  max(years),
                value = 2013, 
                step = 1,
                sep = "")
      
    ),
    
  # Show the plot
  mainPanel(
    plotOutput("sopPlot"),
    textOutput("debug")
  )
))

