# Omedia Payment App

A Flutter mobile application for managing payment obligations, including gold and other payment types. The app provides a dashboard view, detailed payment breakdowns, and PDF transaction viewing capabilities.

## Features

- **Dashboard**: Overview of payment obligations and balances
- **Gold Payments**: Detailed view and management of gold-related obligations
- **Other Payments**: Management of various other payment types
- **PDF Viewer**: View transaction documents in PDF format
- **Payment Breakdown**: Detailed breakdown of payment components

## Prerequisites

Before running this app, ensure you have the following installed:

- **Flutter SDK** (version 3.7.2 or higher)
- **Dart SDK** (included with Flutter)
- **Android Studio** or **VS Code** with Flutter extensions
- **Android SDK** (for Android development)
- **Xcode** (for iOS development, macOS only)

## How to Run the App

### 1. Clone the Repository

```bash
git clone https://github.com/Annaano/omedia
cd omedia
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run the App

#### For Development

```bash
flutter run
```

#### For Specific Platforms

```bash
# Android
flutter run -d android

# iOS (macOS only)
flutter run -d ios

```

### 4. Build for Production

#### Android APK

```bash
flutter build apk --release
```

#### iOS (requires macOS and Xcode)

```bash
flutter build ios --release
```

## Architecture

This app follows the **BLoC (Business Logic Component)** pattern for state management:

- **Data Layer**: Models, API providers, and repositories
- **Logic Layer**: BLoCs for state management
- **Presentation Layer**: UI screens and widgets

## Dependencies

### Core Dependencies

- `flutter_bloc`: State management
- `dio`: HTTP client for API calls
- `flutter_svg`: SVG icon support
- `google_fonts`: Typography
- `syncfusion_flutter_pdfviewer`: PDF viewing
- `intl`: Internationalization and formatting

### Development Dependencies

- `flutter_lints`: Code quality and linting

## API Configuration

The app connects to a mock API at `https://f1-mock.omedialab.com/api` with the following endpoints:

- `/obligations/gold` - Gold obligations data
- `/obligations/other` - Other obligations data
- `/obligations/transactions` - Transaction data and PDFs

## Assumptions Made

1. **API Availability**: The app assumes the mock API endpoints are always available and return expected data formats.

2. **Network Connectivity**: The app assumes stable internet connectivity for API calls.

3. **Data Format**: API responses are expected to follow a specific structure defined in the model classes.

4. **PDF Handling**: PDF files are assumed to be accessible via the API and viewable in the app.

5. **Device Compatibility**: The app is designed for modern mobile devices with adequate screen sizes.

## Known Issues and Trade-offs

### Current Limitations

1. **Error Handling**: Basic error handling with console logging; user-facing error messages could be improved.

2. **Offline Support**: No offline functionality - requires internet connection for all data.

3. **Loading States**: Limited loading indicators during API calls.

4. **Data Caching**: No local data persistence or caching mechanism.

### Trade-offs

1. **Mock API**: Using a mock API means the app doesn't connect to real payment systems, limiting testing of actual payment flows.

2. **State Management**: BLoC pattern adds complexity but provides better state management for larger apps.

## Development Notes

- The app uses custom fonts (HelveticaNeue) and SVG icons
- API timeouts are set to 30 seconds for all requests
- The app follows Flutter's recommended project structure

## Troubleshooting

### Common Issues

1. **Dependencies not found**: Run `flutter pub get` to install dependencies
2. **API connection errors**: Check internet connectivity and API endpoint availability
3. **Build errors**: Ensure Flutter SDK version matches the project requirements
4. **iOS build issues**: Make sure Xcode is properly configured and iOS deployment target is set

### Getting Help

If you encounter issues:

1. Check the Flutter documentation
2. Review the console logs for error messages
3. Ensure all prerequisites are properly installed
4. Try cleaning and rebuilding: `flutter clean && flutter pub get`
