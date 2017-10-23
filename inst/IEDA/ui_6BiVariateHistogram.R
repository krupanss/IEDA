fluidPage(
  # supress error messages in app
  tags$style(
    type = 'text/css',
    ".shiny-output-error{ visibility: hidden;}",
    ".shiny-output-error:before { visibility:hidden; }"
  ),
  source("./ui_CustomError.R", local = T)[1],
  fluidRow(conditionalPanel(
    "output.ValPlots",
    box(withSpinner(plotlyOutput(
      "GHistPlot", height = 500, width = 850
    )), width = 10),
    box(uiOutput("GHistMeasure"), width = 2, uiOutput("GHistDimension"))
  ))
)
