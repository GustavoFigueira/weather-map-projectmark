# 🌦️ Weather Map

Weather Map is a weather application developed for the **ProjectMark** code challenge.

---

## 📝 About

The idea is not to use boilerplate code and overengineering, but rather to use all the best practices that I know and that major market players also use, making this app more scalable and easy to maintain.

---

## ✨ Required Key Features

- 🛠️ **Business Logic Implementation**: Well-structured and maintainable business logic.
- 🧩 **GetX State Management and Dependency Injection**: Efficient state management and dependency injection using GetX.
- 📦 **Cache Local Information Using Hive**: Store and retrieve local data efficiently with Hive.

---

## 🎁 Bonus Features Implemented

- 🌍 **Multiple Environments (Flavors)**: Support for development, staging, and production environments.
- 🔥 **Firebase Integration for Future Development**: Firebase setup for potential future features.
- 🎨 **Micro Interactions and UX Improvements**: Enhanced user experience with subtle animations and interactions.
- 🚀 **Native Splash Screen and Launcher Icons**: Custom splash screen and launcher icons for a polished look.

## 🌐 Live Preview

Check out the live preview of the Weather Map application: [👉💻 Visit the Live Website](https://weather-map-projectmark.web.app/)

![Live Preview](docs/live-preview.gif)

---

## 🚀 Installation

To get started with Weather Map, ensure you have the latest version of Flutter installed. At the time of writing, the latest version is **3.29.2**.

### 🛠️ Steps:

1. 📥 **Clone the repository**:

   ```bash
   git clone <https://github.com/GustavoFigueira/weather-map-projectmark>
   cd weather_map
   ```

2. 📦 **Install dependencies**:

   ```bash
   flutter pub get
   ```

3. ▶️ **Run the project**:
   - **Using VS Code**:
     - Open the project in VS Code.
     - Use the `launch.json` configurations to select the desired environment (development, staging, or production).
     - Press `F5` to run.
     - Select the desired device (Android emulator, iOS simulator, or web browser).
     - The recommendation is to run the Web project using any browser (e.g., Chrome, Edge, or Firefox) for the best experience.
     - Click the run button to launch the application in the browser.
   - **Using Android Studio**:
     - Open the project in Android Studio.
     - Use the run presets to select the desired environment.
     - Click on the run button.

## 🧪 Implemented Tests

- ✅ **Unit Tests**: Comprehensive unit tests to ensure the correctness of individual components and business logic.
- 📱 **Widget Tests**: Ensuring UI components behave as expected under various scenarios.

## 📂 Project Structure

```
weather_map
├── android
├── ios
├── lib
│   ├── app
│   │   ├── config
│   │   └── env
│   ├── app.dart
│   └── src
│       ├── core
│       │   ├── bindings
│       │   ├── constants
│       │   ├── helpers
│       │   ├── routing
│       │   └── services
│       ├── data
│       │   ├── constants
│       │   └── repository
│       ├── domain
│       │   ├── enums
│       │   ├── models
│       │   └── usecases
│       └── presentation
│           ├── global
│           └── home
├── pubspec.yaml
└── web
```

