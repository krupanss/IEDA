# ************************************Bi Variate Group Histogram************************************
library(shiny)
library(shinydashboard)
# **************************Select Inputs**************************
output$GHistMeasure = renderUI({
  selectInput("GHistMeasure", "Select Measure",
              c(selectdata()$FeatureValue[which(selectdata()$FeatureName == "Measures")]), rmeasures()[1])
})

output$GHistDimension = renderUI({
  selectInput("GHistDimension", "Select Dimension",
              c(selectdata()$FeatureValue[which(selectdata()$FeatureName == "Dimensions")]), rdimensions()[1])
})

# **************************Reactive Variable**************************
dataInput5 = reactive({
  if(is.null(input$GHistDimension) & is.null(input$GHistMeasure)) {
    return(NULL)
  } else {
    inputdata5 = finalInputData() %>% select(one_of(c(input$GHistMeasure, input$GHistDimension)))
    colnames(inputdata5) = c("XVar", "YVar")
    return(inputdata5)
  }
})

# **************************Outputs**************************
output$GHistPlot = renderPlotly(
  if(is.null(dataInput5())) {
    return()
  } else {
    # ggplotly(dataInput5() %>%
    #            ggplot(aes(x = XVar, fill = YVar)) + geom_histogram() +
    #            facet_grid(~YVar) +
    #            labs(x = input$GHistMeasure, y = "No of records",
    #                 title = paste0("Distribution of ", input$GHistMeasure, " across ", input$GHistDimension)))
    #
    dataInput5() %>% count(XVar, YVar) %>%
      plot_ly(x = ~ XVar, y = ~ n, color = ~ YVar, type = "bar") %>%
      layout(title = paste0("Distribution of ", input$GHistMeasure, " across ", input$GHistDimension),
             xaxis = list(title = input$GHistMeasure), yaxis = list(title = "No of records"), legend = TRUE)
  })
