#' @import shiny

runApp <- function() {
  shinyApp(ui = app_ui, server = app_server)
}
