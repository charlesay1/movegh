import "dart:async";
import "package:flutter/material.dart";
import "../models/dispatch_request.dart";
import "../routes.dart";
import "../services/app_services.dart";

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  final List<DispatchRequest> _requests = [];
  Timer? _pollTimer;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchRequests();
    _pollTimer = Timer.periodic(const Duration(seconds: 4), (_) => _fetchRequests());
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  Future<void> _fetchRequests() async {
    try {
      final items = await AppServices.driver.getRequests();
      if (!mounted) {
        return;
      }
      setState(() {
        _requests
          ..clear()
          ..addAll(items);
        _isLoading = false;
        _error = null;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _error = "Unable to fetch requests";
        _isLoading = false;
      });
    }
  }

  Future<void> _accept(DispatchRequest request) async {
    try {
      await AppServices.driver.acceptRequest(request.id);
      if (!mounted) {
        return;
      }
      Navigator.pushNamed(context, AppRoutes.job, arguments: request);
    } catch (_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unable to accept request")),
      );
    }
  }

  Future<void> _reject(DispatchRequest request) async {
    try {
      await AppServices.driver.rejectRequest(request.id);
      if (!mounted) {
        return;
      }
      setState(() => _requests.removeWhere((item) => item.id == request.id));
    } catch (_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unable to reject request")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Incoming Requests")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(child: Text(_error!))
                : _requests.isEmpty
                    ? const Center(child: Text("No requests yet"))
                    : ListView.separated(
                        itemCount: _requests.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final request = _requests[index];
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${request.pickup} → ${request.dropoff}",
                                  style: const TextStyle(fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "${request.mode.toUpperCase()} · ${request.currency} ${request.amount.toStringAsFixed(0)}",
                                  style: const TextStyle(fontSize: 12, color: Color(0xFF475569)),
                                ),
                                if (request.notes != null && request.notes!.isNotEmpty) ...[
                                  const SizedBox(height: 6),
                                  Text(
                                    "Notes: ${request.notes}",
                                    style: const TextStyle(fontSize: 12, color: Color(0xFF475569)),
                                  ),
                                ],
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () => _accept(request),
                                        child: const Text("Accept"),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () => _reject(request),
                                        child: const Text("Reject"),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
      ),
    );
  }
}
