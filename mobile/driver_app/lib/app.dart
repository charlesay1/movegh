import "package:flutter/material.dart";
import "routes.dart";
import "screens/home_screen.dart";
import "screens/location_permission_screen.dart";
import "screens/otp_screen.dart";
import "screens/phone_screen.dart";
import "screens/profile_setup_screen.dart";
import "screens/welcome_screen.dart";
import "theme/app_theme.dart";

class MoveGHDriverApp extends StatelessWidget {
  const MoveGHDriverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MoveGH Driver",
      theme: buildAppTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.welcome,
      routes: {
        AppRoutes.welcome: (context) => const WelcomeScreen(),
        AppRoutes.phone: (context) => const PhoneScreen(),
        AppRoutes.otp: (context) => const OtpScreen(),
        AppRoutes.profile: (context) => const ProfileSetupScreen(),
        AppRoutes.location: (context) => const LocationPermissionScreen(),
        AppRoutes.home: (context) => const DriverHomeScreen(),
      },
    );
  }
}
