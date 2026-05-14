
#    https://shiny.posit.co/
#Apple, Amazon, Google

file_names <- c("AAPL.csv", "AMZN.csv", "GOOGL.csv")
company_list <- lapply(file_names, read.csv)
names(company_list) <- c("Apple", "Amazon", "Google")

library(shiny)

ui <- fluidPage(

    # Application title
    titlePanel("Stock Price Prediction Bands"),

    # Sidebar 
    sidebarLayout(
        sidebarPanel(
          #check boxes to select companies shown on graph
            checkboxGroupInput("selected_stocks",
                        "Selected Companies:",
                        choices= names(company_list),
                        selected= names(company_list)[1]), #[1] selects firs company
            #Slider for confidence level
            sliderInput("conf_level", "Prediction Band Width (%):",
                        min = 80, max = 99, value = 95),
            dateRangeInput("date_range",
                           "Select Date Range From 01/04/2010 - 12/29/2022:",
                           start = "2010-01-04", # START DATE CHECK
                           end = "2022-12-29", #END DATE CHECK DATA
                           min = "2010-01-04",
                           max = "2022-12-29")
        ),

        # Show output
        mainPanel(
            plotOutput("stockPlot")
        )
    )
)
