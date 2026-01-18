import "package:flutter/material.dart";

class TrustBadge extends StatelessWidget {
  const TrustBadge({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0x24006B3F),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0x55006B3F)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0F3D26),
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
