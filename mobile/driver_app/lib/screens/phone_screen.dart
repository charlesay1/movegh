import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "../routes.dart";
import "../theme/app_theme.dart";
import "../widgets/primary_button.dart";

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;
  String? _errorText;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  String? _validateGhanaNumber(String value) {
    if (value.length != 9) {
      return "Enter a 9-digit number";
    }
    final prefix = value.substring(0, 2);
    const validPrefixes = {
      "24",
      "54",
      "55",
      "59", // MTN
      "20",
      "50", // Vodafone
      "26",
      "56",
      "27",
      "57", // AirtelTigo
    };
    if (!validPrefixes.contains(prefix)) {
      return "Use MTN, Vodafone, or AirtelTigo";
    }
    return null;
  }

  Future<void> _sendCode() async {
    final raw = _phoneController.text.replaceAll(RegExp(r"\D"), "");
    final error = _validateGhanaNumber(raw);
    setState(() => _errorText = error);
    if (error != null) {
      return;
    }

    final phone = "+233$raw";
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) {
      return;
    }
    setState(() => _isLoading = false);
    Navigator.pushReplacementNamed(context, AppRoutes.otp, arguments: phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mist,
        elevation: 0,
        title: const Text("Verify your number"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Phone number", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "+233",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 9,
                    decoration: InputDecoration(
                      hintText: "24 000 0000",
                      errorText: _errorText,
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(borderSide: BorderSide.none),
                      counterText: "",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              label: _isLoading ? "Sending..." : "Send verification code",
              isLoading: _isLoading,
              onPressed: _isLoading ? null : _sendCode,
            ),
          ],
        ),
      ),
    );
  }
}
