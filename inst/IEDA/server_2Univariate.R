# ************************************Univariate Analysis************************************
library(shiny)
library(shinydashboard)
# **************************Select Inputs**************************
output$FeatureSelect = renderUI({
  selectInput("Features", "Select Feature", c(unique(selectdata()$FeatureName)), "Measure")
})

output$FeatureValueSelect = renderUI(
  if (is.null(input$Features)){
    return(NULL)
  }
  else if (input$Features == "Measures") {
    selectInput("Measures", "Select Measure",
                c(selectdata()$FeatureValue[which(selectdata()$FeatureName == input$Features)]), rmeasures()[1])
  } else if (input$Features == "Dimensions") {
    selectInput("Dimensions", "Select Dimension",
                c(selectdata()$FeatureValue[which(selectdata()$FeatureName == input$Features)]), rdimensions()[1])
  })

# **************************Reactive Variable**************************
dataInput = reactive({
  if (is.null(input$Measures) & is.null(input$Dimensions)) {
    return(NULL)
  } else if (input$Features == "Measures") {
    inputdata = finalInputData() %>% select(one_of(input$Measures))
    colnames(inputdata) = c("XVar")
    return(inputdata)
  } else if (input$Features == "Dimensions") {
    inputdata = finalInputData() %>% select(one_of(input$Dimensions))
    colnames(inputdata) = c("XVar")
    return(inputdata)
  }
})

# **************************Outputs**************************
output$Univariate = renderPlotly(
  if (is.null(dataInput())) {
    return()
  } else if (input$Features == "Measures") {
    plotly::subplot(
      # Histogram
      dataInput() %>% plot_ly(alpha = 1) %>% add_histogram(x = ~ XVar) %>%
        layout(bargap = 0.1, xaxis = list(title = paste0(input$Measures)), yaxis = list(title = "No of records")),
      # Box Plot
      dataInput() %>% plot_ly(alpha = 1) %>% add_boxplot(y = ~ XVar, x = "") %>%
        layout(yaxis = list(title = paste0(input$Measures))),
      nrows = 1, titleY = TRUE, margin = 0.05) %>%
      layout(title = paste0("Distribution of ", input$Measures),showlegend = FALSE)
  } else if (input$Features == "Dimensions") {
    # Bar Plots
    dataInput() %>% count(XVar) %>%
      plot_ly(x = ~ XVar, y = ~ n, type = "bar") %>%
      layout(bargap = 0.1, title = paste0("Distribution of ", input$Dimensions),
             xaxis = list(title = paste0(input$Dimensions)), yaxis = list(title = "No of records"))
  })
