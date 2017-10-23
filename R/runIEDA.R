#' Run IEDA Shiny Application to perform Interactive Exploratory Data Analysis in the package IEDA
#'
#' Exploratory Data Analysis is one of the key components of a data science project.
#' It is a crucial step to take before diving in to the machine learning or data modeling.
#' EDA can sometimes be time consuming due to reasons like huge number of variables in the data set, writing code for each plot or group of plots.
#' In order to eliminate these difficulties and reduce the time here is a simple tool which provides different interactive visualizations used in EDA just on click of a button.
#' @keywords IEDA, EDA, Exploratory Data Analysis
#' @export
#' @examples
#' runIEDA()
runIEDA <- function() {
  appDir <- system.file("IEDA", package = "IEDA")
  print(appDir)
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `IEDA`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
