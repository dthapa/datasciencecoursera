#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Retention Prediction for Highly Reviewed Employees"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       uiOutput("salaryBracket"),
       uiOutput('projectNum'),
       uiOutput('satisfactionLevel'),
       uiOutput('timeWithCompany'),
       uiOutput('avgMonthlyHour'),
       uiOutput('workAccident'),
       uiOutput('promotion')
    ),
    # Show a plot of the generated distribution
    mainPanel(
        tabsetPanel(
            tabPanel('Prediction', 
                     htmlOutput('predictionMeter'),
                     p('This app predicts whether highly reviewed employees will continue'),
                     p('to remain in the company. last evaluation of >= 0.8 (on a 0 - 1 scale)'),
                     p('Toggle respective features for an employee to generate this prediction interval on the fly.'),
                     p('Higher values mean more likely to leave'),
                     p('Some common indicators for leaving include'),
                     p('low pay, high project count, lower satisfaction,'),
                     p('between 3 - 5 years with the company, higher avg monthly hour, lack of promotion and more.'),
                     p('Find more details for predictor significance in the Logistic Regression tab'),
                     p('A randomforest model is also provided, but due to its black box nature, it'),
                     p('should only serve as an added test on the prediction'),
                     p('dataset recieved from kaggle: '),
                     p('https://www.kaggle.com/ludobenistant/hr-analytics')),
            tabPanel('Logistic Regression', 
                     verbatimTextOutput('glmError'), 
                     verbatimTextOutput('glmSummary'),
                     verbatimTextOutput('glmCoeff')),
            tabPanel('RandomForest', 
                     verbatimTextOutput('predictionRF'),
                     verbatimTextOutput('rfError'), 
                     verbatimTextOutput('rfSummary')),
            tabPanel('Histograms',
                     plotlyOutput('histogramPlotly'))
        )
    )
  )
))
