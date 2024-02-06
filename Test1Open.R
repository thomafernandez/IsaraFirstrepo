library(dplyr)
data("starwars")
names(starwars)
library(ggplot2)

#graphique 1
# Sélectionner les données pertinentes pour le graphique
starwars_donnée1 <- starwars %>%
  filter(!is.na(height)) %>%
  select(name, height)

# Créer le graphique
ggplot(data = starwars_donnée1, aes(x = name, y = height)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  theme_minimal() +
  coord_flip() + #inverser les axes pour plus de lisibilité
  labs(title = "Taille des personnages de Star Wars",
       x = "Personnages",
       y = "Taille")

#graphique 2
# Sélectionner les données de masse et espèce pour le graphique
starwars_donnée2 <- starwars %>% #permet de chaîner plusieurs opérations ensemble de manière lisible et concise
  filter(!is.na(mass) & !is.na(species)) #séléction donnée masse et espèce

# Créer le graphique en violon
ggplot(data = starwars_donnée2, aes(x = species, y = mass, fill = species)) +
  geom_violin(trim = FALSE) + #graph violon
  geom_boxplot(width = 0.1, fill = "white", color = "black", alpha = 0.5) +
  theme_minimal() + #rajout d'une boite à moustache pour médianes et dispersion des données
  labs(title = "Répartition de la masse des personnages de Star Wars par espèce",
       x = "Espèce",
       y = "Masse") + # définir les noms des axes et nom graphique
  scale_fill_brewer(palette = "Set3") + #palette de couleur 
  coord_flip() #inverser les axes pour plus de lisibilité
