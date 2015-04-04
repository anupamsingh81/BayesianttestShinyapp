library("BayesianFirstAid")
library(shiny)

shinyServer(function(input, output) {

  Data <- reactive({
#  output$contents <- renderTable({
    
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
read.csv(inFile$datapath, header=input$header, sep=input$sep, 
             quote=input$quote)



  })




output$contents <- renderTable({ 
  my.df <- Data()
  if (is.null(my.df)){return(NULL)} 
  my.df})



output$plot <- renderPlot({
  my.df <- Data()
  if (is.null(my.df)){return(NULL)}
  fit<-bayes.t.test(my.df[,1]~my.df[,2])
  plot(fit)})




bayes <- reactive({
  my.df <- Data()
  if (is.null(my.df)){return(NULL)}
  bayes.t.test(my.df[,1]~my.df[,2], )
})


bayessummary <- reactive({
  my.df <- Data()
  if (is.null(my.df)){return(NULL)}
  fit<-bayes.t.test(my.df[,1]~my.df[,2])
  summary(fit)})


output$bayes.out <- renderPrint({
  bayes()
})

output$bayessummary.out <- renderPrint({
  bayessummary()
})




























output$parametriclog <- renderTable({
  my.df <- Data()
  if (is.null(my.df)){return(NULL)}
   if (min(my.df[,1]) <= 0 ){return(NULL)}
  means <- tapply(log(my.df[,1]), my.df[,2], mean)
  sds <- tapply(log(my.df[,1]), my.df[,2], sd)
  ses<- tapply(log(my.df[,1]), my.df[,2], function(x) sd(x)/sqrt(length(x)))
  parametric <- data.frame(mean = c(means[1],means[2] ), sd=c(sds[1], sds[2]), se=c(ses[1], ses[2]))
  return(parametric)
})



})
