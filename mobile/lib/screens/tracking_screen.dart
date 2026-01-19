import "package:flutter/material.dart";
import "../state/ride_flow_controller.dart";
import "../state/ride_flow_scope.dart";
import "../theme/app_theme.dart";

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = RideFlowScope.of(context);
      if (controller.hasActiveRide) {
        controller.startPolling();
      }
    });
  }

  @override
  void dispose() {
    final controller = RideFlowScope.of(context);
    controller.stopPolling();
    super.dispose();
  }

  String _phaseLabel(RidePhase phase) {
    switch (phase) {
      case RidePhase.requested:
        return "Searching for driver";
      case RidePhase.assigned:
        return "Driver assigned";
      case RidePhase.arrived:
        return "Driver arrived";
      case RidePhase.inProgress:
        return "Trip in progress";
      case RidePhase.completed:
        return "Trip completed";
      case RidePhase.cancelled:
        return "Trip cancelled";
      case RidePhase.estimating:
      case RidePhase.requesting:
        return "Processing";
      default:
        return "Pending";
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = RideFlowScope.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final status = controller.status;
        if (!controller.hasActiveRide) {
          return Scaffold(
            appBar: AppBar(title: const Text("Live Tracking")),
            body: const Center(
              child: Text("No active ride yet. Request a ride to start tracking."),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(title: const Text("Live Tracking")),
          body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.navy, Color(0xFF0B1E34)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _InfoCard(label: "Status", value: _phaseLabel(controller.phase)),
                    _InfoCard(
                      label: "Driver",
                      value: status?.driverName != null
                          ? "${status!.driverName} - ${status.driverRating?.toStringAsFixed(1) ?? ""}"
                          : "Assigning driver",
                    ),
                    _InfoCard(label: "ETA", value: "${status?.etaMin ?? 4} minutes"),
                    _InfoCard(label: "Pickup", value: "Kumasi Central Market"),
                    _InfoCard(label: "Share", value: "Share trip with family"),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _ActionButton(
                            label: "Call Driver",
                            icon: Icons.call,
                            color: Colors.white.withOpacity(0.16),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _ActionButton(
                            label: "Call Support",
                            icon: Icons.support_agent,
                            color: Colors.white.withOpacity(0.16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.ghanaRed,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: const Text("SOS"),
                      ),
                    ),
                    const Spacer(),
                    if (controller.phase != RidePhase.completed && controller.phase != RidePhase.cancelled)
                      TextButton(
                        onPressed: controller.cancelRide,
                        child: const Text("Cancel ride", style: TextStyle(color: Colors.white)),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.label, required this.icon, required this.color});

  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16),
      label: Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
    );
  }
}
