#' @import shiny

app_server <- function(input, output, session) {
  #section for upper left text in each tab
  output$datesPlaceholder <- renderText("self note: maybe write \"about\" the
    app here")
  output$statesPlaceholder <- renderText(paste0("If this page is blank, the",
    " data is still loading.\nPlease allow up to 60 seconds for it to finish.",
    "\n\nOn the checklist below, you can select which states you are\nintested",
    " in comparing over the pre-selected date range."))
  #in "edit" text, you should give them the link
  #https://covid19datahub.io/articles/doc/data.html#terms-of-use-1
  output$editPlaceholder <- renderText(paste0("Below you can see the names of",
    " current variables.\nBelow that is an interface to allow you to make ",
    "your own\ncombinations of given variables by supplied operations.\n\n",
    "Remember to give them descriptive titles and press the \"save button\""))
  output$graphPlaceholder <- renderText("safety text for graph tab")

  #begin logic for "Dates" tab

  cdata <- eventReactive(input$loadButton, {
  #observeEvent(input$loadButton, {
    temp <- COVID19::covid19(
      country = "us", level = 2, start = sort(input$dateRange)[1],
      end = sort(input$dateRange)[2], verbose = FALSE
    )
    temp <- temp[ , c(2:10,29)] #discards id and mostly NA columns
    names(temp)[10] <- "state" #renamed from administrative_area_level_2
    temp #return temp to save AS cdata
    #cdata <- temp
  })

  observeEvent(input$loadButton, {
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

  output$stateUI <- renderUI({
    checkboxGroupInput(inputId = "state", label = "Choose States:",
      choices = sort(unique(cdata()$state))
    )
  })

  #begin logic for "Edit" tab

  output$varNamesExplain <- renderText("These are the current variables")

  output$varNames <- renderPrint(names(cdata()))

  output$equalsSign <- renderText("=")

  output$lhsVar <- renderUI({
    selectInput(inputId = "lhsVar",
      label = "Existing Variable",
      choices = names(cdata()))
  })

  output$rhsVar <- renderUI({
    selectInput(inputId = "rhsVar",
      label = "Existing Variable",
      choices = names(cdata()))
  })

  observeEvent(input$newVarButton, {
    shiny::req(input$newVarName)
    cdata <- cdata() %>% mutate(
      "{input$newVarName}" := !!sym(input$lhsVar)/!!sym(input$rhsVar)
        )
  })

  #begin logic for "Graph" tab

  #to do: let them TITLE the graph and potentially pick geometry/geometries

  output$xUI <- renderUI({
    selectInput(inputId = "x",
      label = "x-axis variable:",
      choices = names(cdata())
    )
  })

  output$yUI <- renderUI({
    selectInput(inputId = "y",
      label = "y-axis variable:",
      choices = names(cdata())
    )
  })

  output$graphObj <- renderPlot(ggplot(data =
      cdata()[cdata()$state %in% input$state, ]) +
      aes_string(x = input$x, y = input$y) +
      aes(color = state) +
      geom_line() +
      theme_dark()
      )

}
