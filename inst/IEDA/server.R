library(dplyr)
library(xlsx)
library(DT)
library(tools)
library(stringr)
options(shiny.maxRequestSize=200*1024^2)
rm(list = ls())

# source("Data.R", local = TRUE)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  options(warn =-1)

  source("./server_1DataSource.R",local=T)

  source("./server_2Univariate.R",local=T)

  source("./server_3BiVariateScatter.R",local=T)

  source("./server_4BiVariateBox.R",local=T)

  source("./server_5BiVariateBar.R",local=T)

  source("./server_6BiVariateHistogram.R", local = T)

  source("./server_7MultiScatter.R", local = T)

  source("./server_8MultiBox.R", local = T)
})
