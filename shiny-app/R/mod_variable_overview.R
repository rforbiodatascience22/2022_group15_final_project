#' variable_overview UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_variable_overview_ui <- function(id){
  ns <- NS(id)
  tagList(
    titlePanel("test"),

    shiny::sidebarLayout(
      shiny::sidebarPanel(
        shiny::radioButtons(
          inputId = ns("attributes"),
          label = NULL,
          choices = c("protein1", "protein2")
        )
      ),
      mainPanel(
        "main panel test"
        #plotOutput("distPlot")
      )

    )
  )
}

#' variable_overview Server Functions
#'
#' @noRd
mod_variable_overview_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

  })
}

## To be copied in the UI
# mod_variable_overview_ui("variable_overview_1")

## To be copied in the server
# mod_variable_overview_server("variable_overview_1")
