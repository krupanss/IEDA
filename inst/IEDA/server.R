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

  source("./server_1VeriKaynak.R",local=T)

  source("./server_2TekDegisken.R",local=T)

  source("./server_3IkiDegiskenSacinim.R",local=T)

  source("./server_4IkiDegiskenKutu.R",local=T)

  source("./server_5IkiDegiskenSutun.R",local=T)

  source("./server_6IkiDegiskenHistogram.R", local = T)

  source("./server_7CokDegiskenSacinim.R", local = T)

  source("./server_8CokDegiskenKutu.R", local = T)
})
