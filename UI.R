library(shiny)

shinyUI(fluidPage(
  titlePanel("Bayesian t-test"),
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Choose CSV File',
                accept=c('text/csv', 
                         'text/comma-separated-values,text/plain', 
                         '.csv')),
      tags$hr(),
      checkboxInput('header', 'Header', TRUE),
      radioButtons('sep', 'Separator',
                   c(Comma=',',
                     Semicolon=';',
                     Tab='\t'),
                   ','),
      radioButtons('quote', 'Quote',
                   c(None='',
                     'Double Quote'='"',
                     'Single Quote'="'"),
                   '"'),
      selectInput(
        "logs", "Log transform",
        c(None = "no",
          Logs = "yes"))
     
    ),
    mainPanel(
      tabsetPanel(
      tabPanel("Data loading",  
       h1("This displays a table of your data (to check for errors)"),
       tableOutput('contents')),
      tabPanel("Data checking",
       h1("This displays a comparative probability distribution of our data with credible intervals"),
       plotOutput('plot'),
       
      tabPanel("Parametric inference",
       h2("Key summary statistics"),
       verbatimTextOutput("bayessummary.out"),
       
       br(),
       h3("Details on the t-test"),
       verbatimTextOutput("bayes.out"),
       br(),
       
      
       p("Thus we successfully performed Bayesian t test with help of packages from Rasmus Baath and John Kruschke"),
       textOutput('pvaluelog')))
      )
      
      
      ))))

