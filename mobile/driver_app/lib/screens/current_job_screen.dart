import "package:flutter/material.dart";
import "../models/dispatch_request.dart";

class CurrentJobScreen extends StatelessWidget {
  const CurrentJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final request = ModalRoute.of(context)?.settings.arguments as DispatchRequest?;
    if (request == null) {
      return const Scaffold(
        body: Center(child: Text("No active job")),
      );
    }

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
            const Text("Status", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            _StatusStep(label: "Assigned", isActive: true),
            _StatusStep(label: "Arrived", isActive: false),
            _StatusStep(label: "In trip", isActive: false),
            _StatusStep(label: "Complete", isActive: false),
            const Spacer(),
            const Text(
              "Status updates are placeholders until backend provides driver job state.",
              style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
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
