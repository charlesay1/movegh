import "package:flutter/material.dart";
import "routes.dart";
import "screens/current_job_screen.dart";
import "screens/driver_home_screen.dart";
import "screens/otp_verification_screen.dart";
import "screens/phone_screen.dart";
import "screens/requests_screen.dart";
import "screens/splash_screen.dart";

void main() {
  runApp(const DriverApp());
}

class DriverApp extends StatelessWidget {
  const DriverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MoveGH Driver",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0B4E7A)),
      ),
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.phone: (context) => const PhoneScreen(),
        AppRoutes.otp: (context) => const OtpVerificationScreen(),
        AppRoutes.home: (context) => const DriverHomeScreen(),
        AppRoutes.requests: (context) => const RequestsScreen(),
        AppRoutes.job: (context) => const CurrentJobScreen(),
      },
    );
  }
}
