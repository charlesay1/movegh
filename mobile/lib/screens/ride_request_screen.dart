import "package:flutter/material.dart";
import "../models/ride_request.dart";
import "../routes.dart";
import "../state/ride_flow_controller.dart";
import "../state/ride_flow_scope.dart";
import "../theme/app_theme.dart";
import "../widgets/mode_option.dart";
import "../widgets/primary_button.dart";
import "../widgets/trust_badge.dart";

class RideRequestScreen extends StatefulWidget {
  const RideRequestScreen({super.key});

  @override
  State<RideRequestScreen> createState() => _RideRequestScreenState();
}

class _RideRequestScreenState extends State<RideRequestScreen> {
  final TextEditingController _pickupController = TextEditingController(text: "Osu Junction");
  final TextEditingController _dropoffController = TextEditingController(text: "East Legon");
  final TextEditingController _notesController = TextEditingController();
  String _selectedMode = "car";

  @override
  void dispose() {
    _pickupController.dispose();
    _dropoffController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  RideRequest _buildRequest() {
    return RideRequest(
      pickup: _pickupController.text.trim(),
      dropoff: _dropoffController.text.trim(),
      mode: _selectedMode,
      notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
    );
  }

  Future<void> _handleEstimate(RideFlowController controller) async {
    await controller.estimateFare(_buildRequest());
    if (!mounted) {
      return;
    }
    if (controller.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(controller.error!)),
      );
    }
  }

  Future<void> _handleRequest(RideFlowController controller) async {
    await controller.createRide(_buildRequest());
    if (!mounted) {
      return;
    }
    if (controller.hasActiveRide) {
      Navigator.pushNamed(context, AppRoutes.tracking);
      return;
    }
    if (controller.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(controller.error!)),
      );
    }
  }

  void _showFareBreakdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return const Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Fare breakdown", style: TextStyle(fontWeight: FontWeight.w700)),
              SizedBox(height: 12),
              _BreakdownRow(label: "Base fare", value: "GHS 5"),
              _BreakdownRow(label: "Distance", value: "GHS 12"),
              _BreakdownRow(label: "Time", value: "GHS 7"),
              Divider(),
              _BreakdownRow(label: "Total", value: "GHS 24", isBold: true),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = RideFlowScope.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final estimate = controller.estimate;
        return Scaffold(
          appBar: AppBar(title: const Text("Request Ride")),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Pickup", style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                TextField(
                  controller: _pickupController,
                  decoration: const InputDecoration(
                    hintText: "Landmark or address",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 12),
                const Text("Drop-off", style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                TextField(
                  controller: _dropoffController,
                  decoration: const InputDecoration(
                    hintText: "Destination",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 18),
                const Text("Choose a mode", style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ModeOption(
                        label: "Car",
                        icon: Icons.directions_car,
                        color: AppColors.electric,
                        isActive: _selectedMode == "car",
                        onTap: () => setState(() => _selectedMode = "car"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ModeOption(
                        label: "Bike",
                        icon: Icons.two_wheeler,
                        color: AppColors.ghanaGreen,
                        isActive: _selectedMode == "bike",
                        onTap: () => setState(() => _selectedMode = "bike"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ModeOption(
                        label: "Pragya",
                        icon: Icons.electric_rickshaw,
                        color: AppColors.ghanaGold,
                        isActive: _selectedMode == "pragya",
                        onTap: () => setState(() => _selectedMode = "pragya"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ModeOption(
                        label: "Aboboyaa\nCargo",
                        icon: Icons.local_shipping,
                        color: AppColors.ghanaRed,
                        isActive: _selectedMode == "aboboyaa",
                        onTap: () => setState(() => _selectedMode = "aboboyaa"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text("Notes (optional)", style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                TextField(
                  controller: _notesController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    hintText: "Gate color, landmark, or driver instructions",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 12),
                if (estimate != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Est. ${estimate.distanceKm.toStringAsFixed(1)} km | ${estimate.durationMin} min",
                        style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                      ),
                      TextButton(
                        onPressed: () => _showFareBreakdown(context),
                        child: const Text("Fare breakdown"),
                      ),
                    ],
                  )
                else
                  const Text(
                    "Estimate will appear here",
                    style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                  ),
                const SizedBox(height: 8),
                const TrustBadge(label: "Verified driver"),
                const Spacer(),
                PrimaryButton(
                  label: estimate == null ? "Get fare estimate" : "Request ride",
                  isLoading: controller.phase == RidePhase.estimating || controller.phase == RidePhase.requesting,
                  onPressed: estimate == null
                      ? () => _handleEstimate(controller)
                      : () => _handleRequest(controller),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow({required this.label, required this.value, this.isBold = false});

  final String label;
  final String value;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontWeight: isBold ? FontWeight.w700 : FontWeight.w500);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }
}
