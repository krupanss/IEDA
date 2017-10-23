# ************************************Bi Variate Group Bar Plot************************************
library(shiny)
library(shinydashboard)
# **************************Select Inputs**************************
output$GBarDimension1 = renderUI({
  selectInput("GBarDimension1", "Select Dimension1",
              c(selectdata()$FeatureValue[which(selectdata()$FeatureName == "Dimensions")]), rdimensions()[1])
})

output$GBarDimension2 = renderUI({
  selectInput("GBarDimension2", "Select Dimension2",
              c(selectdata()$FeatureValue[which(selectdata()$FeatureName == "Dimensions")]), rdimensions()[2])
})

# **************************Reactive Variable**************************
dataInput4 = reactive({
  if(is.null(input$GBarDimension1) & is.null(input$GBarDimension2)) {
    return(NULL)
  } else if (input$GBarDimension1 != input$GBarDimension2) {
    inputdata4 = finalInputData() %>% select(one_of(c(input$GBarDimension1,input$GBarDimension2)))
    colnames(inputdata4) = c("XVar", "YVar")
    return(inputdata4)
  } else if (input$GBarDimension1 == input$GBarDimension2) {
    inputdata4 = finalInputData() %>% select(one_of(c(input$GBarDimension1,input$GBarDimension2)))
    colnames(inputdata4) = c("XVar")
    inputdata4$YVar = inputdata4$XVar
    return(inputdata4)
  }
})

# **************************Outputs**************************
output$GBarPlot = renderPlotly(
  if(is.null(dataInput4())) {
    return()
  } else {
    dataInput4() %>% count(XVar, YVar) %>%
      plot_ly(x = ~ XVar, y = ~ n, color = ~ YVar, type = "bar") %>%
      layout(title = paste0("Distribution of ", input$GBarDimension1, " across ", input$GBarDimension2),
             xaxis = list(title = input$GBarDimension1), yaxis = list(title = "No of records"), legend = FALSE)
  })
