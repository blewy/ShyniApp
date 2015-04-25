
library(shiny)


  # Define UI for dataset viewer application
  shinyUI(fluidPage(
    
    # Application title.
    titlePanel("Decision Tree Options"),
    
    # Sidebar with controls to select a dataset and specify the
    # number of observations to view. The helpText function is
    # also used to include clarifying text. Most notably, the
    # inclusion of a submitButton defers the rendering of output
    # until the user explicitly clicks the button (rather than
    # doing it immediately when inputs change). This is useful if
    # the computations required to render output are inordinately
    # time-consuming.
    sidebarLayout(
      sidebarPanel(


       selectInput("factor", "Choose a Feature:", 
                    choices = c("Transmission (0 = automatic, 1 = manual)","Number of cylinders", "Displacement (cu.in.)","Gross horsepower", "Rear axle ratio", "Weight (lb/1000)","1/4 mile time","V/S",
                    "Miles/(US) gallon","Number of forward gears","Number of carburetors")) ,
        
        numericInput("obs", "Minimum number of observations that must exist in a node in order for a split to be attempted:", 5),
      # numericInput("minbucket", "the minimum number of observations in any terminal node:", 1),
       sliderInput("decimal", "Choose the amount of regularization:", 
                   min = 0, max = 0.1, value = 0.01, step= 0.01),
        
        helpText("Note: while the data view will show only the specified",
                 "number of observations, the summary will still be based",
                 "on the full dataset."),
        
        submitButton("Update View")
      ),
      
      # Show a summary of the dataset and an HTML table with the
      # requested number of observations. Note the use of the h4
      # function to provide an additional header above each output
      # section.
      mainPanel(
   
        h3("Tree Plot"),
        plotOutput("plottree"),
        h4("Cross Validation Results"),
        plotOutput("plotcp")
       # h4("Results"),
      #  verbatimTextOutput("tree")
        
        
      )
    )
  ))
