# Essai Jeu Godot

Un jeu 2D développé avec **Godot Engine**, mettant en scène un personnage qui peut courir, sauter, attaquer et interagir avec l'environnement.

---

## 📦 Prérequis

- [Godot Engine](https://godotengine.org/download) version 4.x ou supérieure
- Système d'exploitation : Windows, macOS ou Linux

---

## 🚀 Installation

1. **Cloner le dépôt :**

```bash
git clone https://github.com/Randimbisoa179/essai-jeu-godot-.git
cd essai-jeu-godot-
Ouvrir le projet avec Godot :

Lancez Godot Engine

Cliquez sur "Importer" et sélectionnez le dossier du projet cloné

Ouvrez le projet

Lancer le jeu :

Appuyez sur le bouton "Jouer" dans l'éditeur Godot

🎮 Contrôles
Flèches directionnelles / WASD : Déplacer le personnage

Espace : Sauter

Entrée : Attaquer

Zone de fin : Entrer dans la zone pour déclencher l'animation de fin

🧩 Fonctionnalités
Mouvements fluides : course, saut, chute

Attaques avec ou sans arme

Animations variées : idle, run, jump, fall, hurt, finish

Knockback lors de collisions à haute vitesse

Zone de fin de niveau avec animation "finish" (non bloquante)

Caméra qui suit le joueur et peut se verrouiller sur l’animation de fin

📁 Structure du projet
csharp
Copier le code
essai-jeu-godot-/
├── addons/                  # Extensions et modules supplémentaires
├── assets/                  # Ressources graphiques et audio
├── scenes/                  # Scènes Godot
│   ├── main.tscn            # Scène principale du jeu
│   └── player.tscn          # Scène du personnage joueur
├── scripts/                 # Scripts GDScript
│   ├── player.gd            # Logique du personnage joueur
│   └── global.gd            # Variables et fonctions globales
└── project.godot            # Fichier de configuration du projet
🧪 Développement
Scripts écrits en GDScript, le langage natif de Godot

Organisation des scènes pour faciliter l’ajout de niveaux, ennemis ou nouvelles mécaniques

Utilisation de Git pour le contrôle de version

Signal body_entered sur FinishArea pour déclencher l’animation de fin

🖼️ Suggestions pour améliorer le projet
Ajouter des sprites et animations supplémentaires

Ajouter un système d’ennemis

Ajouter un système de score ou de niveaux

Ajouter des sons et musiques

Ajouter une transition vers un écran de victoire après l’animation "finish"

📄 Licence
Ce projet est sous licence MIT. Vous êtes libre de l'utiliser, le modifier et le redistribuer selon les termes de cette licence.
