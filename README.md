# Moqaf - Smart Transportation & Community App

Welcome to **Moqaf**, a comprehensive Flutter-based application designed to revolutionize the daily commute and foster a vibrant community for travelers. This project combines real-time transportation data, interactive maps, and social networking features to create a seamless experience for users.

## 🚀 Features

### 🚌 Transportation & Maps
*   **Station Locator**: Find nearby bus and transit stations with ease using interactive Google Maps.
*   **Line Details**: View detailed information about transportation lines, including routes, prices, and schedules.
*   **Search**: robust search functionality for stations and specific lines.

### 👥 Community & Social
*   **Social Feed**: A dedicated space for users to share updates, ask questions, and interact with the community.
*   **Create Posts**: Share your commuting experiences or report issues directly to the feed.
*   **Real-time Chat**: Connect with other commuters instantly using Socket.IO powered chat.
*   **Profile Management**: Customize your user profile and manage your account settings.

### 🔐 Authentication & Security
*   **Secure Login/Sign-up**: Robust authentication system using Firebase Auth.
*   **Password Recovery**: Easy-to-use "Forgot Password" flow.

## 🛠️ Technology Stack

This project leverages a modern and robust tech stack to ensure performance and scalability:

*   **Frontend**: [Flutter](https://flutter.dev/) (Dart)
*   **State Management**: [Flutter Bloc](https://pub.dev/packages/flutter_bloc) pattern for predictable state management.
*   **Networking**: [Dio](https://pub.dev/packages/dio) for handling API requests.
*   **Backend Services**: 
    *   **Firebase**: For Authentication and core backend services.
    *   **Socket.IO**: For real-time chat functionality.
    *   **Stripe**: Integrated for secure payment processing.
*   **Maps & Location**:
    *   `google_maps_flutter`: For rendering maps.
    *   `geolocator`: For device location services.
*   **Local Storage**:
    *   `shared_preferences`: For simple key-value storage.
    *   `hive`: For fast, lightweight NoSQL local database.
*   **UI/UX**:
    *   `flutter_screenutil`: For responsive design across devices.
    *   `google_fonts` & `flutter_animate`: For a polished and modern aesthetic.
    *   `skeletonizer`: For beautiful loading states.

## 📦 Getting Started

Follow these steps to set up the project locally:

### Prerequisites
*   [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.
*   An IDE (VS Code or Android Studio) with Flutter extensions.
*   Git installed.

### Installation

1.  **Clone the repository**
    ```bash
    git clone https://github.com/fekry1911/ITI_Final_Project.git
    cd ITI_Final_Project
    ```

2.  **Install Dependencies**
    ```bash
    flutter pub get
    ```

3.  **Environment Setup**
    *   Ensure you have the necessary Google Maps API keys configured in your `android/app/src/main/AndroidManifest.xml` and `ios/Runner/AppDelegate.swift`.
    *   Configure your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) for Firebase connectivity.

4.  **Run the App**
    ```bash
    flutter run
    ```

## 🤝 Contributing

Contributions are welcome! If you have suggestions for how to improve the app, please create a pull request or open an issue.

---
Developed for the ITI Graduation Project.
