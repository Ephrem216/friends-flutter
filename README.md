👫 Friends App
This is a Flutter application for managing a list of friends using CRUD operations with Hive. The app allows users to add, delete, and view friends, including uploading their photos and providing descriptions. It also includes a special "About" section. The app supports Android-specific features such as selecting images from the gallery or capturing photos via the camera.

🛠️ Project Overview
Language Used: Dart (Flutter)
Database: Hive (for local storage of friends' data)
UI: Designed with a clean, user-friendly interface
Platform: Android (with potential support for other platforms)
Learning Source: Personal project based on learning and hands-on experimentation
📂 Project Structure
bash
Copy
Edit
├── android/ # Android-specific files
├── assets/ # Image and asset files
├── build/ # Build output
├── ios/ # iOS-specific files
├── lib/ # Dart source code
│ ├── detailed_page.dart # Page to view detailed information about a friend
│ ├── friend.dart # Model class for a friend
│ ├── friend_app.dart # Main app widget
│ ├── list_of_friends.dart # List of all friends in the app
│ ├── new_page.dart # Page to add a new friend
│ ├── drawer_class.dart # Drawer menu widget
│ ├── friend.g.dart # Generated Hive adapter for the friend model
│ ├── home.dart # Home screen of the app
│ └── main.dart # Entry point for the app
├── macos/ # macOS-specific files
├── pubspec.yaml # Flutter project configuration
├── pubspec.lock # Locked dependencies for the project
├── test/ # Unit tests
└── README.md # Project documentation
🌟 Features
Add Friends: Add a friend with a name, description, and a photo.
View Friends: View detailed information about each friend.
Delete Friends: Remove friends from your list.
Image Picker: Pick images from the device gallery or capture new ones using the camera (Android-specific).
About Section: View the user's own information.
Hive Database: All data is stored locally using Hive for efficient CRUD operations.
User-Friendly UI: Clean and aesthetically designed with appealing font colors and intuitive navigation.

📘 Learning Journey
This project was built to practice Flutter and Hive for persistent data storage in mobile apps. It also helped solidify concepts like state management, navigation, and Android-specific features such as image picking and camera functionality.
