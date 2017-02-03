library(shiny)
library(RColorBrewer)
library(plotly)
library(leaflet)
library(dplyr)

ui <- fluidPage(
    titlePanel('Earthquakes'),
    sidebarPanel(
        sliderInput('year', 'Exact Year', 1900, 2017, value = 1980, step = 1, animate = TRUE),
        sliderInput('endyear', 'Inclusive Years', 1900, 2017, value = range(1980,2015), step = 1),
        sliderInput('mag', 'Magnitude for Inclusive Years', 6, 9.5,
                    value = 6:9.5, step = 0.1),
        checkboxInput("legend", "Show legend", FALSE),
        p('Exact Year displays all earthquake activities for that year only (use animate button)'),
        p('Don\'t forget about the \'show legend\' toggle and the \'Magnitudes Chart\'')

    ),
    mainPanel(
        tabsetPanel(
            tabPanel('Map', leafletOutput('map')),
            tabPanel('Magnitudes Chart', plotlyOutput('magChart')),
            tabPanel('1900-1940 / 1940-1980', verbatimTextOutput('ttest1')),
            tabPanel('1940-1980 / 1980-2017', verbatimTextOutput('ttest2'))
        ),
        h5('There is some statistical evidence to suggest earthquake activities in the [6 - 7] magnitude
          range have been going up recently (1980 - 2017) compared to pre 1940; however same isn\'t true 
          when comparing with (1940 - 1980) data.'),
        p(strong('Data collected from USGS 6+ mag, 1900 - early 2017')),
        a('http://earthquake.usgs.gov/fdsnws/event/1/query.csv?starttime=1900-01-01%2000:00:00&endtime=2017-02-03%2023:59:59&minmagnitude=6&orderby=time,')
    )
)
