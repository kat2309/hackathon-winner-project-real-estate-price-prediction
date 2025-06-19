### server.R

library(shiny)
library(ggplot2)
library(tidyverse)

## Load the Ames dataset
tb <- AmesHousing::make_ames() %>%
  rename_with(function(x) {
    x %>%
      str_replace(" ", "_") %>%
      tolower()
  }) %>%
  mutate(age = year_sold + (mo_sold/12) - year_built ) %>%
  mutate(
    mo_sold = factor(mo_sold, levels = 1:12, ordered = TRUE),
    year_sold = factor(year_sold, levels = sort(unique(year_sold)), ordered = TRUE), # Ensures years are ordered
    bedroom_abvgr = factor(bedroom_abvgr, levels = sort(unique(bedroom_abvgr)), ordered = TRUE),
    year_built = factor(year_built, levels = sort(unique(year_built)), ordered = TRUE),
    year_remod_add = factor(year_remod_add, levels = sort(unique(year_remod_add)), ordered = TRUE),
    bsmtfin_sf_1 = factor(bsmtfin_sf_1, levels = sort(unique(bsmtfin_sf_1)), ordered = TRUE),
    bsmt_full_bath = factor(bsmt_full_bath, levels = sort(unique(bsmt_full_bath)), ordered = TRUE),
    bsmt_half_bath = factor(bsmt_half_bath, levels = sort(unique(bsmt_half_bath)), ordered = TRUE),
    full_bath = factor(full_bath, levels = sort(unique(full_bath)), ordered = TRUE),
    kitchen_abvgr = factor(kitchen_abvgr, levels = sort(unique(kitchen_abvgr)), ordered = TRUE),
    totrms_abvgrd = factor(totrms_abvgrd, levels = sort(unique(totrms_abvgrd)), ordered = TRUE),
    fireplaces = factor(fireplaces, levels = sort(unique(fireplaces)), ordered = TRUE),
    garage_cars = factor(garage_cars, levels = sort(unique(garage_cars)), ordered = TRUE)
  )

ames <- tb  # Assuming 'tb' is your Ames dataset already loaded

## Define server logic
server <- function(input, output) {
  ## Output the scatter plot
  output$scatter_plot <- renderPlot({
    req(input$x_var, input$y_var)  # Ensure inputs are available

    p <- ggplot(ames, aes_string(x = input$x_var, y = input$y_var)) +
      labs(title = paste("Scatter plot of", input$y_var, "vs", input$x_var),
           x = input$x_var,
           y = input$y_var) +
      theme_minimal()

    ## Check if both selected variables are categorical
    if ((is.factor(ames[[input$x_var]]) || is.character(ames[[input$x_var]])) &&
        (is.factor(ames[[input$y_var]]) || is.character(ames[[input$y_var]]))) {
                                        # Use geom_count() to plot counts of points for categorical axes
      p <- p + geom_count(alpha = 0.5) +
        labs(title = paste("Count of", input$y_var, "vs", input$x_var),
             x = input$x_var,
             y = input$y_var)
    } else {
      ## Otherwise, create a scatter plot
      p <- p + geom_point(alpha = 0.5)
    }

    ## Rotate x-axis labels if the x variable is categorical
    if (is.factor(ames[[input$x_var]]) || is.character(ames[[input$x_var]])) {
      p <- p + theme(axis.text.x = element_text(angle = 90, hjust = 1))
    }

    print(p)
  })

  ## Output the Sale Price vs. Other Variables plot
output$sale_price_plot <- renderPlot({
  req(input$x_var_sale_price)  # Ensure input is available

  # Check if the selected variable is categorical
  if (is.factor(ames[[input$x_var_sale_price]]) || is.character(ames[[input$x_var_sale_price]])) {
    # Convert to factor and reorder based on mean sale price
    ames[[input$x_var_sale_price]] <- factor(ames[[input$x_var_sale_price]],
      levels = names(sort(tapply(ames$sale_price, ames[[input$x_var_sale_price]], mean),
      decreasing = TRUE)))

    # Create a box plot for the categorical variable
    ggplot(ames, aes_string(x = input$x_var_sale_price, y = "sale_price")) +
      geom_boxplot(outlier.colour = "red", outlier.shape = 16, outlier.size = 2, alpha = 0.5) +
      labs(title = paste("Sale Price Distribution by", input$x_var_sale_price),
           x = input$x_var_sale_price,
           y = "Sale Price") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 90))
  } else {
    # Create a scatter plot for continuous variable
    ggplot(ames, aes_string(x = input$x_var_sale_price, y = "sale_price")) +
      geom_point(alpha = 0.5) +
      labs(title = paste("Sale Price vs", input$x_var_sale_price),
           x = input$x_var_sale_price,
           y = "Sale Price") +
      theme_minimal()
  }
})



  ## output$sale_price_plot <- renderPlot({
  ##   req(input$x_var_sale_price)  # Ensure input is available

  ##   ## Check if the selected variable is categorical
  ##   if (is.factor(ames[[input$x_var_sale_price]]) || is.character(ames[[input$x_var_sale_price]])) {
  ##     ## Create a box plot for categorical variable
  ##     ggplot(ames, aes_string(x = input$x_var_sale_price, y = "sale_price")) +
  ##       geom_boxplot(outlier.colour = "red", outlier.shape = 16, outlier.size = 2, alpha = 0.5) +
  ##       labs(title = paste("Sale Price Distribution by", input$x_var_sale_price),
  ##            x = input$x_var_sale_price,
  ##            y = "Sale Price") +
  ##       theme_minimal() +
  ##       theme(axis.text.x = element_text(angle = 90))
  ##   } else {
  ##     ## Create a scatter plot for continuous variable
  ##     ggplot(ames, aes_string(x = input$x_var_sale_price, y = "sale_price")) +
  ##       geom_point(alpha = 0.5) +
  ##       labs(title = paste("Sale Price vs", input$x_var_sale_price),
  ##            x = input$x_var_sale_price,
  ##            y = "Sale Price") +
  ##       theme_minimal()
  ##   }
  ## })
}
