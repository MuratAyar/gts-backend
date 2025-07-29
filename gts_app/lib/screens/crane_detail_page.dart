import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CraneDetailPage extends StatefulWidget {
  final Map<String, String> crane;

  const CraneDetailPage({super.key, required this.crane});

  @override
  State<CraneDetailPage> createState() => _CraneDetailPageState();
}

class _CraneDetailPageState extends State<CraneDetailPage> {
  final Color bgColor = const Color(0xFF101323);
  final Color textColor = const Color(0xFF8e9acc);
  bool isFavorite = false;

  late GoogleMapController mapController;
  late LatLng location;
  late String price;

  @override
  void initState() {
    super.initState();
    location = const LatLng(41.0082, 28.9784); // Örnek konum: İstanbul
    price = widget.crane['price'] ?? "€ 78,500";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.redAccent : Colors.white,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isFavorite ? "Favorilere eklendi" : "Favorilerden çıkarıldı",
                  ),
                ),
              );
            },
          )
        ],
        title: Text(widget.crane["title"]!, style: const TextStyle(color: Colors.white)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Resim
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(widget.crane["image"]!, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 16),

          // Fiyat
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Fiyat", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text(price, style: TextStyle(color: textColor, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 12),

          // Özellikler
          Text(widget.crane["specs"]!, style: TextStyle(color: textColor)),
          const SizedBox(height: 12),

          // Açıklama
          Text(widget.crane["desc"]!, style: TextStyle(color: textColor)),
          const SizedBox(height: 24),

          const Text("Konum", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),

          // Harita
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 200,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(target: location, zoom: 14),
                onMapCreated: (controller) => mapController = controller,
                markers: {
                  Marker(
                    markerId: const MarkerId("crane"),
                    position: location,
                    infoWindow: InfoWindow(title: widget.crane["title"]),
                  ),
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
