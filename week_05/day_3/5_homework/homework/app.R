library(shiny)
library(tidyverse)
library(bslib)

got <- CodeClanData::got_ratings
view(got)

got_series <- got %>% 
  select(series) %>% 
  pull(series)

got_episode <- got %>% 
  select(episode) %>% 
  pull(episode)

ui <- fluidPage(
  titlePanel("Game Of Thrones Epsiode Rankings"),
  theme = bs_theme(version = 5, "lux"),
  fluidRow(
    column(
      width = 6,
      selectInput(
        inputId = "series",
        label = "Which series?",
        choices = got_series
      )
    ),
    column(
      width = 6,
      selectInput(
        inputId = "episode",
        label = "Which episode?",
        choices = got_episode
      )
    )
  ),
  fluidRow(
    column(
      width = 6,
      tableOutput("rating")
    )
  ) 
)

server <- function(input, output, session) {
  output$rating <- renderTable(got %>% 
  select(-x4) %>%                                
  filter(series == input$series, episode == input$episode)
  )
}

shinyApp(ui, server)