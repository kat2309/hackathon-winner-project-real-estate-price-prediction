# ui.R
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


# Define UI
ui <- fluidPage(
  titlePanel("Ames Housing Data Explorer"),

  sidebarLayout(
    sidebarPanel(
      p("Explore the various features of the Ames housing dataset.")
    ),

    mainPanel(
      tabsetPanel(
        tabPanel("Sale Price vs. Features",
                 selectInput("x_var_sale_price", "Select variable to compare with Sale Price:",
                             choices = names(ames)[names(ames) != "SalePrice"],
                             selected = "GrLivArea"),
                 plotOutput("sale_price_plot")),
        tabPanel("Explore data",
                 selectInput("x_var", "Select X variable:", choices = names(ames), selected = "GrLivArea"),
                 selectInput("y_var", "Select Y variable:", choices = names(ames), selected = "SalePrice"),
                 plotOutput("scatter_plot"))
      )
    )
  )
)
