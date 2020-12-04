#' @import shiny

run <- function() {
  shinyApp(ui = app_ui, server = app_server)
}
