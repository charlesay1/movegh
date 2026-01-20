# MoveGH Virtual Test Platform

This folder provides a repeatable local test setup that runs Backend + Rider + Driver together on Windows.

## Prereqs
- Node.js (18+)
- Flutter SDK
- Git

## One-command start (Windows)
Run this from PowerShell or CMD:
```cmd
tools\test_platform\start_all_windows.cmd
```

This will open separate windows for:
- Backend (port 3000)
- Rider web-server (port 8080)
- Driver web-server (port 8081) if `mobile\driver_app` exists

## Smoke tests (Windows)
```cmd
tools\test_platform\smoke_test_windows.cmd
```

## Dashboard
Open the static dashboard in a browser:
```
file:///C:/Users/ckora/movegh/tools/test_platform/dashboard/index.html
```

## Troubleshooting
- If ports are in use, stop the previous process or pick a new port.
- If npm is blocked by PowerShell policy, the start script uses `cmd /c`.
- If Driver app is missing, the driver window will be skipped.
