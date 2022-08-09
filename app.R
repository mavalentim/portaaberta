#libs
#devtools::install_github("beatrizmilz/mananciais")

library(shiny)
library(dplyr)



# Define UI for application that draws a histogram


#Define uma base de dados, pensei em um googlesheets 
#alimentado por um forms 
data <-tibble(nome = c('Dicardo Rahis', 'Truce', 'Pava'),
              area = c('Economia', 'Ciencia de Dados', 'Eng de Dados'),
              bio = c('Dicardo é professor de teologia da PUC Rio',
                      'Truce é cientista de dados na xxxx',
                      'Pava é engenheiro de dados xxxx'),
              link = c('www.site.com',
                       'www.site2.com',
                       'WWW.SITE3.COM'))

ui <- fluidPage(
  
  #Title and little text
  h2("Porta Aberta: encontre e converse com especialistas, professores e
     profissionais brasileiros de diferentes áreas"),
  
  h5("Descrição aprofundada"),
  
  #App intro
  h4("Escolha uma área:"),
  #Input  
  selectInput('area', "Área de conhecimento", 
              choices = unique(data$area)),
  
  
  #Second Input
  h4("Escolha um dos profissionais dessa área"),
  uiOutput("secondSelection"),
  
  #Displaying info and link
  h5("Aqui tem uma descrição dele/a"),
  textOutput('info'),
  h5("Aqui tem o link para marcar um horário"),
  textOutput('link')
)



# Define server logic required to draw a histogram
server1 <- function(input, output, session) {
  
  output$secondSelection <- renderUI({
    selectInput("nome", "Nome:", choices = as.character(data[data$area==input$area,"nome"]))
  })
  
  output$info <- renderText({
    data |> filter(nome == input$nome) |> pull(bio)
  })

  output$link <- renderText({
    data |> filter(nome == input$nome) |> pull(link)
  })
  
}


# Run the application 
shinyApp(ui = ui, server = server1)










