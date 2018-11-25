library(shiny)
library(Cairo)
library(ggplot2)
library(gridExtra)

server <- function(input, output) {

   ### create the plots.
   # No need to duplicate the plot functions if You use this kind of form
   hist_plot <- function(){
     ggplot(mtcars, aes(mpg)) + geom_histogram()
   }
   
   scatter_plot <- function(){
     ggplot(mtcars, aes(x=disp, y=hp)) + geom_point()
   }
   
   box_plot <- function(){
     ggplot(mtcars, aes(x=factor(""), y = drat)) + geom_boxplot()
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
   
         p1 <- hist_plot()
         p2 <- scatter_plot()
         p3 <- box_plot()
   
         # configure the layout like this
         ################
         # plot1 plot2  #
         # plot3        #
         ################
         p <- grid.arrange(p1, p2, p3, ncol=2)
   
         print(p)
   
       dev.off()
     }
   
     makePdf(theFile)
   })

}
