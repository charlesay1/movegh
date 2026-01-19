# Run MoveGH on Windows

This repo contains the Flutter app at `mobile/`. The VM cannot run a web server, so use Windows for the live demo.

Platform overview: docs/PLATFORM_STRATEGY.md

## Option A: Run locally with Flutter (recommended)

### 1) Install Flutter (minimal)
1. Download Flutter SDK zip from https://flutter.dev/docs/get-started/install/windows
2. Extract to `C:\src\flutter`
3. Add Flutter to PATH (PowerShell):
   ```powershell
   setx PATH "$env:PATH;C:\src\flutter\bin"
   ```
4. Open a new PowerShell and run:
   ```powershell
   flutter doctor
   ```

### 2) Get the code
```powershell
git clone https://github.com/charlesay1/movegh.git
cd movegh\mobile
```

### 3) Fetch deps
```powershell
flutter pub get
```

### 4) Run on Web (Chrome)
```powershell
flutter config --enable-web
flutter run -d chrome
```

### 5) Run on Android Emulator (optional)
1. Install Android Studio + Android SDK
2. In Android Studio, install a system image and create an emulator
3. Accept licenses:
   ```powershell
   flutter doctor --android-licenses
   ```
4. Run the app:
   ```powershell
   flutter emulators
   flutter emulators --launch <emulator_id>
   flutter devices
   flutter run -d <device_id>
   ```

## Option B: Use the prebuilt web artifact
1. Download `movegh_web_build.tgz` from the VM (see scp command below).
2. Extract:
   ```powershell
   tar -xzf movegh_web_build.tgz
   ```
3. Serve locally:
   ```powershell
   python -m http.server 8080
   ```
4. Open in a browser:
   ```
   http://localhost:8080/
   ```

## SCP download from VM
```powershell
scp charlesay@192.168.1.10:/home/charlesay/movegh/mobile/movegh_web_build.tgz .
```
