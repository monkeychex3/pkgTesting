#' @import shiny

app_ui <- function() {
  fluidPage(
    navbarPage(
      title = "hello world"
    ),

    sidebarLayout(
      sidebarPanel(
        uiOutput("state_ui")
      ),
      mainPanel(
        actionButton(inputId = "load", label = "Load COVID Data"),
        textOutput("text"),
        verbatimTextOutput("table")
      )
    )
  )
}
