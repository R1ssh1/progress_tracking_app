# Progress Tracker

A beautiful and customizable Flutter app for tracking daily goals and building positive habits. Track your progress with a points-based system and beautiful pastel themes.

## Features

### 🎯 Task Management
- **Create Custom Tasks**: Add tasks with custom names, descriptions, and point values
- **Flexible Frequency**: Set tasks to repeat daily, every few days, weekly, or monthly
- **Categories**: Organize tasks by categories (Health, Work, Learning, etc.)
- **Point System**: Each task has a point value that contributes to your daily progress

### 📊 Progress Tracking
- **Daily Goals**: Set and track daily point goals
- **Progress Overview**: Visual progress bars and completion rates
- **Streak Tracking**: Monitor your consistency with streak counters
- **Statistics**: View detailed statistics and performance metrics

### 🎨 Customizable Themes
- **6 Predefined Themes**: Choose from beautiful pastel themes:
  - Lavender Dreams
  - Mint Fresh
  - Peach Sunset
  - Sky Blue
  - Rose Gold
  - Sage Green
- **Aesthetic Design**: Modern, clean UI with smooth animations
- **Responsive Layout**: Works perfectly on all screen sizes

### 📱 User Experience
- **Intuitive Interface**: Easy-to-use navigation with bottom tabs
- **Swipe Actions**: Swipe tasks to pause, activate, or delete them
- **Real-time Updates**: Instant feedback and progress updates
- **Offline Support**: All data is stored locally on your device

## Screenshots

The app features three main sections:

1. **Today Tab**: View today's available tasks, completed tasks, and progress overview
2. **All Tasks Tab**: Browse all tasks organized by categories
3. **Stats Tab**: View detailed statistics and recent activity

## Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- Android device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd progress_tracker
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building for Android

1. **Build APK**
   ```bash
   flutter build apk
   ```

2. **Build App Bundle (for Play Store)**
   ```bash
   flutter build appbundle
   ```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── task.dart            # Task data model
├── providers/
│   └── task_provider.dart   # State management
├── screens/
│   ├── home_screen.dart     # Main home screen
│   ├── add_task_screen.dart # Add/edit task screen
│   └── settings_screen.dart # Settings and theme selection
├── theme/
│   └── app_theme.dart       # Theme definitions
└── widgets/
    ├── task_card.dart       # Task display widget
    ├── progress_overview.dart # Progress display widget
    └── empty_state.dart     # Empty state widget
```

## Dependencies

- **provider**: State management
- **shared_preferences**: Local data storage
- **intl**: Date formatting and localization
- **flutter_slidable**: Swipe actions for tasks

## Usage Guide

### Adding Tasks
1. Tap the "+" button on the home screen
2. Fill in the task details:
   - **Name**: What you want to accomplish
   - **Description**: Optional details about the task
   - **Points**: How many points this task is worth
   - **Category**: Group similar tasks together
   - **Frequency**: How often you want to do this task
3. Tap "Add Task" to save

### Completing Tasks
- Tap the checkmark icon next to available tasks
- Tasks can only be completed once per day (or according to their frequency)
- Points are automatically added to your daily total

### Customizing Themes
1. Go to Settings (gear icon in the app bar)
2. Scroll to the "Appearance" section
3. Tap on any theme to apply it instantly

### Setting Daily Goals
1. Go to Settings
2. Scroll to the "Goals" section
3. Enter your desired daily point goal
4. The goal will be saved automatically

## Features for Future Updates

- [ ] Dark mode support
- [ ] Cloud sync and backup
- [ ] Reminders and notifications
- [ ] Data export/import
- [ ] Advanced analytics and charts
- [ ] Social features and sharing
- [ ] Custom themes creation
- [ ] Widget support for home screen

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

If you encounter any issues or have suggestions for improvements, please open an issue on the repository.

---

**Made with ❤️ using Flutter**
