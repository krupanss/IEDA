# ************************************Multi Variate Scatter Plot************************************
library(shiny)
library(shinydashboard)
# **************************Select Inputs**************************
output$MultiMeasure1 = renderUI({
  selectInput("MultiMeasure1", "Select Measure1",
              c(selectdata()$FeatureValue[which(selectdata()$FeatureName == "Measures")]), rmeasures()[1])
})

output$MultiMeasure2 = renderUI({
  selectInput("MultiMeasure2", "Select Measure2",
              c(selectdata()$FeatureValue[which(selectdata()$FeatureName == "Measures")]), rmeasures()[2])
})

output$MultiDimension = renderUI({
  selectInput("MultiDimension", "Select Dimension",
              c(selectdata()$FeatureValue[which(selectdata()$FeatureName == "Dimensions")]), rdimensions()[1])
})

# **************************Reactive Variable**************************
dataInput6 = reactive({
  if(is.null(input$MultiMeasure1) & is.null(input$MultiMeasure2) & is.null(input$MultiDimension)) {
    return(NULL)
  } else if(input$MultiMeasure1 != input$MultiMeasure2) {
    inputdata6 = finalInputData() %>% select(one_of(c(input$MultiMeasure1, input$MultiMeasure2, input$MultiDimension)))
    colnames(inputdata6) = c("XVar", "YVar", "CVar")
    return(inputdata6)
  } else if(input$MultiMeasure1 == input$MultiMeasure2) {
    inputdata6 = finalInputData() %>% select(one_of(c(input$MultiMeasure1, input$MultiMeasure2, input$MultiDimension)))
    colnames(inputdata6) = c("XVar", "CVar")
    inputdata6$YVar = inputdata6$XVar
    return(inputdata6)
  }
})

# **************************Outputs**************************
output$MultiScatterPlot = renderPlotly(
  if(is.null(dataInput6())) {
    return()
  } else {
    plot_ly(data = dataInput6(), x = ~ XVar, y = ~ YVar, color = ~ CVar, colors = "Paired", marker = list(size = 5)) %>%
      layout(title = paste0("Scatter Plot: ", input$MultiMeasure1, " vs ", input$Measure2, " across ", input$MultiDimension),
             xaxis = list(title = paste0(input$MultiMeasure1)), yaxis = list(title = paste0(input$MultiMeasure2)), showlegend = TRUE)
  })
