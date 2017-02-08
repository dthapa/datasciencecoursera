#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$salaryBracket <- renderUI({
        selectInput('salary', 'Salary Bracket:', unique(best_evaluated$salary))
    })
    output$projectNum <- renderUI({
        sliderInput('project', 'Number of Project:', 7 , min = 0, max = 10)
    })
    output$satisfactionLevel <- renderUI({
        sliderInput('satisfaction', 'Satisfaction:', 0.11 , min = 0, max = 1)
    })
    output$timeWithCompany <- renderUI({
        sliderInput('timeWithCompany', 'Time Spent with Company', 4 , min = 1, max = 15)
    })
    output$avgMonthlyHour <- renderUI({
        sliderInput('avgMonthlyHour', 'Average Monthly Hour', 270 , min = 10, max = 500)
    })
    output$dept <- renderUI({
        selectInput('dept', 'Department:', unique(best_evaluated$dept))
    })
    output$workAccident <- renderUI({
        radioButtons('accident', 'Work Accident', c('Yes' = 1, 'No' = 0), selected = 'No')
    })
    output$promotion <- renderUI({
        radioButtons('promotion', 'Promotion last 5 years:', c('Yes' = 1, 'No' = 0), selected = 'No')
    })

    output$glmError <- renderPrint({
        trainError <- mean(as.numeric(predict(modelGLM, train, type = 'response') >= 0.5) == train$left)
        testError <- mean(as.numeric(predict(modelGLM, test, type = 'response') >= 0.5) == test$left)
        data.frame(trainError, testError)
    })
    
    output$glmSummary <- renderPrint({
        summary(modelGLM)
    })
    
    output$glmCoeff <- renderPrint({
        round(sort(exp(modelGLM$coefficients), decreasing = TRUE), 5)
    })

    output$rfSummary <- renderPrint({
        summary(modelRF)
    })
    
    output$rfError <- renderPrint({
        trainError <- mean(train$left == as.numeric(predict(modelRF, train) >= 0.5))
        testError <- mean(test$left == as.numeric(predict(modelRF, test) >= 0.5))
        data.frame(trainError, testError)
    })
    
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
  getInput <- reactive({
    data.frame(satisfaction_level = input$satisfaction,
                  number_project = input$project,
                  average_montly_hours = input$avgMonthlyHour,
                  time_spend_company = input$timeWithCompany,
                  Work_accident = as.numeric(input$accident),
                  promotion_last_5years = as.numeric(input$promotion),
                  salary = input$salary)
  })
  
  output$predictionMeter <- renderGvis({
      prob <- round(predict(modelGLM, getInput(), type = 'response') * 100, 2)
      retention <- gvisGauge(data.frame(retention = 'departure %', leave = prob),
                             options=list(min=0, max=100, greenFrom=0,
                                          greenTo=30, yellowFrom=30, yellowTo=60,
                                          redFrom=60, redTo=100, width=400, height=300))
      retention
  })
  
  updatePredictionRF <- reactive({
      predict(modelRF, getInput())
  })
  
  output$predictionRF <- renderText({
      updatePredictionRF()
  })
  
  output$histogramPlotly <- renderPlotly({
      train$salary <- as.numeric(train$salary)
      d <- melt(train, id.vars = c('dept', 'left'))
      g <- ggplot(d,aes(x = value, fill = factor(left))) + 
          facet_wrap(~variable,scales = "free_x") + 
          geom_histogram(bins = 10)
      ggplotly(g)
  })
})
