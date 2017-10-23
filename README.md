# IEDA (Interactive-Exploratory-Data-Analysis)
IEDA is an R Package for a R Shiny application for exploratory data analysis thru Interactive Visualizations

# About
Exploratory Data Analysis is one of the key components of a data science project. It is a crucial step to take before diving in to the machine learning or data modeling. EDA can sometimes be time consuming due to reasons like huge number of variables in the data set, writing code for each plot or group of plots. In order to eliminate these difficulties and reduce the time here is a simple tool which provides different interactive visualizations used in EDA just on click of a button.

## Install package and run the Shiny application using the below commands.
`devtools::install_github("krupanss/IEDA")`

`library(IEDA)`

`runIEDA()`


# Manual
IEDA is a simple application and is easy to use. Follow the below series of simple steps to utilise the tool.

1. Upload the dataset file in the selected format in the "DataSource" tab and click on submit.
2. On submit, you can do pre-processing of Data in the "Data Processing" Pane on the right side.
3. In the "Data Strucure" tab, you can view the strucure of data.
4. In the "Data Preview" tab, you can view the actual data.
5. In the "Select Column Features" tab, you can choose the feature of the columns.
6. Select Dimensions for Discrete or non continuous variables
7. Select Measures for Continuous variables
8. Select Exclude to exclude the variable in the EDA
9. Once the pre-processing is completed, click on Explore button on the bottom in the "Select Column Features" tab.
10. On clicking the "Explore Button", Seven different interactive visualizations with options are presented and can be accessed in the sidebar panel.
