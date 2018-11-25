library(shiny)
library(Cairo)

server <- function(input, output) {

### create the plots.
# No need to duplicate the plot functions if You use this kind of form
hist_plot <- function(){
  hist(mtcars$mpg, main = "")
}

scatter_plot <- function(){
  plot(mtcars$disp, mtcars$hp)
}

box_plot <- function(){
  boxplot(mtcars$drat)
}

### make UI objects
output$exp_plot1 <- renderPlot({
  hist_plot()
})

output$exp_plot2 <- renderPlot({
  scatter_plot()
})

output$exp_plot3 <- renderPlot({
  box_plot()
})

### function to do the pdf export
output$export <- downloadHandler("test.pdf", function(theFile) {

  makePdf <- function(filename){
    # I use Cairo instead of the the basic pdf function. It is much more complex and it supports special characters like "ű"  
    Cairo(type = 'pdf', file = filename, width = 21, height = 29.7, units='cm', bg='transparent')

    # configure the layout like this
    ################
    # plot1 plot2  #
    # plot3        #
    ################
    lo = matrix(c(1,2,3,4),2,2)
    layout(lo)

      # call the plots
      hist_plot()
      scatter_plot()
      box_plot()

    dev.off()
  }

  makePdf(theFile)
})

}