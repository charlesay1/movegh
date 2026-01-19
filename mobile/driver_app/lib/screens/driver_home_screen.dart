import "package:flutter/material.dart";
import "../app_config.dart";
import "../routes.dart";
import "../services/app_services.dart";
import "../services/session_store.dart";

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  bool _isOnline = false;
  bool _isLoading = false;
  String _healthLabel = "Checking...";

  @override
  void initState() {
    super.initState();
    _checkBackend();
  }

  Future<void> _checkBackend() async {
    try {
      await AppServices.apiClient.getJson("/health");
      if (mounted) {
        setState(() => _healthLabel = "Backend reachable");
      }
    } catch (_) {
      if (mounted) {
        setState(() => _healthLabel = "Backend unreachable");
      }
    }
  }

  Future<void> _toggleOnline(bool value) async {
    setState(() {
      _isOnline = value;
      _isLoading = true;
    });
    try {
      final session = await SessionStore.instance();
      final driverId = session.phone ?? "driver_001";
      await AppServices.driver.setStatus(driverId: driverId, online: value);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Unable to update status")),
        );
      }
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
        title: const Text("Driver Home"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.requests),
            child: const Text("Requests"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "API: ${AppConfig.apiBaseUrl}",
                    style: const TextStyle(fontSize: 11, color: Color(0xFF475569)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _healthLabel,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Status", style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      Text(
                        _isOnline ? "Online" : "Offline",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: _isOnline ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
                        ),
                      ),
                    ],
                  ),
                  Switch(
                    value: _isOnline,
                    onChanged: _isLoading ? null : _toggleOnline,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.requests),
                child: const Text("View Incoming Requests"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
