import "package:flutter/material.dart";
import "../routes.dart";
import "../services/session_store.dart";
import "../theme/app_theme.dart";
import "../widgets/primary_button.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _redirectIfNeeded());
  }

  Future<void> _redirectIfNeeded() async {
    final session = await SessionStore.instance();
    if (!mounted || !session.isLoggedIn) {
      return;
    }

    if (!session.isProfileComplete) {
      Navigator.pushReplacementNamed(context, AppRoutes.profile);
      return;
    }

    if (!session.isLocationPrompted) {
      Navigator.pushReplacementNamed(context, AppRoutes.location);
      return;
    }

    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.navy, Color(0xFF0B1E34)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: AppColors.lime,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(Icons.arrow_forward, color: AppColors.navy),
              ),
              const SizedBox(height: 16),
              const Text(
                "MoveGH",
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              const Text(
                "Ghana in Motion",
                style: TextStyle(color: Color(0xB3FFFFFF), letterSpacing: 2),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: PrimaryButton(
                  label: "Continue with phone number",
                  onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.phone),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
