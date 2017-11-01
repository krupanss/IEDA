# ************************************Data Source************************************
library(shiny)
library(shinydashboard)

# **************************Select Inputs**************************
output$FileInput = renderUI({
  fileTypeString = switch(input$fileType, excel = ".xlsx", rda = ".rda", csv = ".csv")
  fileInput("datafile", "Choose file", accept = c(fileTypeString))
})

output$SelectSheet = renderUI({
  if (!is.null(fileSheets()))
    radioButtons("sheetName", "Select Sheet Name", c(fileSheets()), inline = TRUE)
})

output$InputValidation = renderText({
  inFile = input$fileType
  if (is.null(inFile)) {
    return()
  } else {
    HTML(validateInput())
  }
})

# **************************Reactive Variable**************************

validateInput = eventReactive(input$btSubmit, {
  valIn = ""
  if (input$fileType == "excel") {
    validate(need(input$datafile, "Select a File"))
    validate(need(
      file_ext(input$datafile$name) %in% c("xlsx") ,
      'Wrong file Selected. Select only Excel file'
    ))
  } else if (input$fileType == "csv") {
    validate(need(input$datafile, "Select a File"))
    validate(need(
      file_ext(input$datafile$name) %in% c("csv") ,
      'Wrong file Selected. Select only csv file'
    ))
  } else if (input$fileType == "rda") {
    validate(need(input$datafile, "Select a File"))
    validate(need(
      file_ext(input$datafile$name) %in% c("rda") ,
      'Wrong file Selected. Select only .rda file'
    ))
  }
  return(valIn)
})

output$ValFlag <- reactive({
  return(!is.null(validateInput()))
})
outputOptions(output, 'ValFlag', suspendWhenHidden=FALSE)

fileSheets = reactive({
  inFile = input$datafile
  if (is.null(inFile)) {
    return()
  } else if (input$fileType == "excel") {
    validate(need(input$datafile, message = FALSE))
    validate(need(file_ext(inFile$name) %in% c("xlsx") , message = FALSE))
    inputbook = loadWorkbook(inFile$datapath)
    sheetnames = names(getSheets(inputbook))
    return(sheetnames)
  }
})

uploadData = reactiveValues()


observeEvent(input$btSubmit, {
  if(validateInput() == ""){
    if (input$fileType == "excel" & !is.null(input$sheetName)) {
      validate(need(input$datafile, message = FALSE))
      validate(need(file_ext(input$datafile$name) %in% c("xlsx") ,message = FALSE))
      uploadData$fiData = read.xlsx2(input$datafile$datapath, sheetName = input$sheetName, header = input$header,
                                     stringsAsFactors = FALSE)
    } else if (input$fileType == "csv") {
      validate(need(input$datafile, "Select a File"))
      validate(need(file_ext(input$datafile$name) %in% c("csv") ,'Wrong file Selected. Select only csv file'))
      uploadData$fiData = read.csv(input$datafile$datapath, header = input$header, sep = input$sep, stringsAsFactors = FALSE)

    } else if (input$fileType == "rda") {
      validate(need(input$datafile, "Select a File"))
      validate(need(file_ext(input$datafile$name) %in% c("rda") ,'Wrong file Selected. Select only .rda file'))
      dsName = load(input$datafile$datapath)
      uploadData$fiData = get(dsName)
    }
  }
  # return(uploadData$fiData)
})

output$DataTable = DT::renderDataTable({
  if(input$btSubmit > 1 || input$btExplore == 0){
    uploadData$fiData
  }
  else if(input$btExplore > 0){
    finalInputData()
  }
},
options = list(lengthMenu = c(5, 30, 50), pageLength = 5, scrollX = TRUE, scrollY = '200px', autoWidth = TRUE))


fn_GetDataStructure = function(idata){
  dstr = data.frame(Variable = idata %>% colnames,
                    Class = idata %>% sapply(class), stringsAsFactors = FALSE)
  dstr = dstr %>% mutate(DMClass = if_else(Class %in% c("double","integer","numeric"), "Measure","Dimension"))
  row.names(dstr) = NULL
  return(dstr)
}

rbVarReactive = reactiveValues(IsRbLoaded = FALSE)

output$SelDimMeas = renderUI({
  if (is.null(uploadData$fiData)) {
    return(NULL)
  } else {
    dsstr = fn_GetDataStructure(uploadData$fiData)
    rbVarReactive$IsRbLoaded = TRUE
    lapply(dsstr$Variable, function(x) {
      rbSel = dsstr[dsstr$Variable == x, ]$DMClass
      list(radioButtons(
        paste0("rb", x),
        x,
        choices = c(
          Dimension = "Dimension",
          Measure = "Measure",
          Exclude = "Exclude"
        ),
        selected = rbSel,
        inline = TRUE
      ))
    })
  }
})

finalInputData = eventReactive(input$btExplore, {
  if (rbVarReactive$IsRbLoaded == TRUE) {
    dsstr = fn_GetDataStructure(uploadData$fiData)
    udstr = sapply(dsstr$Variable, function(x) gsub(pattern = "\\[1\\]|\"|\\n",
                                                    x = evaluate::evaluate(paste0("input$rb",x))[[2]] ,
                                                    replacement = ""))
    udstr = data.frame(Variable = names(udstr), UserClass = udstr, stringsAsFactors = FALSE)
    row.names(udstr) = NULL
    udstr$UserClass = str_trim(udstr$UserClass, side = "both")
    dnames = udstr %>% filter(UserClass == "Dimension") %>% select(Variable) %>% collect %>% .[["Variable"]]
    mnames = udstr %>% filter(UserClass == "Measure") %>% select(Variable) %>% collect %>% .[["Variable"]]
    usrStructData = uploadData$fiData
    if(!is.null(dnames))
    {
      if(length(dnames)==1)
      {
        usrStructData[,dnames] = sapply(usrStructData[,dnames], as.factor)
      } else {
        usrStructData[,dnames] = lapply(usrStructData[,dnames], as.factor)
      }

    }
    if(!is.null(mnames))
    {
      if(length(mnames)==1)
      {
        usrStructData[,mnames] = sapply(usrStructData[,mnames], as.numeric)
      } else {
        usrStructData[,mnames] = lapply(usrStructData[,mnames], as.numeric)
      }
    }
    usrStructData = usrStructData %>% select(one_of(c(dnames, mnames)))
    return(usrStructData)
  } else {
    return(NULL)
  }
})

ValTabs = reactiveValues(Tabs = TRUE, Plots = FALSE)

observeEvent(input$fileType,{
  if(is.null(input$datafile)){
    ValTabs$Tabs = TRUE
    ValTabs$Plots = FALSE
  }
})

observeEvent(input$btExplore,{
  if(!is.null(input$btExplore)){
    ValTabs$Tabs = FALSE
    ValTabs$Plots = TRUE

    newtab <- switch(input$MenuTabs, "DataSource" = "Univariate","Univariate" = "DataSource")
    updateTabItems(session, "MenuTabs", newtab)
  }
})

output$ValTabs <- reactive({
  return(ValTabs$Tabs)
})
outputOptions(output, 'ValTabs', suspendWhenHidden=FALSE)

output$ValPlots <- reactive({
  return(ValTabs$Plots)
})
outputOptions(output, 'ValPlots', suspendWhenHidden=FALSE)


rmeasures = reactive({
  return(colnames(finalInputData() %>% select_if(is.numeric)))
})

rdimensions = reactive({
  return(colnames(finalInputData() %>% select_if(is.factor)))
})

selectdata = reactive({
  measures = colnames(finalInputData() %>% select_if(is.numeric))
  dimensions = colnames(finalInputData() %>% select_if(is.factor))

  seldata = data.frame(FeatureName = character(), FeatureValue = character(), stringsAsFactors = FALSE)
  if(length(measures)>=1)
    seldata = rbind(seldata,
                    data.frame(FeatureName = paste("Measures"), FeatureValue = measures, stringsAsFactors = FALSE))
  if(length(dimensions)>=1)
    seldata = rbind(seldata,
                    data.frame(FeatureName = paste("Dimensions"), FeatureValue = dimensions, stringsAsFactors = FALSE))
  return(seldata)
})

output$dataInfo <- renderUI({
  validate(need(input$btSubmit, message=FALSE))
  if (is.null(uploadData$fiData)) {
    return(NULL)
  } else {
    if (inherits(uploadData$fiData, "try-error", which = F)) {
      h3("Data input failed due to an unkown reason")
    } else {
      if (any(duplicated(colnames(uploadData$fiData)))) {
        h6("Duplicated colnames are not allowed")
      } else {
        HTML(
          paste0(
            "The uploaded data table has <b>",
            ncol(uploadData$fiData),
            " columns</b> and <b>",
            nrow(uploadData$fiData),
            " rows</b>",
            "<br/> Structure of data is as below."
          )
          )
      }
      }
    }
  })

output$strData <- renderPrint({
  validate(need(input$btSubmit, message=FALSE))
  if (is.null(uploadData$fiData)) {
    return(NULL)
  } else if(input$btSubmit > 1 || input$btExplore == 0){
    str(uploadData$fiData)
  }
  else if(input$btExplore > 0){
    str(finalInputData())
  }
})

observeEvent(input$btSubmit, {
  if (input$btSubmit >= 2) {
    ValTabs$Tabs = TRUE
    ValTabs$Plots = FALSE
  }
})
