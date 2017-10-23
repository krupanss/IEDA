# ************************************Multi Variate Box Plot************************************
library(shiny)
library(shinydashboard)
# **************************Select Inputs**************************
output$MultiBoxMeasure = renderUI({
  selectInput("MultiBoxMeasure", "Select Measure",
              c(selectdata()$FeatureValue[which(selectdata()$FeatureName == "Measures")]), rmeasures()[1])
})

output$MultiBoxDimension1 = renderUI({
  selectInput("MultiBoxDimension1", "Select Dimension1",
              c(selectdata()$FeatureValue[which(selectdata()$FeatureName == "Dimensions")]), rdimensions()[1])
})

output$MultiBoxDimension2 = renderUI({
  selectInput("MultiBoxDimension2", "Select Dimension2",
              c(selectdata()$FeatureValue[which(selectdata()$FeatureName == "Dimensions")]), rdimensions()[2])
})

# **************************Reactive Variable**************************
dataInput7 = reactive({
  if (is.null(input$MultiBoxMeasure) & is.null(input$MultiBoxDimension1) & is.null(input$MultiBoxDimension2)) {
    return(NULL)
  } else if (input$MultiBoxDimension1 != input$MultiBoxDimension2) {
    inputdata7 = finalInputData() %>% select(one_of(c(input$MultiBoxDimension1, input$MultiBoxMeasure, input$MultiBoxDimension2)))
    colnames(inputdata7) = c("XVar", "YVar", "CVar")
    return(inputdata7)
  }
  else if (input$MultiBoxDimension1 == input$MultiBoxDimension2) {
    inputdata7 = finalInputData() %>% select(one_of(c(input$MultiBoxDimension1, input$MultiBoxMeasure, input$MultiBoxDimension2)))
    colnames(inputdata7) = c("XVar", "YVar")
    inputdata7$CVar = inputdata7$XVar
    return(inputdata7)
  }
})

# **************************Outputs**************************
output$MultiBoxPlot = renderPlotly(
  if(is.null(dataInput7())) {
    return()
  } else {
    dataInput7() %>% plot_ly(alpha = 1) %>%
      add_boxplot(x = ~ XVar, y = ~ YVar, color = ~ CVar) %>%
      layout(title = paste0("Distribution of ", input$MultiBoxMeasure, " across ", input$MultiBoxDimension1,
                            " and ", input$MultiBoxDimension2), xaxis = list(title = input$MultiBoxDimension1),
             yaxis = list(title = input$MultiBoxMeasure), legend = FALSE, boxmode = "group")
  })
