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
      "MultiBoxPlot", height = 450, width = 850
    )), width = 10),
    box(
      uiOutput("MultiBoxMeasure"),
      uiOutput("MultiBoxDimension1"),
      uiOutput("MultiBoxDimension2"),
      width = 2
    )
  ))
)
