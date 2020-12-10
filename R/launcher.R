#' @import shiny

#' @export
runApp <- function(options = list()) {
  shinyApp(ui = app_ui, server = app_server, options = options)
}
