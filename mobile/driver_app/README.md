# MoveGH Driver App (Scaffold)

This is the driver-facing Flutter app scaffold for MoveGH.

## Run backend (NestJS)
From `/home/charlesay/movegh/backend`:
```bash
npm install
npm run start:dev
```
Default port: `http://127.0.0.1:3000`
If running the Android emulator, set `baseUrl` to `http://10.0.2.2:3000`.

## Run driver app
From `/home/charlesay/movegh/mobile/driver_app`:
```bash
flutter pub get
flutter run
```

## Toggle mock fallback
Edit `lib/app_config.dart`:
```dart
static bool useMock = true; // set to false to hit backend
```

## What to test (happy path)
1) Phone → OTP → Profile → Location → Home
2) Toggle Online → should fetch an incoming request
3) Accept/Reject updates the card state
