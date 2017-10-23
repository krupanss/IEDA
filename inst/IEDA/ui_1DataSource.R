fluidPage(
  fluidRow(
    box(title = "Input your data file", width = 4, status = "primary", solidHeader = TRUE,
        collapsible = TRUE,
        radioButtons("fileType", "Select File Type", c(Excel = "excel", `R Data File` = "rda", CSV = "csv"),
                     inline = TRUE),
        uiOutput("FileInput"),
        uiOutput("SelectSheet"),
        conditionalPanel("input.fileType == 'excel'|| input.fileType == 'csv'",
                         checkboxInput("header", "Header", TRUE)),
        conditionalPanel("input.fileType == 'csv'",
                         radioButtons("sep", "Separator", c( Comma = ",", Semicolon = ";", Tab = "\t"), ",",
                                      inline = TRUE)),
        actionButton("btSubmit", "Submit Data"),
        htmlOutput("InputValidation")
        ),

    tabBox(title = "Data Processing", width = 8, id = "InputData",
           tabPanel("Data Structure",
                    conditionalPanel("output.ValFlag", htmlOutput("dataInfo")),
                    conditionalPanel("output.ValFlag", verbatimTextOutput("strData"))),
           tabPanel("Data Preview",
                    conditionalPanel("output.ValFlag", DT::dataTableOutput("DataTable"))),
           tabPanel("Select Column Features",
                    conditionalPanel("output.ValFlag", withSpinner(uiOutput("SelDimMeas")),
                                     actionButton("btExplore", "Explore Data")))
           )
    )
  # fluidRow(
  #   box(title = "Data Preview", width = 8, status = "info", solidHeader = TRUE,
  #       collapsible = TRUE,"Sample"
  #       ),
  #
  #   box(title = "Select Column Features", width = 4, status = "primary", solidHeader = TRUE,
  #       collapsible = TRUE, "Sample2"
  #       )
  #   )
)
