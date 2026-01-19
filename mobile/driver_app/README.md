# MoveGH Driver App (Scaffold)

This folder contains the Driver app scaffold only.

## Run (local)
```bash
flutter pub get
flutter run
```

## Status
- UI scaffold only
- Backend wiring added for auth + dispatch polling

## Web (Windows)
```powershell
flutter run -d web-server --web-port 8081 --dart-define=MOVEGH_API_BASE_URL=http://localhost:3000/v1
```
