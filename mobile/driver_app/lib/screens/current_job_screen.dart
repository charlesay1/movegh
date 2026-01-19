import "dart:async";
import "package:flutter/material.dart";
import "../models/dispatch_request.dart";
import "../services/app_services.dart";

class CurrentJobScreen extends StatefulWidget {
  const CurrentJobScreen({super.key});

  @override
  State<CurrentJobScreen> createState() => _CurrentJobScreenState();
}

class _CurrentJobScreenState extends State<CurrentJobScreen> {
  DispatchRequest? _request;
  String _status = "assigned";
  bool _isUpdating = false;
  Timer? _pollTimer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_request == null) {
      _request = ModalRoute.of(context)?.settings.arguments as DispatchRequest?;
      _status = _request?.status ?? "assigned";
      _refreshStatus();
      _pollTimer = Timer.periodic(const Duration(seconds: 4), (_) => _refreshStatus());
    }
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  Future<void> _refreshStatus() async {
    final request = _request;
    if (request == null) {
      return;
    }
    try {
      final latest = await AppServices.driver.getRequest(request.id);
      if (latest != null && mounted) {
        setState(() {
          _request = latest;
          _status = latest.status ?? _status;
        });
      }
    } catch (_) {
      // Ignore poll errors; user can still advance manually.
    }
  }

  int _statusIndex(String status) {
    const order = ["assigned", "arrived", "in_trip", "completed"];
    final index = order.indexOf(status);
    return index == -1 ? 0 : index;
  }

  Future<void> _advance(Future<Map<String, dynamic>> Function(String) action) async {
    final request = _request;
    if (request == null) {
      return;
    }
    setState(() => _isUpdating = true);
    try {
      final response = await action(request.id);
      final next = response["status"]?.toString();
      if (mounted && next != null) {
        setState(() => _status = next);
      }
    } finally {
      if (mounted) {
        setState(() => _isUpdating = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = _request;
    if (request == null) {
      return const Scaffold(
        body: Center(child: Text("No active job")),
      );
    }

    final statusIndex = _statusIndex(_status);
    return Scaffold(
      appBar: AppBar(title: const Text("Current Job")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${request.pickup} → ${request.dropoff}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              "${request.mode.toUpperCase()} · ${request.currency} ${request.amount.toStringAsFixed(0)}",
              style: const TextStyle(fontSize: 12, color: Color(0xFF475569)),
            ),
            if (request.notes != null && request.notes!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                "Notes: ${request.notes}",
                style: const TextStyle(fontSize: 12, color: Color(0xFF475569)),
              ),
            ],
            const SizedBox(height: 20),
            Text("Status: ${_status.replaceAll('_', ' ')}"),
            const SizedBox(height: 8),
            _StatusStep(label: "Assigned", isActive: statusIndex >= 0),
            _StatusStep(label: "Arrived", isActive: statusIndex >= 1),
            _StatusStep(label: "In trip", isActive: statusIndex >= 2),
            _StatusStep(label: "Complete", isActive: statusIndex >= 3),
            const Spacer(),
            if (_status == "assigned")
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isUpdating
                      ? null
                      : () => _advance(AppServices.driver.arriveRequest),
                  child: Text(_isUpdating ? "Updating..." : "Mark Arrived"),
                ),
              )
            else if (_status == "arrived")
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isUpdating
                      ? null
                      : () => _advance(AppServices.driver.startTrip),
                  child: Text(_isUpdating ? "Updating..." : "Start Trip"),
                ),
              )
            else if (_status == "in_trip")
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isUpdating
                      ? null
                      : () => _advance(AppServices.driver.completeTrip),
                  child: Text(_isUpdating ? "Updating..." : "Complete Trip"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _StatusStep extends StatelessWidget {
  const _StatusStep({required this.label, required this.isActive});

  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            isActive ? Icons.radio_button_checked : Icons.radio_button_off,
            color: isActive ? const Color(0xFF16A34A) : const Color(0xFF94A3B8),
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}
