conditionalPanel(condition = "output.ValTabs",
                 fixedRow(
                   HTML("<div style='height: 10px;'>"),
                   HTML("</div>"),
                   column(
                     8,
                     align = "top",
                     h1("Visualizations Help"),
                     h3("Please follow below steps in order to view the Visualizations."),
                     h4(
                       "1. Upload the data file in the Data Source Tab and Submit using the \"Submit\" button."
                     ),
                     h4("2. Select Columns for Measures, Dimensions and Exclude."),
                     h4("3. Explore Button will appear once columns are selected."),
                     h4("4. Click on \"Explore\" button to view the Visualizations.")
                   )
                 ))

