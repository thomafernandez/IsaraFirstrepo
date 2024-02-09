### 09/02/2024
### Thomas FERNANDEZ--SANTONNAT
### Test appli aéroport 


# Charger les bibliothèques nécessaires
library(shiny)
library(nycflights13)

# Define UI for application
ui <- fluidPage(
  
  # Titre de l'application
  titlePanel("Retards vol aéroport de NYC"),
  
  # Sidebar avec un sélecteur d'aéroport de départ
  sidebarLayout(
    sidebarPanel(
      selectInput("origin",
                  "Choisis un aéroport de départ:",
                  choices = unique(flights$origin),
                  selected = "JFK"),
      radioButtons("col","Couleurs",
                  choices = c("red","skyblue","orange","black"))
    ),
    
    # Afficher les graphiques
    mainPanel(
      plotOutput("histogram"),
      plotOutput("boxplot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  # Fonction pour générer l'histogramme
  output$histogram <- renderPlot({
    flight_data <- flights %>%
      filter(origin == input$origin)
    
    hist(flight_data$dep_delay, 
         main = paste("Répartition des retards de départ à partir de", input$origin),##titre du boxplot
         xlab = "Retard de départ (minutes)", ylab = "Frequence", col = input$col, border = "white")##nom des donnée
  })
  
  # Fonction pour générer le graphique en boîte
  output$boxplot <- renderPlot({
    flight_data <- flights %>%
      filter(origin == input$origin)##filtre les donnée de vol
    
    boxplot(dep_delay ~ origin, data = flight_data,
            main = paste("Boxplot du délai de départ de", input$origin), ##titre du boxplot
            xlab = "Aéroport de départ", ylab = "Retard de départ (minutes)") ##nom des donnée
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
