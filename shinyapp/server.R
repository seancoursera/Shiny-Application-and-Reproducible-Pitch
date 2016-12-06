#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

housedata <- read.csv('kc_house_data.csv')

shinyServer(function(input, output) {
    
    
    model1 <- lm(price ~ sqft_living, data = housedata)
    model2 <- lm(price ~ sqft_above, data = housedata)
    
    model1pred <- reactive({
        SqftInput <- input$sliderSqft
        predict(model1, newdata = data.frame(sqft_living = SqftInput))
    })
    
    model2pred <- reactive({
        SqftInput <- input$sliderSqft
        predict(model2, newdata = 
                    data.frame(sqft_above = SqftInput))
    })
        
    
    
    
    output$plot1 <- renderPlot({
        SqftInput <- input$sliderSqft
        
        plot(housedata$price, housedata$sqft_living, xlab = "Square Feet", 
             ylab = "House price", bty = "n", pch = 16,
             xlim = c(0, 4000), ylim = c(0, 1500000))
        
            abline(model1, col = "steelblue", lwd = 2)
        
       
            model2lines <- predict(model2, newdata = data.frame(
                sqft_above = 290:4000))
            lines(290:4000, model2lines, col = "pink", lwd = 2)
       
        
        legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
               col = c("red", "blue"), bty = "n", cex = 1.2)
        points(SqftInput, model1pred(), col = "red", pch = 16, cex = 2)
        points(SqftInput, model2pred(), col = "blue", pch = 16, cex = 2)
    })
    
    output$pred1 <- renderText({
        model1pred()
    })
    
    output$pred2 <- renderText({
        model2pred()
    })
    output$pred3 <- renderText({
        (model1pred()+model2pred())/2
    })
})