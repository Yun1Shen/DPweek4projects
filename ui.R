#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(arules)
library(arulesViz)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Association rulre mining with Titanic data "),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       helpText("Create Association rules graph for using ",a("Titanic data", href="http://www.rdatamining.com/data/titanic.raw.rdata"),
                "by ", a("Apriori algorithm.", href = "https://en.wikipedia.org/wiki/Apriori_algorithm"), "The all rules are using all the data genenrate all the possible rules with the fixed default 
                parameter minimum support of 0.1, minimum confidence of 0.8, maximum of 10 items (maxlen). The rules prune are aimed at 
                rhs only contaning survived with the parameter you can control on the sidebar."),
       sliderInput("supp",
                   "minimum support:",
                   min = 0.0001,
                   max = 0.1,
                   value = 0.005),
       sliderInput("conf", 
                   "minimum confidence:", 
                   min = 0.5, 
                   max =1, 
                   value = 0.8),
       sliderInput("maxlen", 
                   "max length of rules:", 
                   min = 2, 
                   max =10, 
                   value = 10,
                   step = 1),
        submitButton("Submit") # New!
        
       
    ),
     
    # Show a plot of the generated distribution
    mainPanel(
        tabsetPanel(
            tabPanel("All Rules", plotOutput("plot2")),
            tabPanel("Rules Pruned", plotlyOutput("plot1"))
            
        )
        
   )
    
)))
