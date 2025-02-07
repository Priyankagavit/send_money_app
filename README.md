# Send Money App

A Flutter mobile application for sending money and tracking transactions with offline support.

## Features

- User Authentication (Login/Logout)
- Wallet Balance Management
- Send Money Functionality
- Transaction History
- Offline Support
- Persistent Data Storage

## Prerequisites

Before you begin, ensure you have met the following requirements:
- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code
- iOS Simulator / Android Emulator

## Installation

1. Clone the repository:
```bash
git clone https://github.com/Priyankagavit/send_money_app
cd send_money_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```
## Design Diagram
```
documentation/
├── class_diagram.jpg
└── sequence_diagram.jpg
```
## Project Structure

```
lib/
├── main.dart
├── ui/
│   ├── login.dart
│   ├── dashboard.dart
│   ├── send_money.dart
│   └── transaction.dart
├── bloc/
│   ├── user_bloc.dart
│   ├── user_event.dart
│   └── user_state.dart
├── models/
│   └── transaction_model.dart
└── services/
    ├── connectivity_service.dart
    └── transaction_storage_service.dart
```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5
  dio: ^5.3.2
  shared_preferences: ^2.2.0
  flutter_secure_storage: ^8.0.0
  connectivity_plus: ^4.0.2
  provider: ^6.1.2
```

## Usage

### Login
- Default credentials:
    - Username: user
    - Password: pass

### Dashboard
- View wallet balance
- Toggle balance visibility
- Access Send Money and Transaction History features

### Send Money
- Enter amount to send
- Confirm transaction
- View success/failure message

### Transaction History
- View all past transactions
- Transaction details include:
    - Amount
    - Date
    - Transaction ID
    - Transaction Type

## Offline Support

The app features offline support with the following capabilities:
- Cached transaction history
- Stored wallet balance
- Automatic sync when back online
- Visual offline mode indicator

## State Management

The app uses Flutter Bloc for state management with the following features:
- Centralized state management
- Persistent storage integration
- Network connectivity handling
- Error handling

## Services

### ConnectivityService
Handles network connectivity monitoring:
- Real-time connection status
- Connection type detection
- Connection change notifications

### TransactionStorageService
Manages local data persistence:
- Transaction history storage
- Balance information
- User preferences

## Contributing

1. Fork the repository
2. Create your feature branch:
```bash
git checkout -b feature/YourFeature
```
3. Commit your changes:
```bash
git commit -m 'Add some feature'
```
4. Push to the branch:
```bash
git push origin feature/YourFeature
```
5. Open a Pull Request

## Error Handling

The app includes comprehensive error handling for:
- Network failures
- Storage errors
- Invalid transactions
- Authentication issues

## Future Improvements

- Biometric authentication
- Multiple currency support
- Transaction categories
- Push notifications
- Transaction search and filtering
- Data encryption
- Unit and widget tests
- UI/UX improvements

## Testing

Run tests using:
```bash
flutter test
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support, email priyankagavit0712@gmail.com or create an issue in the repository.

## Acknowledgments

- Flutter Team
- Bloc Library
- Flutter Community