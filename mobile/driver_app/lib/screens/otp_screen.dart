import "dart:async";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "../routes.dart";
import "../theme/app_theme.dart";
import "../widgets/primary_button.dart";

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  Timer? _timer;
  int _secondsRemaining = 30;
  bool _isLoading = false;
  String? _phone;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _phone ??= ModalRoute.of(context)?.settings.arguments as String?;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _secondsRemaining = 30);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining <= 1) {
        timer.cancel();
        setState(() => _secondsRemaining = 0);
      } else {
        setState(() => _secondsRemaining -= 1);
      }
    });
  }

  Future<void> _verify() async {
    final code = _otpController.text.trim();
    if (code.length < 4 || code.length > 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter the 4-6 digit code")),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) {
      return;
    }
    setState(() => _isLoading = false);
    Navigator.pushReplacementNamed(context, AppRoutes.profile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mist,
        elevation: 0,
        title: const Text("Verify code"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter the code sent to ${_phone ?? "your phone"}",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              autofocus: true,
              maxLength: 6,
              decoration: const InputDecoration(
                hintText: "1234",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderSide: BorderSide.none),
                counterText: "",
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: _secondsRemaining == 0 && !_isLoading ? _startTimer : null,
                child: Text(
                  _secondsRemaining == 0
                      ? "Resend code"
                      : "Resend in 00:${_secondsRemaining.toString().padLeft(2, '0')}",
                ),
              ),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              label: _isLoading ? "Verifying..." : "Continue",
              isLoading: _isLoading,
              onPressed: _isLoading ? null : _verify,
            ),
          ],
        ),
      ),
    );
  }
}
