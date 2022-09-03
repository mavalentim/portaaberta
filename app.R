#libs
#devtools::install_github("beatrizmilz/mananciais")

library(shiny)
library(dplyr)
library(googlesheets4)


# Define UI for application that draws a histogram


#Auntentica 
#STACKOVERFLOW COMO AUTENTICAR PASSIVAMENTE
# Set authentication token to be stored in a folder called `.secrets`
options(gargle_oauth_cache = ".secrets")

# Authenticate manually
gs4_auth()

# If successful, the previous step stores a token file.
# Check that a file has been created with:
list.files(".secrets/")

# Check that the non-interactive authentication works by first deauthorizing:
gs4_deauth()

# Authenticate using token. If no browser opens, the authentication works.
gs4_auth(cache = ".secrets", email = "mavalentim.b@gmail.com")


#Define uma base de dados, pensei em um googlesheets 
#alimentado por um forms 

data <- googlesheets4::read_sheet(
  'https://docs.google.com/spreadsheets/d/1QGLoYSQlAaTIwb8Il8qBGHG7Db5UH58gLHwipkjiZEU/edit?resourcekey#gid=1156584149'
  ) |> 
  #rename columns to be used down there
  purrr::set_names('envio','nome','area','bio', 'link') |> 
  select(-envio)





# Previamente 
# data <-tibble(nome = c('Dicardo Rahis', 'Truce', 'Pava'),
#               area = c('Economia', 'Ciencia de Dados', 'Eng de Dados'),
#               bio = c('Dicardo é professor de teologia da PUC Rio',
#                       'Truce é cientista de dados na xxxx',
#                       'Pava é engenheiro de dados xxxx'),
#               link = c('www.site.com',
#                        'www.site2.com',
#                        'WWW.SITE3.COM'))




ui <- fluidPage(
  tabsetPanel(
    #Painel 1
    tabPanel("Procurando um tutor",
             #Title and little text
             h2("Porta Aberta: encontre e converse com 
     profissionais de diferentes áreas"),
             
             h5("A ideia do site é permitir que pessoas com experiência se 
                conectem com recém-chegados a áreas de conhecimento. Os tutores
                preenchem um formulário que é automaticamente carregado no site. 
                Os recém-chegados podem consultar os diferentes tutores cadastrados
                nas diferentes áreas do conhecimento."),
             
             #App intro
             h3("Escolha uma área:"),
             #Input  
             selectInput('area', "Área de conhecimento", 
                         choices = unique(data$area)),
             
             
             #Second Input
             h3("Escolha um dos profissionais dessa área"),
             uiOutput("secondSelection"),
             
             #Displaying info and link
             h3("Aqui tem uma descrição dele/a"),
             textOutput('info'),
             h3("Aqui tem o link para marcar um horário"),
             a(textOutput('link'))
    ),
    #Painel 2
    tabPanel("Como virar um tutor",
             h2("Como faço para ser um tutor?"),
             h4("Para ser um tutor, é necessário fazer duas coisas:"),
             #Parte 1
             h4('1) Criar uma conta em um aplicativo de  calendário 
                para marcar conversas. Esses aplicativos são vinculados
                a sua conta de email e permitem a interessados marcarem 
                uma reunião virtual nos horários que você se mostrou
                disponível. Existem vários aplicativos no mercado e um
                dos mais fáceis é o aplicativo Koalendar.
                Não é necessário ser o Koalendar, mas ele funciona 
                bem, tem tutoriais de como se cadastrar e é intuitivo.
                Ao se cadastrar você recebe um link para que marquem horários com você,
                esse link é a última pergunta do formulário.'),
             h4("Mais abaixo na página, há um tutorial de como criar uma conta no Koalendar."),
             #Parte 2
             h5(),
             h5(),
             h4('2) Preencher o formulário do Google abaixo com seu
                nome, a área qual você deseja falar sobre, uma breve introdução
                e claro, o link para a conta que você definiu no aplicativo de
                calendário.'),
             h5(),
             h3("Formulário Google para ser um tutor:"),
             a('https://forms.gle/HDWYFy8axQFqN5MQ9'),
             h5(),
             h5(),
             #Parte 3: tutorial Koalendar
             h3("Como criar sua conta no Koalendar", style = 'margin-top:20px;
                margin-bottom:10px'),
             
             h4('O koalendar é um site para que pessoas possam marcar reuniões com você.
                O primeiro passo é ir ao site koalendar.com que se parece com isso aqui:', 
                style = 'margin-top:20px;
                margin-bottom:10px'),
             img(src = 'tutorial_img1.jpg',height="50%", width="50%", align="center"),
             
             
             h4("Vamos clicar em 'Get Started' como circulado abaixo",style = 'margin-top:20px;
                margin-bottom:10px'),
             
             img(src = 'tutorial_img2.jpg',height="50%", width="50%", align="center"),
             
             h4("Isso vai nos levar a entrar com nossa conta do Google, ou alguma
                conta que você use um aplicativo de calendário. É importante que 
                seja uma conta que você use um calendário porque o aplicativo automaticamente
                evita que você marque reuniões quando compromissos seus já estão marcados.",
                 style = 'margin-top:20px;margin-bottom:10px'),
             
             img(src = "tutorial_img3.jpg",height="50%", width="50%", align="center"),
             
             h4('Uma vez logado na conta escolhida, é importante dar as permissões ao aplicativo,
                para que justamente ele tenha acesso à seu calendário. A página de permissões
                se parece com a imagem abaixo e deve ter as duas últimas caixinhas ticadas'),
             
             img(src = 'tutorial_img4.jpg',height="50%", width="50%", align="center"),
             
             h4("Agora você está dentro do aplicativo e para concluir o processo, basta
                clicar em New Booking Page, como demonstrado na imagem abaixo."),
             
             img(src = 'tutorial_img7.jpg',height="50%", width="50%", align="center"),
             
             h4("A booking page é o meio pelo qual as pessoas marcarão horários com você.
                Essa 'page' pode ser editada para somente liberar horários no final de semana,
                para mudar o tamanho da reunião para menos de 30 minutos, entre outros.
                Isso é feito uma vez clicado na New Booking Page, na página de edição 
                da sua Booking Page, demonstrada abaixo:"),
             
             img(src ='tutorial_img8.jpg',height="50%", width="50%", align="center"),
             
             img(scr = 'tutorial_img9.jpg',height="50%", width="50%", align="center"),
             
             img(src= 'tutorial_img10.jpg',height="50%", width="50%", align="center"),
             
             h4('Uma vez configurada as características da sua Booking Page, você vai receber
                um link para essa página. Esse link é muito importante: ele é usado no
                formulário Google mencionado anteriormente. 
                É com esse link da Booking Page que você se cadastra para ser um tutor
                do Porta Aberta. Ele vai
                aparecer junto ao seu nome, e à sua descrição na página inicial. Ele pode
                ser facilmente copiado quando você terminar a customizar e criar sua
                Booking Page, como demonstrado na figura abaixo:'),
             img(src= 'tutorial_img12.jpg',height="50%", width="50%", align="center"),
             
             h4("Isso conclui o tutorial! Agora você pode preencher o formulário Google 
                e seu nome deve aparecer no site. Qualquer dúvida fique a vontade em 
                mandar um email para mavalentim.b@gmail.com")
             
             
             
             
             )
  )
)













# Define server logic required to draw a histogram
server1 <- function(input, output, session) {
  
  output$secondSelection <- renderUI({
    #selectInput("nome", "Nome:", choices = as.character(data[data$area==input$area,"nome"]))
    selectInput('nome', 'Nome:',  choices =data |> filter(area %in% input$area) |> pull(nome) )
    
  })
  
  output$info <- renderText({
    data |> filter(nome %in% input$nome) |> pull(bio)
  })

  output$link <- renderText({
    data |> filter(nome %in% input$nome) |> pull(link)
  })
  
}


# Run the application 
shinyApp(ui = ui, server = server1)










