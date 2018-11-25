library(shiny)
library(ggplot2)

ui <- fluidPage(
downloadButton("export", label = "download content"),
titlePanel("PDF export example"),

mainPanel(
  plotOutput(outputId = "exp_plot1"),
  plotOutput(outputId = "exp_plot2"),
  plotOutput(outputId = "exp_plot3")
)  
)
