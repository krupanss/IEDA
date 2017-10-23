# ************************************Bi Variate Scatter Plot************************************
library(shiny)
library(shinydashboard)
# **************************Select Inputs**************************
output$Measure1 = renderUI({
  selectInput("Measure1", "Select Measure1",
              c(selectdata()$FeatureValue[which(selectdata()$FeatureName == "Measures")]), rmeasures()[1])
})

output$Measure2 = renderUI({
  selectInput("Measure2", "Select Measure2",
              c(selectdata()$FeatureValue[which(selectdata()$FeatureName == "Measures")]), rmeasures()[2])
})

# **************************Reactive Variable**************************
dataInput2 = reactive({
  if (is.null(input$Measure1) & is.null(input$Measure2)) {
    return(NULL)
  } else if (input$Measure1 != input$Measure2) {
    inputdata2 = finalInputData() %>% select(one_of(c(input$Measure1,input$Measure2)))
    colnames(inputdata2) = c("XVar", "YVar")
    return(inputdata2)
  } else if(input$Measure1 == input$Measure2) {
    inputdata2 = finalInputData() %>% select(one_of(c(input$Measure1,input$Measure2)))
    colnames(inputdata2) = c("XVar")
    inputdata2$YVar = inputdata2$XVar
    return(inputdata2)
  }
})

# **************************Outputs**************************
output$ScatterPlot = renderPlotly(
  if(is.null(dataInput2())) {
    return()
  } else {
    plotly::subplot(plot_ly(x = rmeasures(), y = rmeasures(), z = cor(finalInputData()[,rmeasures()]), type = "heatmap") %>%
                      layout(xaxis = list(categoryorder = "trace"),yaxis = list(categoryorder = "trace")),
                    plot_ly(data = dataInput2(), x = ~ XVar, y = ~ YVar, marker = list(size = 5)) %>%
                      layout(title = paste0("Scatter Plot: ", input$Measure1," vs ", input$Measure2),
                             xaxis = list(title = paste0(input$Measure1)),
                             yaxis = list(title = paste0(input$Measure2))),
                    nrows = 1, margin = 0.05, titleY = TRUE, titleX = TRUE)
  })

