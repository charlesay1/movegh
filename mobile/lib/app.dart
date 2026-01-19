import "package:flutter/material.dart";
import "routes.dart";
import "screens/delivery_screen.dart";
import "screens/home_screen.dart";
import "screens/location_permission_screen.dart";
import "screens/login_screen.dart";
import "screens/otp_verification_screen.dart";
import "screens/profile_setup_screen.dart";
import "screens/ride_request_screen.dart";
import "screens/splash_screen.dart";
import "screens/tracking_screen.dart";
import "services/app_services.dart";
import "state/ride_flow_controller.dart";
import "state/ride_flow_scope.dart";
import "theme/app_theme.dart";

class MoveGHApp extends StatefulWidget {
  const MoveGHApp({super.key});

  @override
  State<MoveGHApp> createState() => _MoveGHAppState();
}

class _MoveGHAppState extends State<MoveGHApp> {
  late final RideFlowController _rideFlowController;

  @override
  void initState() {
    super.initState();
    _rideFlowController = RideFlowController(AppServices.rides);
  }

  @override
  void dispose() {
    _rideFlowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RideFlowScope(
      controller: _rideFlowController,
      child: MaterialApp(
        title: "MoveGH",
        theme: buildAppTheme(),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.welcome,
        routes: {
          AppRoutes.welcome: (context) => const SplashScreen(),
          AppRoutes.phone: (context) => const LoginScreen(),
          AppRoutes.otp: (context) => const OtpVerificationScreen(),
          AppRoutes.profile: (context) => const ProfileSetupScreen(),
          AppRoutes.location: (context) => const LocationPermissionScreen(),
          AppRoutes.home: (context) => const HomeScreen(),
          AppRoutes.rideRequest: (context) => const RideRequestScreen(),
          AppRoutes.delivery: (context) => const DeliveryScreen(),
          AppRoutes.tracking: (context) => const TrackingScreen(),
        },
      ),
    );
  }
}
