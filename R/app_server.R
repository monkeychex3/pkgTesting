#' @import shiny

app_server <- function(input, output, session) {
  #section for upper left text in each tab
  #the paste0 is to retain formatting while keeping code lines under 80chars
  output$datesPlaceholder <- renderText(paste0("Welcome to the COVID State",
    " Comparisons app.\nHere you can select a date range to inspect.\nThe next",
    " tabs will remember this choice,\nbut you can always come back to ",
    "update it.\n\nThe first click of this button each day can take a bit",
    " to load"))
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
  output$graphPlaceholder <- renderText(paste0("If this graph is blank,",
    " remember to select States to view on the \"States\" tab"))

  covid <- reactiveValues(rdata = NULL)

  #begin logic for "Dates" tab
  observeEvent(input$loadButton, {
    temp <- COVID19::covid19(
      country = "us", level = 2, start = sort(input$dateRange)[1],
      end = sort(input$dateRange)[2], verbose = FALSE
    )
    temp <- temp[ , c(2:10,29)] #discards id and mostly NA columns
    names(temp)[10] <- "state" #renamed from administrative_area_level_2
    #temp #return temp to save AS cdata
    covid$rdata <- temp
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
      covid$rdata[covid$rdata$state %in% input$state, ]
    )
  })

  output$stateUI <- renderUI({
    checkboxGroupInput(inputId = "state", label = "Choose States:",
      choices = sort(unique(covid$rdata$state))
    )
  })

  #begin logic for "Edit" tab

  output$varNamesExplain <- renderText("These are the current variables")

  output$varNames <- renderPrint(names(covid$rdata))

  output$equalsSign <- renderText("=")

  output$lhsVar <- renderUI({
    selectInput(
      inputId = "lhsVar",
      label = "Existing Variable",
      choices = #long winded way to say "options OTHER THAN state or date"
        sort(names(covid$rdata)[!(names(covid$rdata) %in% c("state","date"))]))
  })

  output$rhsVar <- renderUI({
    selectInput(inputId = "rhsVar",
      label = "Existing Variable",
      choices = #long winded way to say "options OTHER THAN state or date"
        sort(names(covid$rdata)[!(names(covid$rdata) %in% c("date","state"))]))
  })

  output$warning <- renderText(paste0("If this button is not working, ",
    "the name needs changed.\nPlease do not begin with a number or use ",
    "symbols other than an underscore"))

  observeEvent(input$newVarButton, {
    # validate(#sanitize input
    #   need(length(input$newVarName)>0, "Please enter a name for the variable"),
    #   need(!(input$newVarName[1] %in% c("0","1","2","3","4","5","6","7",
    #     "8","9")), "Please don't start with a number"),
      # need(sum(input$newVariableName %in% c("$","\\","/","`","~","&","^","%",
      #   "!", "|",",",":",";","\"","'","{","}","[","]","=","-","+","*","@"))==0,
    #   "Bad symbol detected")
    # )
      req(input$newVarName)
      covid$rdata <- covid$rdata %>%
        mutate("{input$newVarName}" :=
            get(input$operator)(!!sym(input$lhsVar),!!sym(input$rhsVar))
        )
  })

  #begin logic for "Graph" tab

  #to do: let them TITLE the graph and potentially pick geometry/geometries

  output$xUI <- renderUI({
    selectInput(inputId = "x",
      label = "x-axis variable:",
      choices = names(covid$rdata)
    )
  })

  output$yUI <- renderUI({
    selectInput(inputId = "y",
      label = "y-axis variable:",
      choices = names(covid$rdata)
    )
  })

  output$graphObj <- renderPlot(ggplot(data =
      covid$rdata[covid$rdata$state %in% input$state, ]) +
      aes_string(x = input$x, y = input$y) +
      aes(color = state) +
      geom_line() +
      ggtitle(input$graphTitle) +
      theme_dark()
      )
}
