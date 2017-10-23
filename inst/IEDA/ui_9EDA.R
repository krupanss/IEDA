fluidPage(
fixedRow(
  column(12,
         align = "left",
         h1("Exploratory Data Analysis: "),
         HTML("<div style='height: 5px;'>"),
         HTML("</div>"),
         h3("About"),
         h4("Exploratory Data Analysis (EDA) is the practice of using visual and quantitative
            methods to understand and summarize a dataset without making any assumptions about
            its contents. It is usually used to investigate a specific question or to prepare
            for more advanced modeling. EDA typically relies heavily on visualizing the data to
            assess patterns and identify data characteristics that the analyst would not
            otherwise know to look for. It also takes advantage of a number of quantitative
            methods to describe the data."),
         HTML("<div style='height: 5px;'>"),
         HTML("</div>"),
         h3("Use Cases"),
         h4("EDA is an approach for data analysis that employs a variety of techniques
            (mostly graphical) to"),
         tags$ul(
           tags$li(h4("Build an intuition for the data")),
           tags$li(h4("Maximize insight into a data set")),
           tags$li(h4("Uncover underlying structure")),
           tags$li(h4("Extract important variables")),
           tags$li(h4("Detect outliers and anomalies")),
           tags$li(h4("Validate assumptions and identify patterns")),
           tags$li(h4("Develop parsimonious models")),
           tags$li(h4("Determine optimal factor settings"))
           ),
         h4("Another benefit of EDA is to refine your selection of feature variables that will be used
            later for machine learning. Once you gain deep familiarity with your data set, you may need
            to revisit the feature engineering step; you may find the features you selected do not
            serve their intended purpose. Moreover you may discover other features that add to the
            overall picture the data presents."),
         HTML("<div style='height: 5px;'>"),
         HTML("</div>"),
         h3("Undervalued"),
         h4("EDA is an often undervalued process which is a key component to any data science
            project. It is a crucial step to take before diving into machine learning or
            statistical modeling because it provides the context needed to develop an
            appropriate model for the problem at hand and to correctly interpret its results.
            This is a mistake with many implications, including generating inaccurate models,
            generating accurate models but on the wrong data, not creating the right types of
            variables in data preparation, and using resources inefficiently because of
            realizing only after generating models that perhaps the data is skewed, or has
            outliers, or has too many missing values, or finding that some values are
            inconsistent."),
         HTML("<div style='height: 5px;'>"),
         HTML("</div>"),
         h3("Techniques"),
         h4("Most EDA techniques are graphical in nature with a few quantitative techniques.
            The reason for the heavy reliance on graphics is that by its very nature the main
            role of EDA is to open-mindedly explore, and graphics gives the analysts
            unparalleled power to do so, enticing the data to reveal its structural secrets,
            and being always ready to gain some new, often unsuspected, insight into the data.
            In combination with the natural pattern-recognition capabilities that we all
            possess, graphics provides, of course, unparalleled power to carry this out."),
         HTML("<div style='height: 5px;'>"),
         HTML("</div>"),
         h3("References"),
         h4(a("https://svds.com/value-exploratory-data-analysis/",
              href="https://svds.com/value-exploratory-data-analysis/")),
         h4(a("https://insidebigdata.com/2014/11/09/ask-data-scientist-importance-exploratory-data-analysis/",
              href="https://insidebigdata.com/2014/11/09/ask-data-scientist-importance-exploratory-data-analysis/")),
         h4(a("http://www.itl.nist.gov/div898/handbook/eda/section1/eda11.htm",
              href="http://www.itl.nist.gov/div898/handbook/eda/section1/eda11.htm")),
         HTML("<div style='height: 5px;'>"),
         HTML("</div>"),
         align = "center",
         HTML(paste(icon("copyright"),"Krupan - IEDA Version 1.0")),
         HTML("<div style='height: 25px;'>"),
         HTML("</div>")
         )
         ))
