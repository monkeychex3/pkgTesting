#' @import shiny

app_ui <- function() {
  fluidPage(
    theme = shinythemes::shinytheme("darkly"),
    navbarPage(
      title = "This is Navbar placeholder text",
      tabPanel(
        title = "select",
        column(
          width = 4,
          HTML("<br><br>"),
          textOutput("selectPlaceholder"),
          HTML("<br><br>"),
          dateRangeInput(inputId = "dateRange", label = "Date Range to Load"),
          actionButton(inputId = "load", label = "Load COVID Data")
        ),
        column(
          width = 3.5,
          uiOutput("state_ui")
        )
      ),
      tabPanel(
        title = "edit",
        column(
          width = 4,
          HTML("<br><br>"),
          textOutput("editPlaceholder"),
          HTML("<br><br>")
        )
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
  )
}
