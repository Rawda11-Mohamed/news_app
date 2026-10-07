# 📰 Khaber — News App

A modern Flutter news application designed to provide users with an easy and engaging way to explore news, discover articles by category, search for specific content, save bookmarks, and view weather information.

## 📱 About the Project

**Khaber** is a Flutter-based news application built as a practical mobile development project. The app focuses on clean UI, reusable components, state management, repository-based data handling, and a smooth user experience.

The application provides different sections for discovering and reading articles, including featured news, popular articles, categories, search, bookmarks, and article details.

## ✨ Features

* 🏠 **Home Screen**

  * Featured articles
  * Most popular articles
  * Personalized greeting
  * Weather information
  * Pull-to-refresh

* 🔎 **Search**

  * Search for articles by title, content, or author
  * Search results displayed in a dedicated screen

* 🧭 **Explore**

  * Browse articles by category
  * Travel
  * Technology
  * Business
  * Refresh articles by category

* 📖 **Article Details**

  * Read the complete article
  * View article image, title, author, date, and category

* 🔖 **Bookmarks**

  * Save favorite articles
  * Manage saved articles locally

* 🌤️ **Weather**

  * Display current weather information
  * Refresh weather data

* 📍 **Location**

  * Location-related functionality using device location services

* 👤 **User**

  * Load and display user information

## 🛠️ Technologies & Tools

* **Flutter**
* **Dart**
* **Flutter BLoC / Cubit**
* **Dio**
* **HTTP**
* **SharedPreferences**
* **Geolocator**
* **Google Maps Flutter**
* **Flutter SVG**
* **Google Fonts**
* **Dartz**

## 🏗️ Architecture

The project follows a repository-based structure with Cubit for state management.

### State Management

The application uses **Cubit** from the Flutter BLoC package to manage application states, including:

* Articles
* Search
* Bookmarks
* Weather
* User
* Location

### Repository Pattern

Repositories are responsible for handling data operations and keeping data-related logic separate from the UI.

Examples include:

* `ArticlesRepository`
* `BookmarksRepository`
* `WeatherRepository`
* `UserRepository`
* `LocationRepository`

## 📂 Project Structure

```text
lib/
├── constants/
│   ├── app_assets.dart
│   ├── app_colors.dart
│   ├── app_dimensions.dart
│   └── app_text_styles.dart
│
├── cubits/
│   ├── articles/
│   ├── bookmarks/
│   ├── location/
│   ├── search/
│   ├── user/
│   └── weather/
│
├── models/
│
├── repositories/
│   ├── articles_repository.dart
│   ├── bookmarks_repository.dart
│   ├── location_repository.dart
│   ├── user_repository.dart
│   └── weather_repository.dart
│
├── screens/
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   ├── explore_screen.dart
│   ├── search_screen.dart
│   ├── article_screen.dart
│   └── ...
│
├── widgets/
│   ├── article_card.dart
│   ├── featured_article_card.dart
│   ├── explore_article_card.dart
│   └── ...
│
└── main.dart
```

## 🔄 Application Flow

```text
UI Screen
    ↓
Cubit
    ↓
Repository
    ↓
Data Source
    ↓
Model
    ↓
Cubit State
    ↓
UI Update
```

## 🎨 UI

The application uses a clean and modern news-oriented interface with reusable cards, categorized content, featured articles, search functionality, and responsive layouts.

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/Rawda11-Mohamed/news_app.git
```

### 2. Navigate to the Project

```bash
cd news_app
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Run the Application

```bash
flutter run
```

## 📦 Main Dependencies

```yaml
flutter_bloc: ^8.1.3
dio: ^5.2.0
http: ^1.1.0
shared_preferences: ^2.2.2
geolocator: ^10.1.0
google_maps_flutter: ^2.5.0
flutter_svg: ^2.0.7
google_fonts: ^6.1.0
dartz: ^0.10.1
```

## 📚 What I Practiced

Through this project, I practiced:

* Flutter UI development
* Dart programming
* State management with Cubit
* Repository Pattern
* API/data handling
* Local data persistence
* Search functionality
* Category-based filtering
* Location services
* Weather integration
* Reusable widgets
* Navigation between screens
* Clean and maintainable project organization

## 📸 Screenshots

<p align="center">
  <img src="https://github.com/user-attachments/assets/9dfb7004-bf8a-444f-9949-ae6aeb063b2d" width="220"/>
  <img src="https://github.com/user-attachments/assets/de05413f-1b58-4a02-a40f-4392a062155e" width="220"/>
</p>



<p align="center">
  <img src="https://github.com/user-attachments/assets/a16b1519-268a-4ca3-a4de-cfbb3485b297" width="220"/>
  <img src="https://github.com/user-attachments/assets/75c65ef2-b5af-420f-95f1-bebe4d8f0834" width="220"/>
</p>



<p align="center">
  <img src="https://github.com/user-attachments/assets/42d18c7a-22a3-48ef-a05e-acd7ea1e1be4" width="220"/>
  <img src="https://github.com/user-attachments/assets/29f69960-d9db-460e-91e1-83f206aa11a4" width="220"/>
</p>



<p align="center">
  <img src="https://github.com/user-attachments/assets/96db0808-aab6-452e-bd11-227b48c1ae3e" width="220"/>
</p>

---


