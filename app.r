library(shiny)
library(ggplot2)
library(ggmap)

tornado<-read.csv("https://www.spc.noaa.gov/wcm/data/2018_torn.csv" )

ui <- fluidPage(titlePanel(title = "Tornado Occurances Map"),
                sidebarLayout(sidebarPanel("Tornado Occurances"),
                              mainPanel(plotOutput("tornadomap"))),
                sliderInput("lati_slider","latitude", min = 0, max = 48, value = 25, pre = "Degree"),
                sliderInput("longi_slider","longitude", min = -124, max =0,value = -80.5, pre = "Degree"),
                )

server <- function(input,output)
{
  output$tornadomap<- renderPlot(
    
    get_stamenmap(c(left = input$longi_slider-10 , bottom =input$lati_slider-10 , right =input$longi_slider+10 , top =input$lati_slider+10), zoom = 5,maptype = "terrain") %>% ggmap()+geom_point(aes(x =tornado$slon, y =tornado$slat), data = tornado, colour = "red", size = 2)
    )
}
#runs shiny
shinyApp(ui = ui, server = server) 