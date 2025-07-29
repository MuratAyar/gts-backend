// 📁 lib/map_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  double _zoom = 13.0;
  final MapController _mapController = MapController();
  final LatLng _initialCenter = LatLng(41.015137, 28.979530); // Istanbul

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181511),
      body: SafeArea(
        child: Column(
          children: [
            // Map and buttons
            SizedBox(
              height: 320,
              child: Stack(
                children: [
                  FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: _initialCenter,
                      initialZoom: _zoom,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        userAgentPackageName: 'com.example.app',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: _initialCenter,
                            width: 40,
                            height: 40,
                            child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
                          ),
                        ],
                      ),
                    ],
                  ),
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
                        _mapButton(icon: Icons.add, onTap: () {
                          setState(() {
                            _zoom++;
                            _mapController.move(_mapController.center, _zoom);
                          });
                        }),
                        const SizedBox(height: 8),
                        _mapButton(icon: Icons.remove, onTap: () {
                          setState(() {
                            _zoom--;
                            _mapController.move(_mapController.center, _zoom);
                          });
                        }),
                        const SizedBox(height: 8),
                        _mapButton(icon: Icons.my_location, onTap: () {
                          _mapController.move(_initialCenter, _zoom);
                        }),
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
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        backgroundColor: const Color(0xFF1a1d2e),
                        title: const Text("Filter Options", style: TextStyle(color: Colors.white)),
                        content: const Text("You can implement filter options here.", style: TextStyle(color: Colors.white70)),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Close", style: TextStyle(color: Colors.orangeAccent)),
                          )
                        ],
                      ),
                    );
                  },
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

  Widget _mapButton({required IconData icon, bool rotate = false, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
