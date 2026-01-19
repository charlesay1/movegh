# MoveGH Platform Architecture

## Platform targets
- iOS (rider app)
- Android (rider app)
- iPad (same iOS app with tablet layouts)
- Web (admin portal)

## Recommended app split
- Rider app (Flutter): customer booking and payments.
- Driver app (Flutter): driver workflow, accept rides, navigation, earnings.
- Admin portal (Flutter Web or React): operations, support, analytics.

## Why split the apps
- Permissions differ (driver location updates vs rider location search).
- UX and workflows are different (driver-only features vs rider-only features).
- Separate store listings for rider vs driver.
- KYC and compliance flows are not the same for drivers and riders.

## Recommended repo layout (no moves yet)
- /mobile/rider_app
- /mobile/driver_app
- /admin_web
- /backend

## Android build setup notes (VM)
- Android SDK: `/home/charlesay/Android/Sdk`
- Required env vars (add to `~/.bashrc`):
  - `ANDROID_HOME=/home/charlesay/Android/Sdk`
  - `ANDROID_SDK_ROOT=/home/charlesay/Android/Sdk`
  - `PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools`
- Required packages: `openjdk-17-jdk`, `unzip`, `zip`, `curl`, `git`, `xz-utils`, `libglu1-mesa`
- Flutter can build APKs from `mobile/` using `flutter build apk`.
