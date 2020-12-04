#' @import shiny

app_server <- function(input, output, session) {
  output$statesPlaceholder <- renderText("safety text for states tab")
  output$editPlaceholder <- renderText("safety text for edit tab")
  output$graphPlaceholder <- renderText("safety text for graph tab")
  output$datesPlaceholder <- renderText("safety text for dates tab")

  cdata <- eventReactive(input$load,{
    temp <- COVID19::covid19(
      country = "us", level = 2, start = sort(input$dateRange)[1],
      end = sort(input$dateRange)[2], verbose = FALSE
    )
    temp <- temp[ , c(2:10,29)] #discards id and mostly NA columns
    temp
  })

  output$summary <- renderPrint({
    width = 7
    summary(
      cdata()[cdata()$administrative_area_level_2 %in% input$state, ]
    )
  })

  output$state_ui <- renderUI({
    checkboxGroupInput(inputId = "state", label = "Choose States:",
      choices = sort(unique(cdata()$administrative_area_level_2))
    )
  })
}
