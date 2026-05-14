
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#apple, amazon, and google stock for prediction confidence levels

file_names <- c("AAPL.csv", "AMZN.csv", "GOOGL.csv")
company_list <- lapply(file_names, read.csv)
names(company_list) <- c("Apple", "Amazon", "Google")

library(shiny)
library(ggplot2)
library(dplyr)

# logic required to create output
server <- function(input, output) {
  
  output$stockPlot <- renderPlot({
    req(input$selected_stocks) 
    
    # Combine and Filter
    plot_data <- bind_rows(company_list[input$selected_stocks], .id = "Company") %>%
      mutate(Date = as.Date(Date)) %>% 
      filter(Date >= input$date_range[1] & Date <= input$date_range[2])
    
    # Statistical Plot
    ggplot(plot_data, aes(x = Date, y = Close, color = Company, fill = Company)) +
      geom_line(linewidth = 1) +
      # prediction bands based on the slider
      geom_smooth(method = "lm", level = input$conf_level / 100) + 
      labs(title = "Stock Price with Prediction Bands",
           subtitle = paste("Confidence level:", input$conf_level, "%"),
           y = "Closing Price ($)", x = "Year") +
      theme_minimal() +
      theme(legend.position = "bottom")
  })
}