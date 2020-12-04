#' @import shiny

app_server <- function(input, output, session) {
  output$selectPlaceholder <- renderText("safety text for select tab")
  output$editPlaceholder <- renderText("safety text for edit tab")
  output$graphPlaceholder <- renderText("safety text for graph tab")

  cdata <- eventReactive(input$load,{
    temp <- COVID19::covid19(country = "us", level = 2, start = "2020-12-1", verbose = FALSE)
    temp <- temp[ , c(2:10,29)]
    temp
  })

  output$table <- renderPrint(summary(
    cdata()[cdata()$administrative_area_level_2 %in% input$state, ]
    )
  )

  output$state_ui <- renderUI({
    checkboxGroupInput(inputId = "state", label = "Choose States:",
      choices = sort(unique(cdata()$administrative_area_level_2))
    )
  })
}
