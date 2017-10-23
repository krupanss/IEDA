# ************************************Bi Variate Box Plot************************************
library(shiny)
library(shinydashboard)
# **************************Select Inputs**************************
output$BoxMeasure = renderUI({
  selectInput("BoxMeasure", "Select Measure",
              c(selectdata()$FeatureValue[which(selectdata()$FeatureName == "Measures")]), rmeasures()[1])
})

output$BoxDimension = renderUI({
  selectInput("BoxDimension", "Select Dimension",
              c(selectdata()$FeatureValue[which(selectdata()$FeatureName == "Dimensions")]), rdimensions()[1])
})

# **************************Reactive Variable**************************
dataInput3 = reactive({
  if(is.null(input$BoxMeasure) & is.null(input$BoxDimension)) {
    return(NULL)
  } else {
    inputdata3 = finalInputData() %>% select(one_of(c(input$BoxDimension, input$BoxMeasure)))
    colnames(inputdata3) = c("XVar", "YVar")
    return(inputdata3)
  }
})

# **************************Outputs**************************
output$BoxPlot = renderPlotly(
  if(is.null(dataInput3())) {
    return()
  } else {
    dataInput3() %>% plot_ly(alpha = 1) %>%
      add_boxplot(x = ~ XVar, y = ~ YVar, color = ~ XVar) %>%
      layout(title = paste0("Distribution of ", input$BoxMeasure, " across ", input$BoxDimension),
             xaxis = list(title = input$BoxDimension), yaxis = list(title = input$BoxMeasure), legend = FALSE)
  })
