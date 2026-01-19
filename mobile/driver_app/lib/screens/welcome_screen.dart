import "package:flutter/material.dart";
import "../routes.dart";
import "../theme/app_theme.dart";
import "../widgets/primary_button.dart";

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
                child: const Icon(Icons.local_taxi, color: AppColors.navy),
              ),
              const SizedBox(height: 16),
              const Text(
                "MoveGH Driver",
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              const Text(
                "Drive Ghana Forward",
                style: TextStyle(color: Color(0xB3FFFFFF), letterSpacing: 1.6),
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
