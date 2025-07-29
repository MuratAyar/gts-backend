import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'crane_listings.dart'; // Yeni ilanlar sayfası
import 'profile_tab.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
  CraneListingsPage(),
  Center(
    child: Text(
      "DM Kutusu",
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
  ),
  SizedBox(),
  Center(
    child: Text(
      "Harita",
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
  ),
  ProfileTab(), // <-- Profil ekranı buraya entegre edildi
];



  void _openCameraOrGallery() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1d2030),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          children: [
            const Center(
              child: Text(
                "Capture a crane or select from your gallery",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                final picker = ImagePicker();
                await picker.pickImage(source: ImageSource.camera);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE9ECFA),
                foregroundColor: const Color(0xFF131520),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text("Capture Crane Photo"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                final picker = ImagePicker();
                await picker.pickImage(source: ImageSource.gallery);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF282d43),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text("Select Crane from Gallery"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131520),
      body: IndexedStack(
        index: _currentIndex == 2 ? 0 : _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 2) {
            _openCameraOrGallery();
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        backgroundColor: const Color(0xFF1d2030),
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color(0xFF99a0c2),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'İlanlar'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'DM'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: 'Foto'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Harita'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
