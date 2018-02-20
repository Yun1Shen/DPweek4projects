#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(shiny)
library(arules)
library(arulesViz)
library(plotly)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    reactive({load("titanic.raw.rdata")})
    allrules<-reactive({apriori(titanic.raw)})
    rules<-reactive({apriori(titanic.raw,
                     control = list(verbose=F),
                     parameter = list(minlen=2,maxlen=input$maxlen, 
                                      supp=input$supp, conf=input$conf),
                     appearance = list(rhs=c("Survived=No", "Survived=Yes"),
                                       default="lhs"))})
    rulessorted<-reactive({sort(rules(),by="lift")})
    rulespruned<-reactive({rulessorted()[!is.redundant(rulessorted())]})
    output$plot1 <- renderPlotly({
     plotly_arules(rulespruned())
     })
    output$plot2 <- renderPlot({
        plot(allrules(),method = "graph",control = list(type = "items"))
    })
  
})
