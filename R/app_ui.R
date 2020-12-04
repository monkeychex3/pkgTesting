#' @import shiny

app_ui <- function() {
  # fluidPage(
  #   theme = shinythemes::shinytheme("darkly")
  # )
  navbarPage(
    title = "This is Navbar placeholder text",
    theme = shinythemes::shinytheme("darkly"),
    tabPanel(
      title = "select",
      fluidRow(
        column(
          width = 4,
          HTML("<br><br>"),
          textOutput("selectPlaceholder"),
          HTML("<br><br>"),
          dateRangeInput(
            inputId = "dateRange", label = "Date Range to Load:",
            start = "2020-02-01",end = Sys.Date(),
            min = "2020-02-01", max = Sys.Date()
          ),
          actionButton(inputId = "load", label = "Load COVID Data")
        ),
        column(
          width = 4,
          uiOutput("state_ui")
        ),
        column(
          width = 4,
          verbatimTextOutput("summary")
        )
      )
    ),
    tabPanel(
      title = "edit",
      column(
        width = 4,
        HTML("<br><br>"),
        textOutput("editPlaceholder"),
        HTML("<br><br>")
      ),

    ),
    tabPanel(
      title = "graph",
      column(
        width = 4,
        HTML("<br><br>"),
        textOutput("graphPlaceholder"),
        HTML("<br><br>")
      )
    )
  )
}
