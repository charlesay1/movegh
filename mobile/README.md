# MoveGH Mobile App (Scaffold)

This folder contains a Flutter UI scaffold aligned to the approved MoveGH UI preview.

## Structure
- lib/app.dart: App routes and theme wiring.
- lib/screens: Splash, login, home, ride request, delivery, tracking.
- lib/widgets: UI components (toggle, mode option, where-to input).
- lib/services: API client stubs.
- lib/models: Basic request/response models.

## Notes
- Flutter SDK is not installed in this environment.
- Run `flutter create .` to generate the native project folders (android/ios/web) and then keep the `lib/` content.
- API calls use mock responses by default. Toggle `AppConfig.useMock` in `lib/config/app_config.dart`.

## Next Steps
- Run `flutter pub get` to install dependencies.
- Connect screens to live API endpoints.
- Add state management and location services.
