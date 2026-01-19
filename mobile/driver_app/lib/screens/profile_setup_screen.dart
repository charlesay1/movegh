import "package:flutter/material.dart";
import "../routes.dart";
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
  String? _vehicleType;
  bool _isLoading = false;

  final List<String> _vehicles = ["Car", "Bike", "Pragya", "Aboboyaa"];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _continue() async {
    final firstName = _firstNameController.text.trim();

    if (firstName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("First name is required")),
      );
      return;
    }

    if (_vehicleType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select a vehicle type")),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) {
      return;
    }
    setState(() => _isLoading = false);
    Navigator.pushReplacementNamed(context, AppRoutes.location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mist,
        elevation: 0,
        title: const Text("Driver profile"),
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
                hintText: "Yaw",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Last name", style: TextStyle(fontWeight: FontWeight.w600)),
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
            const Text("Vehicle type", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _vehicles
                  .map(
                    (vehicle) => ChoiceChip(
                      label: Text(vehicle),
                      selected: _vehicleType == vehicle,
                      onSelected: (selected) {
                        setState(() => _vehicleType = selected ? vehicle : null);
                      },
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),
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
