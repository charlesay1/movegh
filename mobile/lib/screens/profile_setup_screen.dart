import "package:flutter/material.dart";
import "../routes.dart";
import "../services/app_services.dart";
import "../services/session_store.dart";
import "../theme/app_theme.dart";
import "../widgets/primary_button.dart";

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _acceptTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _continue() async {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final email = _emailController.text.trim();

    if (firstName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("First name is required")),
      );
      return;
    }

    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Accept Terms & Privacy to continue")),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await AppServices.users.updateProfile(
        firstName: firstName,
        lastName: lastName.isEmpty ? null : lastName,
        email: email.isEmpty ? null : email,
      );
      final session = await SessionStore.instance();
      await session.saveProfile(
        firstName: firstName,
        lastName: lastName.isEmpty ? null : lastName,
        email: email.isEmpty ? null : email,
      );
      if (!mounted) {
        return;
      }
      Navigator.pushReplacementNamed(context, AppRoutes.location);
    } catch (_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unable to save profile. Try again.")),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mist,
        elevation: 0,
        title: const Text("Set up your profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("First name", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                hintText: "Ama",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Last name (optional)", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                hintText: "Mensah",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Email (optional)", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "ama@movegh.com",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _acceptTerms,
                  onChanged: (value) => setState(() => _acceptTerms = value ?? false),
                ),
                const Expanded(
                  child: Text("I accept the Terms & Privacy"),
                ),
              ],
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              label: _isLoading ? "Saving..." : "Continue",
              isLoading: _isLoading,
              onPressed: _isLoading ? null : _continue,
            ),
          ],
        ),
      ),
    );
  }
}
