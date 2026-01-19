import "package:flutter/material.dart";
import "../routes.dart";
import "../theme/app_theme.dart";
import "../widgets/primary_button.dart";

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key});

  void _continue(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mist,
        elevation: 0,
        title: const Text("Enable location"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "We use your location to match you with nearby rider requests.",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            const Text(
              "You can change this later in Settings.",
              style: TextStyle(color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: "Allow location",
              onPressed: () => _continue(context),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => _continue(context),
              child: const Text("Not now"),
            ),
          ],
        ),
      ),
    );
  }
}
