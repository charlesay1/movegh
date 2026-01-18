import "package:flutter/material.dart";
import "../routes.dart";
import "../theme/app_theme.dart";
import "../widgets/mode_option.dart";
import "../widgets/primary_button.dart";
import "../widgets/ride_delivery_toggle.dart";
import "../widgets/where_to_input.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _intentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MoveGH"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              color: const Color(0xFFF8FAFC),
            ),
            child: const Text(
              "Accra",
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF0B4E7A)),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          RideDeliveryToggle(
            activeIndex: _intentIndex,
            onChanged: (value) => setState(() => _intentIndex = value),
          ),
          const SizedBox(height: 12),
          const WhereToInput(
            title: "Where to?",
            subtitle: "Landmark or address",
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(color: Color(0x140A2540), blurRadius: 16, offset: Offset(0, 8)),
              ],
            ),
            child: const Text(
              "Pickup: Osu Junction -> Drop-off: East Legon",
              style: TextStyle(fontSize: 13, color: Color(0xFF475569)),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ModeOption(
                  label: "Car",
                  icon: Icons.directions_car,
                  color: AppColors.electric,
                  isActive: true,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ModeOption(
                  label: "Bike",
                  icon: Icons.two_wheeler,
                  color: AppColors.ghanaGreen,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ModeOption(
                  label: "Pragya",
                  icon: Icons.electric_rickshaw,
                  color: AppColors.ghanaGold,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ModeOption(
                  label: "Aboboyaa\nCargo",
                  icon: Icons.local_shipping,
                  color: AppColors.ghanaRed,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: _intentIndex == 0 ? "Request Ride" : "Request Delivery",
                  onPressed: () => Navigator.pushNamed(
                    context,
                    _intentIndex == 0 ? AppRoutes.rideRequest : AppRoutes.delivery,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  child: const Text("Schedule"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Quick access", style: TextStyle(fontWeight: FontWeight.w700)),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.tracking),
                child: const Text("Track ride"),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: const Row(
              children: [
                Icon(Icons.share, size: 18, color: Color(0xFF0B4E7A)),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Share your trip with family and friends.",
                    style: TextStyle(fontSize: 12, color: Color(0xFF475569)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Trips"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
