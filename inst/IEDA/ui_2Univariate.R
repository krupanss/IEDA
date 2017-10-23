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
      "Univariate", height = 450, width = 850
    )), width = 10),
    box(
      uiOutput("FeatureSelect"),
      width = 2,
      uiOutput("FeatureValueSelect")
    )
  ))
)
