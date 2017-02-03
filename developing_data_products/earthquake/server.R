
library(shiny)
library(leaflet)
library(dplyr)

shinyServer(function(input, output, session) {

  filteredData1 <- reactive({
      eq <- read.csv('earthquakes.csv')
      eq$year <- as.numeric(format(as.Date(eq$time), '%Y'))
      eq$popup <- paste(eq$mag, eq$place, eq$time, sep = "\n")
      periodpal <- colorFactor(heat.colors(length(eq$mag)), eq$mag)
      filter(eq, year == input$year)
  })
  
  filteredData2 <- reactive({
      eq <- read.csv('earthquakes.csv')
      eq$year <- as.numeric(format(as.Date(eq$time), '%Y'))
      eq$popup <- paste(eq$mag, eq$place, eq$time, sep = "\n")
      periodpal <- colorFactor(heat.colors(length(eq$mag)), eq$mag)
      filter(eq, year >= input$endyear[1] & year <= input$endyear[2])
  })
  
  filteredData3 <- reactive({
      eq <- read.csv('earthquakes.csv')
      eq$year <- as.numeric(format(as.Date(eq$time), '%Y'))
      eq$popup <- paste(eq$mag, eq$place, eq$time, sep = "\n")
      periodpal <- colorFactor(heat.colors(length(eq$mag)), eq$mag)
      filter(eq, year >= input$endyear[1] & year <= input$endyear[2]) %>%
          filter(mag >= input$mag[1] & mag <= input$mag[2])
  })
  
  observe({
      eq <- read.csv('earthquakes.csv')
      eq$year <- as.numeric(format(as.Date(eq$time), '%Y'))
      eq$popup <- paste(eq$mag, eq$place, eq$time, sep = "\n")
      periodpal <- colorFactor(heat.colors(length(eq$mag)), eq$mag)
      proxy <- leafletProxy('map', data = eq)
      proxy %>% clearControls()
      if (input$legend) {
          proxy %>%
              addLegend(position = 'bottomleft',
                        pal = periodpal,
                        values = seq(min(eq$mag), max(eq$mag), by = 0.5),
                        opacity = 0.5)
      }
  })
  
  observe({
      eq <- read.csv('earthquakes.csv')
      eq$year <- as.numeric(format(as.Date(eq$time), '%Y'))
      eq$popup <- paste(eq$mag, eq$place, eq$time, sep = "\n")
      periodpal <- colorFactor(heat.colors(length(eq$mag)), eq$mag)
      leafletProxy('map', data = filteredData3()) %>%
          clearShapes() %>%
          addTiles() %>%
          addCircles(lng = ~longitude, lat = ~latitude, weight = ~mag,
                     radius = ~mag * 2500, popup = ~popup,
                     color = ~periodpal(mag), fillColor = 'blue')
  })
  
  observe({
      eq <- read.csv('earthquakes.csv')
      eq$year <- as.numeric(format(as.Date(eq$time), '%Y'))
      eq$popup <- paste(eq$mag, eq$place, eq$time, sep = "\n")
      eq$period <- cut(eq$year, breaks = c(1900, 1940, 1980, 2017), 
                       dig.lab = 10, include.lowest = T,
                       labels = c('1900 - 1940', '1940 - 1980', '1980 - 2017'))
      periodpal <- colorFactor(heat.colors(length(eq$mag)), eq$mag)
      leafletProxy('map', data = filteredData1()) %>%
          clearShapes() %>%
          addTiles() %>%
          addCircles(lng = ~longitude, lat = ~latitude, weight = ~mag,
                     radius = ~mag * 2500, popup = ~popup,
                     color = ~periodpal(mag), fillColor = 'blue')
  })

  observe({
      eq <- read.csv('earthquakes.csv')
      eq$year <- as.numeric(format(as.Date(eq$time), '%Y'))
      eq$popup <- paste(eq$mag, eq$place, eq$time, sep = "\n")
      eq$period <- cut(eq$year, breaks = c(1900, 1940, 1980, 2017), 
                       dig.lab = 10, include.lowest = T,
                       labels = c('1900 - 1940', '1940 - 1980', '1980 - 2017'))
      periodpal <- colorFactor(heat.colors(length(eq$mag)), eq$mag)
      
      leafletProxy('map', data = filteredData2()) %>%
          clearShapes() %>%
          addTiles() %>%
          addCircles(lng = ~longitude, lat = ~latitude, weight = ~mag,
                     radius = ~mag * 2500, popup = ~popup,
                     color = ~periodpal(mag), fillColor = 'blue')
  })
  
  output$map <- renderLeaflet({
      eq <- read.csv('earthquakes.csv')
      eq$year <- as.numeric(format(as.Date(eq$time), '%Y'))
      eq$popup <- paste(eq$mag, eq$place, eq$time, sep = "\n")
      eq$period <- cut(eq$year, breaks = c(1900, 1940, 1980, 2017), 
                       dig.lab = 10, include.lowest = T,
                       labels = c('1900 - 1940', '1940 - 1980', '1980 - 2017'))
      
      periodpal <- colorFactor(heat.colors(length(eq$mag)), eq$mag)
      
      leaflet(eq) %>% 
          setView(lng = 81.092, lat = 29.598, zoom = 3) %>%
          addTiles() %>%
          addCircles(lng = ~longitude, lat = ~latitude, weight = ~mag,
                     radius = ~mag * 2500, popup = ~popup,
                     color = ~periodpal(mag), fillColor = 'blue') %>%
          addLegend(position = 'bottomright',
                    pal = periodpal,
                    values = ~mag,
                    opacity = 0.5)
  })
  
  output$magChart <- renderPlotly({
      eq <- read.csv('earthquakes.csv')
      eq$year <- as.numeric(format(as.Date(eq$time), '%Y'))
      eq$popup <- paste(eq$mag, eq$place, eq$time, sep = "\n")
      eq$magBins <- cut(eq$mag, breaks = 3, dig.lab = 1, include.lowest = T)
      eq_grp <- group_by(eq, year, magBins) %>% 
          summarise(magBinsCount = length(magBins))
      plot_ly(eq_grp, x = ~year, y = ~magBinsCount, 
              type = 'scatter', 
              mode = 'markers', 
              color = ~magBins)
  })
  
  output$ttest1 <- renderPrint({
      eq <- read.csv('earthquakes.csv')
      eq$year <- as.numeric(format(as.Date(eq$time), '%Y'))
      eq$popup <- paste(eq$mag, eq$place, eq$time, sep = "\n")
      eq$magBins <- cut(eq$mag, breaks = 3, dig.lab = 1, include.lowest = F)
      eq$period <- cut(eq$year, breaks = c(1900, 1940, 1980, 2017), 
                       dig.lab = 10, include.lowest = T,
                       labels = c('1900 - 1940', '1940 - 1980', '1980 - 2017'))
      t.test(filter(eq, period == '1900 - 1940' & magBins == '(6,7]')$mag, 
             filter(eq, period == '1940 - 1980' & magBins == '(6,7]')$mag)
  })
  
  output$ttest2 <- renderPrint({
      eq <- read.csv('earthquakes.csv')
      eq$year <- as.numeric(format(as.Date(eq$time), '%Y'))
      eq$popup <- paste(eq$mag, eq$place, eq$time, sep = "\n")
      eq$magBins <- cut(eq$mag, breaks = 3, dig.lab = 1, include.lowest = F)
      eq$period <- cut(eq$year, breaks = c(1900, 1940, 1980, 2017), 
                       dig.lab = 10, include.lowest = T,
                       labels = c('1900 - 1940', '1940 - 1980', '1980 - 2017'))
      t.test(filter(eq, period == '1940 - 1980' & magBins == '(6,7]')$mag, 
             filter(eq, period == '1980 - 2017' & magBins == '(6,7]')$mag)
  })
  
})

