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
      "GBarPlot", height = 500, width = 850
    )), width = 10),
    box(
      uiOutput("GBarDimension1"),
      width = 2,
      uiOutput("GBarDimension2")
    )
  ))
)
