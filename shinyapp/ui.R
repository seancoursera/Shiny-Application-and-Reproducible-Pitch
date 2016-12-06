#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
shinyUI(fluidPage(
    titlePanel("Predict House price by living sqft and above sqft"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderSqft", "What is the square feet of the house?", 290, 3000, value = 10),
            checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
            checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE)
        ),
        mainPanel(
            plotOutput("plot1"),
            h3("Predicted House price from Model 1:"),
            textOutput("pred1"),
            
            h3("Predicted House price from Model 2:"),
            textOutput("pred2"),
            h3("Average predicted price of the 2 models:"),
            textOutput("pred3")
        )
    )
))