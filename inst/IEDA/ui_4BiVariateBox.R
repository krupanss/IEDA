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
      "BoxPlot", height = 450, width = 850
    )), width = 10),
    box(uiOutput("BoxMeasure"), width = 2, uiOutput("BoxDimension"))
  ))
)
