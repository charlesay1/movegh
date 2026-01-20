@echo off
setlocal

set ROOT=%~dp0\..\..

echo Starting MoveGH backend...
start "MoveGH Backend" cmd /k "cd /d %ROOT%\backend && cmd /c \"npm install\" && cmd /c \"npm run start:dev\""

echo Starting MoveGH Rider (web-server) on port 8080...
start "MoveGH Rider" cmd /k "cd /d %ROOT%\mobile && flutter pub get && flutter run -d web-server --web-port 8080 --dart-define=MOVEGH_API_BASE_URL=http://localhost:3000/v1"

if exist "%ROOT%\mobile\driver_app\pubspec.yaml" (
  echo Starting MoveGH Driver (web-server) on port 8081...
  start "MoveGH Driver" cmd /k "cd /d %ROOT%\mobile\driver_app && flutter pub get && flutter run -d web-server --web-port 8081 --dart-define=MOVEGH_API_BASE_URL=http://localhost:3000/v1"
) else (
  echo Driver app not found at %ROOT%\mobile\driver_app. Skipping.
)

endlocal
