#' @import shiny

app_ui <- function() {
  navbarPage(
    title = HTML("<b><u>COVID State Comparisons</u></b>"),
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
      fluidRow(
        column(
          width = 6,
          HTML("<br><br>"),
          verbatimTextOutput("editPlaceholder"),
          HTML("<br><br>")
        )
      ),
      fluidRow(
        column(
          width = 8,
          textOutput("varNamesExplain"),
          verbatimTextOutput("varNames")
        )
      ),
      fluidRow(
        column(
          width = 2,
          textInput(inputId = "newVarName",
            label = "Type your new variable name here")
        ),
        column(
          width = 1,
          HTML("<br><br>"),
          h3(textOutput("equalsSign"))
        ),
        column(
          width = 2,
          HTML("<br>"),
          uiOutput("lhsVar")
        ),
        column(
          width = 2,
          HTML("<br>"),
          selectInput(inputId = "operator",
            label = "Operation to Perform",
            choices = c("+","-","*","/"))
        ),
        column(
          width = 2,
          HTML("<br>"),
          uiOutput("rhsVar")
        )
      ),
      fluidRow(
        column(
          width = 3,
          actionButton(inputId = "newVarButton",
            label = "Save New Variable")
        ),
        column(
          width = 4,
          textOutput("warning")
        )
      )
    ),

    #fourth tab
    tabPanel(
      title = "Graph",
      fluidRow(
        column(
          width = 7,
          HTML("<br><br>"),
          verbatimTextOutput("graphPlaceholder"),
          HTML("<br><br>")
        )
      ),
      fluidRow(
        column(
          width = 3,
          uiOutput("xUI"),
          uiOutput("yUI"),
          textInput(inputId = "graphTitle",
            label = "Type Title Here")
        ),
        column(
          width = 7,
          plotOutput("graphObj")
        )
      )
    ),
    #this makes the top right section of the navBar
    tags$script(HTML(paste0("var header = $('.navbar> .container-fluid');",
      "header.append('<div style=\"float:right; margin-top : 10px\">",
      "by Adam Coger<br>acoger@bgsu.edu</div>');
      console.log(header)")))
  )
}
