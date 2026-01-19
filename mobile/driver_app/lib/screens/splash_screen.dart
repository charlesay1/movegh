import "package:flutter/material.dart";
import "../routes.dart";
import "../services/app_services.dart";
import "../services/session_store.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _redirect());
  }

  Future<void> _redirect() async {
    final session = await SessionStore.instance();
    if (!mounted) {
      return;
    }
    final token = session.token;
    if (token != null && token.isNotEmpty) {
      AppServices.apiClient.setToken(token);
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.phone);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
