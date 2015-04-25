

library(shiny)
library(datasets)
library(rpart)      	        # Popular decision tree algorithm
library(rattle)					# Fancy tree plot
cars$am<-as.factor(cars$am)
cars$vs<-as.factor(cars$vs)
cars$cyl<-as.factor(cars$cyl)
cars$gear<-as.factor(cars$gear)
cars$carb<-as.factor(cars$carb)

class(cars$qsec)
#CART1
set.seed(1234)

# Define server logic required to summarize and view the 
# selected dataset
shinyServer(function(input, output) {
  
  featureInput <- reactive({
    switch(input$factor,
           "Transmission (0 = automatic, 1 = manual)"= "am",
           "Number of cylinders"="cyl", 
           "Displacement (cu.in.)"="disp",
           "Gross horsepower"="hp",
           "Rear axle ratio"="drat",
           "Weight (lb/1000)"="wt",
           "1/4 mile time"="qsec",
           "V/S"="vs",
           "Miles/(US) gallon"="mpg",
           "Number of forward gears"="gear",
           "Number of carburetors"="carb")
  })
  # Define server logic required to summarize and view the 
  # selected dataset


  
  # Generate a summary of the dataset
  
  tree <- reactive({
    form<-as.formula(as.character(paste(featureInput()," ~ .")))
    rpart(form,data=cars,control=rpart.control(minsplit=input$obs,cp=input$decimal))
  })
  
  output$tree <- renderPrint({
    printcp(tree())
  })
  
  # Generate a summary of the dataset
  output$plottree <- renderPlot({
    fancyRpartPlot(tree())
   # plot(tree(), uniform=TRUE,
  #       main="Classification Tree for Kyphosis")
  #  text(tree(), use.n=TRUE, all=TRUE, cex=.8)
  })
  
  # # visualize cross-validation results 
  output$plotcp<- renderPlot({
    plotcp(tree())
  })
  # Generate a summary of the dataset
  output$tree2 <- renderPrint({
    as.character(input$factor)
  })
  
  # Generate a summary of the dataset
  output$minobs <- renderPrint({
    as.character(input$obs)
  })


 
  })
