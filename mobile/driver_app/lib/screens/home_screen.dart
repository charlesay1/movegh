import "dart:async";
import "package:flutter/material.dart";
import "../models/driver_request.dart";
import "../services/app_services.dart";
import "../theme/app_theme.dart";
import "../widgets/primary_button.dart";

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  bool _isOnline = false;
  DriverRequest? _currentRequest;
  Timer? _poller;
  bool _isUpdatingStatus = false;

  @override
  void dispose() {
    _poller?.cancel();
    super.dispose();
  }

  Future<void> _toggleOnline(bool value) async {
    setState(() => _isUpdatingStatus = true);
    try {
      await AppServices.dispatch.setStatus(online: value);
      if (!mounted) {
        return;
      }
      setState(() {
        _isOnline = value;
        _isUpdatingStatus = false;
        if (!value) {
          _currentRequest = null;
        }
      });
      if (value) {
        _startPolling();
      } else {
        _poller?.cancel();
      }
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() => _isUpdatingStatus = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not update status: $error")),
      );
    }
  }

  void _startPolling() {
    _poller?.cancel();
    _poller = Timer.periodic(const Duration(seconds: 4), (_) async {
      if (!_isOnline) {
        return;
      }
      try {
        final request = await AppServices.dispatch.fetchCurrentRequest();
        if (!mounted) {
          return;
        }
        if (request == null) {
          return;
        }
        setState(() => _currentRequest = request);
      } catch (error) {
        if (!mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Dispatch error: $error")),
        );
      }
    });
  }

  Future<void> _acceptRequest() async {
    final request = _currentRequest;
    if (request == null) {
      return;
    }
    try {
      await AppServices.dispatch.acceptRequest(request.id);
      if (!mounted) {
        return;
      }
      setState(() => _currentRequest = null);
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not accept: $error")),
      );
    }
  }

  Future<void> _rejectRequest() async {
    final request = _currentRequest;
    if (request == null) {
      return;
    }
    try {
      await AppServices.dispatch.rejectRequest(request.id);
      if (!mounted) {
        return;
      }
      setState(() => _currentRequest = null);
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not reject: $error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Driver Home"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              color: const Color(0xFFF8FAFC),
            ),
            child: Text(
              _isOnline ? "Online" : "Offline",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: _isOnline ? AppColors.ghanaGreen : AppColors.ghanaRed,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(color: Color(0x140A2540), blurRadius: 16, offset: Offset(0, 8)),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isOnline ? "You are online" : "You are offline",
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _isOnline
                            ? "Ready for incoming requests"
                            : "Go online to start receiving jobs",
                        style: const TextStyle(color: Color(0xFF64748B)),
                      ),
                    ],
                  ),
                ),
                Transform.scale(
                  scale: 1.3,
                  child: Switch(
                    value: _isOnline,
                    onChanged: _isUpdatingStatus ? null : _toggleOnline,
                    activeColor: AppColors.ghanaGreen,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(color: Color(0x140A2540), blurRadius: 16, offset: Offset(0, 8)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Incoming Request",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(height: 12),
                if (_currentRequest == null)
                  const Text("No active requests right now.")
                else ...[
                  Text("Pickup: ${_currentRequest!.pickup}"),
                  Text("Dropoff: ${_currentRequest!.dropoff}"),
                  const SizedBox(height: 8),
                  Text(
                    "Fare: GHS ${_currentRequest!.fareGhs.toStringAsFixed(2)} • "
                    "ETA: ${_currentRequest!.etaMinutes} min",
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          label: "Accept",
                          onPressed: _acceptRequest,
                          backgroundColor: AppColors.ghanaGreen,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: PrimaryButton(
                          label: "Reject",
                          onPressed: _rejectRequest,
                          backgroundColor: AppColors.ghanaRed,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(color: Color(0x140A2540), blurRadius: 16, offset: Offset(0, 8)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Earnings summary",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Expanded(
                      child: _EarningItem(label: "Today", value: "GHS 180"),
                    ),
                    Expanded(
                      child: _EarningItem(label: "This week", value: "GHS 920"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EarningItem extends StatelessWidget {
  const _EarningItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF64748B))),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
      ],
    );
  }
}
