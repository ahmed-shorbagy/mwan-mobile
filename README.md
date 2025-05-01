# Mwan Mobile

A Flutter messaging application with modern design and Arabic RTL support.

## Features

- Dark theme UI inspired by modern messaging apps
- Arabic language support with RTL layout
- MVVM architecture with Cubit state management
- Go Router for navigation
- Responsive design
- Google Fonts with Cairo font for Arabic text

## Project Structure

```
lib/
├── core/
│   ├── constants/      # App constants and configurations
│   ├── extensions/     # Extension methods
│   ├── network/        # API client and network utilities
│   ├── router/         # Navigation and routing
│   ├── theme/          # App theme and styling
│   ├── utils/          # Utilities and helpers
│   └── widgets/        # Reusable widgets
├── features/
│   ├── auth/           # Authentication feature
│   │   ├── data/       # Data sources and repositories
│   │   ├── domain/     # Use cases and entities
│   │   └── presentation/ # UI components and state management
│   ├── chat/           # Chat feature
│   ├── home/           # Home feature
│   ├── profile/        # Profile feature
│   ├── settings/       # Settings feature
│   └── splash/         # Splash screen
└── main.dart           # App entry point
```

## Getting Started

1. Clone the repository
2. Install dependencies:
   ```
   flutter pub get
   ```
3. Run the app:
   ```
   flutter run
   ```

## Architecture

This project follows the MVVM (Model-View-ViewModel) architecture pattern:

- **Model**: Represents the data and business logic
- **View**: The UI components
- **ViewModel**: Connects the Model and View, handling UI logic and state management

## Dependencies

- **flutter_bloc**: State management
- **go_router**: Navigation
- **dio**: HTTP client
- **google_fonts**: Custom fonts
- **fluttertoast**: Toast messages
- **shared_preferences**: Local storage
- **equatable**: Value equality
- **intl**: Internationalization
