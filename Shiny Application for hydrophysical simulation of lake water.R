# installing the required packages from github

install.packages('remotes')
remotes::install_github('usgs-r/glmtools')


library(devtools)
devtools::install_github("GLEON/GLM3r")

# Required Libraries

library(glmtools)
library(GLMr)
library(rLakeAnalyzer)
library(shiny)
library(OceanView)
library(GLM3r)
library(devtools)

# Getting the current system time and timezone
Sys.time()                    
Sys.timezone()

# Changing the current format of system time. Otherwise after running the shiny application, it creates timezone warning
Sys.setenv(TZ = "GMT")        

# New System time and timezone
Sys.time()                    
Sys.timezone()                

# Creating the shiny application

ui <- fluidPage(
  titlePanel("Hydrophysical Simulation"),
  sidebarLayout(
    sidebarPanel(("Parameters"),
                 sliderInput(inputId = "AT",
                             label = "Air temperature factor",
                             min = 0.5, max = 1.5, value = 1),
                 sliderInput(inputId = "W",
                             label = "Wind factor",
                             min = 0.33, max = 1.66, value = 1),
                 sliderInput(inputId = "P",
                             label = "Rain factor",
                             min = 0.5, max = 1.5, value = 1.0),
                 sliderInput(inputId = "SW",
                             label = "Short Wave factor",
                             min = 0.5, max = 1.5, value = 1.0),
                 sliderInput(inputId = "LW",
                             label = "Long Wave factor",
                             min = 0.5, max = 1.5, value = 1.0),
                 sliderInput(inputId = "RH",
                             label = "Relative Humidity factor",
                             min = 0.5, max = 1.5, value = 1.0),
                 sliderInput(inputId = "SA",
                             label = "Snow Albedo factor",
                             min = 0.5, max = 1.5, value = 1.0),
                 actionButton(
                   inputId = "submit_values",
                   label =  "Write nml file"
                   
                 ),
                 actionButton(
                   inputId = "run_GLM",
                   label =  "Run GLM"
                   
                 ),
                 
                 downloadButton("downloadPlot", "save the plot")
                 
    ),
    mainPanel(("Lake Stratification"),
              plotOutput("plot")
    )
  )
)

server <- function(input,output){
  
  
  
  observeEvent(input$submit_values,{
    
    nml_dat<- read_nml("glm3.nml")
    nml_dat <- set_nml(glm_nml = nml_dat,arg_name = "wind_factor",arg_val = input$W)
    nml_dat <- set_nml(glm_nml = nml_dat,arg_name = "at_factor",arg_val = input$AT)
    nml_dat <- set_nml(glm_nml = nml_dat,arg_name = "rain_factor",arg_val = input$P)
    nml_dat <- set_nml(glm_nml = nml_dat,arg_name = "sw_factor",arg_val = input$SW)
    nml_dat <- set_nml(glm_nml = nml_dat,arg_name = "lw_factor",arg_val = input$LW)
    nml_dat <- set_nml(glm_nml = nml_dat,arg_name = "rh_factor",arg_val = input$RH)
    nml_dat <- set_nml(glm_nml = nml_dat,arg_name = "snow_albedo_factor",arg_val = input$SA)
    write_nml(nml_dat,"glm3.nml")
    
  })
  
  observeEvent(input$run_GLM,{
    GLM3r::run_glm(system.args = "--nml glm3.nml")
    
  })
  
  output$plot <- renderPlot({
    input$run_GLM
    plot_var(nc_file = "output/output.nc")
    
  })  
  
  output$downloadPlot <- downloadHandler(
    filename = "Temperature Variation.png",
    content = function(file) {
      png(file)
      plot_var(nc_file = "output/output.nc")
      dev.off()
    }
  )
  
}

shinyApp(ui = ui, server = server)
