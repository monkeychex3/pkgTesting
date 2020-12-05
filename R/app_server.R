#' @import shiny

app_server <- function(input, output, session) {
  #section for upper left text in each tab
  output$datesPlaceholder <- renderText("self note: maybe write \"about\" the
    app here")
  output$statesPlaceholder <- renderText(paste0("If this page is blank, the",
    " data is still loading.\nPlease allow up to 60 seconds for it to finish.",
    "\n\nOn the checklist below, you can select which states you are\nintested",
    " in comparing over the pre-selected date range."))
  output$editPlaceholder <- renderText("safety text for the edit tab")
  output$graphPlaceholder <- renderText("safety text for graph tab")

  #begin logic for "Dates" tab

  cdata <- eventReactive(input$loadButton,{
    temp <- COVID19::covid19(
      country = "us", level = 2, start = sort(input$dateRange)[1],
      end = sort(input$dateRange)[2], verbose = FALSE
    )
    temp <- temp[ , c(2:10,29)] #discards id and mostly NA columns
    names(temp)[10] <- "state"
    temp
  })

  observeEvent(input$loadButton,{
    output$confirmation <- renderText(
      "Data load successfully initiated!\nPlease proceed to the next tab."
    )
  })

  #begin logic for "States" tab

  output$summary <- renderPrint({
    width = 7
    summary(
      cdata()[cdata()$state %in% input$state, ]
    )
  })

  output$state_ui <- renderUI({
    checkboxGroupInput(inputId = "state", label = "Choose States:",
      choices = sort(unique(cdata()$state))
    )
  })

  #begin logic for "Edit" tab


  #begin logic for "Graph" tab

}
