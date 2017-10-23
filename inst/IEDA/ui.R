library(shiny)
library(shinyjs)
library(shinydashboard)
library(plotly)
library(DT)
library(xlsx)
library(evaluate)
library(shinycssloaders)


ui = dashboardPage(title = "InteractiveEDA",
  skin = "blue",
  dashboardHeader(title = div(img(src="Title.png",height=50,width=150,align = "left"),
                              "IEDA"),
                  titleWidth = 250),

  # ***************************Dashboard Side Bar***************************
  dashboardSidebar(
    width = 250,
    sidebarMenu(id = "MenuTabs",
      menuItem("Home", tabName = "Home", icon = icon("home")),
      menuItem("Data Source", tabName = "DataSource", icon = icon("file")),
      menuItem("Univariate Analysis", tabName = "Univariate", icon = icon("bar-chart")),
      menuItem("Bi Variate Scatter Plot", tabName = "ScatterPlot", icon = icon("dot-circle-o")),
      menuItem("Bi Variate Box Plot", tabName = "BoxPlot", icon = icon("sliders")),
      menuItem("Bi Variate Group Bar Plot", tabName = "GBarPlot", icon = icon("bar-chart")),
      menuItem("Bi Variate Group Histogram", tabName = "GHistPlot", icon = icon("area-chart")),
      menuItem("Multi Variate Scatter Plot", tabName = "MultiScatterPlot", icon = icon("dot-circle-o")),
      menuItem("Multi Variate Box Plot", tabName = "MultiBoxPlot", icon = icon("sliders")),
      menuItem("EDA", tabName = "EDA", icon = icon("info-circle"))
    )
  ),

  # ***************************Dashboard Body***************************
  dashboardBody(
    tabItems(
      # ***************************Data Source***************************
      tabItem(tabName = "Home",
              source("./ui_0Home.R", local = T)[1]),

      # ***************************Data Source***************************
      tabItem(tabName = "DataSource",
              source("./ui_1DataSource.R", local = T)[1]),

      # ***************************Univariate Analysis***************************
      tabItem(tabName = "Univariate",
              source("./ui_2Univariate.R", local = T)[1]),

      # ***************************Bi Variate Scatter Plot***************************
      tabItem(tabName = "ScatterPlot",
              source("./ui_3BiVariateScatter.R", local = T)[1]),

      # ***************************Bi Variate Box Plot***************************
      tabItem(tabName = "BoxPlot",
              source("./ui_4BiVariateBox.R", local = T)[1]),

      # ***************************Bi Variate Group Bar Plot***************************
      tabItem(tabName = "GBarPlot",
              source("./ui_5BiVariateBar.R", local = T)[1]),

      # ***************************Bi Variate Group Histogram***************************
      tabItem(tabName = "GHistPlot",
              source("./ui_6BiVariateHistogram.R", local = T)[1]),

      # ***************************Multi Variate Scatter Plot***************************
      tabItem(tabName = "MultiScatterPlot",
              source("./ui_7MultiScatter.R", local = T)[1]),

      # ***************************Multi Variate Box Plot***************************
      tabItem(tabName = "MultiBoxPlot",
              source("./ui_8MultiBox.R", local = T)[1]),

      # ***************************Multi Variate Box Plot***************************
      tabItem(tabName = "EDA",
              source("./ui_9EDA.R", local = T)[1])
    )
  )
)

