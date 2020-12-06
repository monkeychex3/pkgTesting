#' @import shiny

app_ui <- function() {
  navbarPage(
    title = "COVID State Comparisons",
    theme = shinythemes::shinytheme("darkly"),
    #first tab in navbar starts here
    tabPanel(
      title = "Dates",
      column(
        width = 6,
        HTML("<br><br>"),
        verbatimTextOutput("datesPlaceholder"),
        HTML("<br><br>")
      ),
      column(
        width = 12,
        align = "center",
        dateRangeInput(
          inputId = "dateRange", label = "Date Range to Load:",
          start = "2020-02-01",end = Sys.Date(),
          min = "2020-02-01", max = Sys.Date()
        ),
        HTML("<br>"),
        HTML("<br>"),
        actionButton(inputId = "loadButton", label = "Load COVID Data"),
        HTML("<br>"),
        HTML("<br>"),
        textOutput("confirmation"),
        tableOutput("newConfirmation")
      )
    ),
    #second tab
    tabPanel(
      title = "States",
      fluidRow(
        column(
          width = 6,
          HTML("<br><br>"),
          verbatimTextOutput("statesPlaceholder"),
          HTML("<br><br>"),
        )
      ),
      fluidRow(
        sidebarLayout(
          sidebarPanel(
            uiOutput("stateUI")
          ),
          mainPanel(
            verbatimTextOutput("summary", placeholder = TRUE)
          )
        )
      )
    ),
    #third tab
    tabPanel(
      title = "Edit",
      column(
        width = 6,
        HTML("<br><br>"),
        verbatimTextOutput("editPlaceholder"),
        HTML("<br><br>")
      ),

    ),
    #fourth tab
    tabPanel(
      title = "Graph",
      fluidRow(
      column(
        width = 6,
        HTML("<br><br>"),
        verbatimTextOutput("graphPlaceholder"),
        HTML("<br><br>")
      )
      ),
      fluidRow(
        column(
          width = 3,
          uiOutput("xUI"),
          uiOutput("yUI")
        ),
        column(
          width = 7,
          plotOutput("graphObj")
        )
      )
    )
  )
}
