import "dart:async";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "../routes.dart";
import "../services/app_services.dart";
import "../services/session_store.dart";

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
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

  Future<void> _resendCode() async {
    final phone = _phone;
    if (phone == null) {
      return;
    }
    setState(() => _isLoading = true);
    try {
      await AppServices.auth.requestOtp(phone);
      if (!mounted) {
        return;
      }
      _startTimer();
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _verifyCode() async {
    final phone = _phone;
    if (phone == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Missing phone number")),
      );
      return;
    }

    final code = _otpController.text.trim();
    if (code.length < 4 || code.length > 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter the 4-6 digit code")),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final response = await AppServices.auth.verifyOtp(phone, code);
      final token = response["token"]?.toString();
      if (token == null || token.isEmpty) {
        throw Exception("Missing session token");
      }
      final session = await SessionStore.instance();
      await session.setSession(token: token, phone: phone);
      AppServices.apiClient.setToken(token);
      if (!mounted) {
        return;
      }
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } catch (_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid code. Try again.")),
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
      appBar: AppBar(title: const Text("Verify code")),
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
                onPressed: _secondsRemaining == 0 && !_isLoading ? _resendCode : null,
                child: Text(
                  _secondsRemaining == 0
                      ? "Resend code"
                      : "Resend in 00:${_secondsRemaining.toString().padLeft(2, '0')}",
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _verifyCode,
                child: Text(_isLoading ? "Verifying..." : "Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
