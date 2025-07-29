// 📁 lib/map_page.dart
import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181511),
      body: SafeArea(
        child: Column(
          children: [
            // Search bar and zoom/location buttons
            Container(
              height: 320,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://lh3.googleusercontent.com/aida-public/AB6AXuA14Nm04BpUOlltU_KVVKsh3hfaM33pWdi96HVwcHPBAYgBjkWAMvQlcdzGQia7VQvX59cegzkGh9H6sVYUBAhPtxTOSumWc1w1KS4Z-fh4Wzj5HHCt5mmINtkWP1JdAc8-5LNt9EfdL2bMnPy6bRzHuHkC9Tx_5skQehH7LIpXP4AGBAbZVSBby_Fd0w2ei9dkUqJkvnZZvXaN6ygK90cgR-KGI0O1f8P6M0MwDtDDCRof9bpSDKbrcW9v_vU2JyU1DWSImfEvhqOY",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 16,
                    right: 16,
                    top: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF27221c),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Color(0xFFb9ad9d)),
                          prefixIcon: Icon(Icons.search, color: Color(0xFFb9ad9d)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: Column(
                      children: [
                        _mapButton(icon: Icons.add),
                        const SizedBox(height: 8),
                        _mapButton(icon: Icons.remove),
                        const SizedBox(height: 8),
                        _mapButton(icon: Icons.navigation, rotate: true),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Filter button
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, top: 12),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFed9c2a),
                    foregroundColor: const Color(0xFF181511),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.tune),
                  label: const Text("Filters"),
                ),
              ),
            ),

            // Nearby section
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Featured Nearby",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  _CraneCard(name: "Crane 1", capacity: "100T"),
                  _CraneCard(name: "Crane 2", capacity: "150T"),
                  _CraneCard(name: "Crane 3", capacity: "120T"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mapButton({required IconData icon, bool rotate = false}) {
    return Container(
      height: 40,
      width: 40,
      decoration: const BoxDecoration(
        color: Color(0xFF27221c),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Transform(
          alignment: Alignment.center,
          transform: rotate ? Matrix4.rotationY(3.1416) : Matrix4.identity(),
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}

class _CraneCard extends StatelessWidget {
  final String name;
  final String capacity;

  const _CraneCard({required this.name, required this.capacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF27221c),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://via.placeholder.com/100x100'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                Text("Capacity: $capacity",
                    style: const TextStyle(color: Color(0xFFb9ad9d))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
