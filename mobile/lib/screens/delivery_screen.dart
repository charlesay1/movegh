import "package:flutter/material.dart";
import "../models/delivery_request.dart";
import "../services/app_services.dart";
import "../theme/app_theme.dart";
import "../widgets/primary_button.dart";

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropoffController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _pickupController.dispose();
    _dropoffController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _handleRequest() async {
    setState(() => _isLoading = true);
    try {
      final request = DeliveryRequest(
        pickup: _pickupController.text.trim(),
        dropoff: _dropoffController.text.trim(),
        packageSize: "Small",
        notes: _notesController.text.trim(),
      );
      await AppServices.deliveries.requestDelivery(request);
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Delivery request sent")),
      );
    } catch (_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Delivery request failed")),
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
      appBar: AppBar(title: const Text("Send a Parcel")),
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
                hintText: "Recipient location",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 12),
            const Text("Package size", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              children: [
                _SizeChip(label: "Small (0-5 kg)", isActive: true),
                _SizeChip(label: "Medium (5-15 kg)"),
                _SizeChip(label: "Large (15+ kg)"),
              ],
            ),
            const SizedBox(height: 12),
            const Text("Proof of delivery", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              children: const [
                _OptionChip(label: "Photo"),
                _OptionChip(label: "OTP"),
                _OptionChip(label: "Signature"),
              ],
            ),
            const SizedBox(height: 12),
            const Text("Package details", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            TextField(
              controller: _notesController,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: "Package type, size, or notes",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.lime.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  Icon(Icons.local_shipping, color: AppColors.navy),
                  SizedBox(width: 10),
                  Expanded(child: Text("Aboboyaa Cargo recommended for goods and market deliveries")),
                ],
              ),
            ),
            const Spacer(),
            const Text("Payment: MTN MoMo - GHS 18", style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
            const SizedBox(height: 10),
            PrimaryButton(
              label: _isLoading ? "Sending..." : "Request delivery",
              isLoading: _isLoading,
              onPressed: _isLoading ? null : _handleRequest,
            ),
          ],
        ),
      ),
    );
  }
}

class _SizeChip extends StatelessWidget {
  const _SizeChip({required this.label, this.isActive = false});

  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label, style: TextStyle(fontSize: 11, color: isActive ? AppColors.navy : const Color(0xFF475569))),
      backgroundColor: isActive ? AppColors.lime.withOpacity(0.25) : const Color(0xFFF1F5F9),
      shape: StadiumBorder(side: BorderSide(color: isActive ? AppColors.lime : const Color(0xFFE2E8F0))),
    );
  }
}

class _OptionChip extends StatelessWidget {
  const _OptionChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF475569))),
      backgroundColor: const Color(0xFFF1F5F9),
      shape: const StadiumBorder(side: BorderSide(color: Color(0xFFE2E8F0))),
    );
  }
}
