# Blueprint

## Aperçu

Cette application est un outil permettant aux enseignants de créer et de gérer des activités d'apprentissage pour leurs élèves. L'application est développée avec Flutter et utilise Firebase pour le backend. L'application permet aux enseignants de créer différents niveaux pour leurs élèves et de créer des listes d'activités pour chaque niveau. Les activités peuvent être de deux types : des listes de mots ou des activités basées sur des images.

## Style, Conception et Fonctionnalités

### Style et Conception

*   **Thème :** L'application utilise le thème Material Design par défaut avec une couleur primaire bleue.
*   **Mise en page :** L'application utilise une navigation par onglets pour séparer les élèves par niveau. La page d'accueil affiche une liste d'élèves pour chaque niveau.
*   **Icône d'application :** Une icône personnalisée a été ajoutée à l'application.
*   **Liste des élèves :** Les lignes de la liste des élèves ont des couleurs alternées pour une meilleure lisibilité.
*   **Gestion des niveaux :** Le formulaire d'ajout de niveau pré-remplit l'ordre et affiche un aperçu de la couleur.

### Fonctionnalités

*   **Intégration Firebase :** L'application est intégrée à Firebase pour le stockage et la récupération des données.
*   **Initialisation des données :** L'application initialise la base de données avec des données initiales pour les niveaux, les élèves et les activités.
*   **Gestion des élèves :** L'application affiche une liste d'élèves regroupés par niveau.
*   **Gestion des activités :** L'application affiche une liste d'activités pour chaque élève en fonction de son niveau.
*   **Activités basées sur des mots :** L'application affiche une liste de mots dans un ordre aléatoire.
*   **Activités basées sur des images :** L'application affiche une grille d'images avec les mots associés.
*   **Édition :** L'application permet aux enseignants de modifier les mots associés aux images dans les activités basées sur des images.
*   **Gestion des Élèves (CRUD) :** Une nouvelle page de gestion des élèves a été ajoutée. Elle permet d'ajouter, de modifier et de supprimer des élèves.
*   **Gestion des Niveaux (CRUD) :** Une nouvelle page de gestion des niveaux a été ajoutée. Elle permet d'ajouter, de modifier et de supprimer des niveaux.
*   **Gestion des Listes (CRUD) :** Une nouvelle page de gestion des listes d'activités a été ajoutée. Elle permet d'ajouter, de modifier et de supprimer des listes.
*   **Gestion des Mots (CRUD) :** Une nouvelle page de gestion des mots a été ajoutée. Elle permet de gérer le contenu (mots et images) d'une liste spécifique.
*   **Gestion des Images :** Une nouvelle page de gestion des images a été ajoutée. Elle permet de téléverser, de visualiser et de supprimer des images depuis Firebase Storage.
*   **Gestion des Associations Niveau-Liste :** Une nouvelle page a été ajoutée pour associer ou dissocier des listes d'activités à des niveaux spécifiques.
*   **Sélecteur d'images :** Le formulaire de gestion des listes et des mots permet désormais de choisir une image depuis la galerie d'images.
*   **Page "À propos" :** Une page "À propos" a été ajoutée, accessible depuis les paramètres, affichant les informations de l'application.
*   **Historique des activités :** Une nouvelle page permet de consulter l'historique des activités réalisées par les élèves. Elle offre la possibilité de filtrer les résultats par élève et par date, ainsi qu'un bouton pour vider complètement l'historique.

## Requête Actuelle : Historique des activités

*   **lib/models/models.dart :** Ajouter le modèle `Historique`.
*   **lib/screens/word_display_page.dart & lib/screens/eleve_detail_page.dart :** Intégrer l'enregistrement des activités dans l'historique.
*   **lib/screens/historique_page.dart :** Créer un nouvel écran pour afficher, filtrer et vider l'historique.
*   **lib/screens/settings_page.dart :** Ajouter un lien de navigation vers la page de l'historique.
*   **blueprint.md :** Mettre à jour le blueprint pour refléter les changements.
