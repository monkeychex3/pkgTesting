#' @import shiny

app_ui <- function() {
  navbarPage(
    title = "This is Navbar placeholder text",
    theme = shinythemes::shinytheme("darkly"),
    tabPanel(
      title = "Dates",
      HTML("<br><br>"),
      textOutput("datesPlaceholder"),
      HTML("<br><br>"),
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
        actionButton(inputId = "load", label = "Load COVID Data"),
        HTML("<br>"),
        HTML("<br>"),
        textOutput("confirmation")
      )
    ),
    tabPanel(
      title = "States",
      fluidRow(
        column(
          width = 12,
          HTML("<br><br>"),
          textOutput("statesPlaceholder"),
          HTML("<br><br>"),
        )
      ),
      fluidRow(
        sidebarLayout(
          sidebarPanel(
            uiOutput("state_ui")
          ),
          mainPanel(
            verbatimTextOutput("summary", placeholder = TRUE)
          )
        )
      )
    ),
    tabPanel(
      title = "Edit",
      column(
        width = 4,
        HTML("<br><br>"),
        textOutput("editPlaceholder"),
        HTML("<br><br>")
      ),

    ),
    tabPanel(
      title = "Graph",
      column(
        width = 4,
        HTML("<br><br>"),
        textOutput("graphPlaceholder"),
        HTML("<br><br>")
      )
    )
  )
}
