// 📁 lib/unauthenticated_home.dart
import 'package:flutter/material.dart';

class UnauthenticatedHome extends StatelessWidget {
  const UnauthenticatedHome({super.key});

  void _redirectToLogin(BuildContext context) {
    Navigator.pushNamed(context, '/auth', arguments: 'login');
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF101323);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar + Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Row(
                children: [
                  const Icon(Icons.menu, color: Colors.white),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text("GTS Cranes",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white)),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/auth', arguments: 'login');
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Login"),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/auth', arguments: 'signup');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF607AFB),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Sign Up"),
                  )
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search listings...",
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: const Color(0xFF1A1D2E),
                  prefixIcon: const Icon(Icons.search, color: Colors.white54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SectionTitle(title: "Featured Listings"),

            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  ListingCard(
                    imageUrl: 'https://via.placeholder.com/200x100',
                    title: 'Heavy Duty Crane',
                    subtitle: 'Capacity: 500 tons',
                  ),
                  ListingCard(
                    imageUrl: 'https://via.placeholder.com/200x100',
                    title: 'Mobile Crane',
                    subtitle: 'Capacity: 200 tons',
                  ),
                  ListingCard(
                    imageUrl: 'https://via.placeholder.com/200x100',
                    title: 'Tower Crane',
                    subtitle: 'Capacity: 100 tons',
                  ),
                ],
              ),
            ),

            const SectionTitle(title: "Featured Sellers"),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                padding: const EdgeInsets.all(16),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: const [
                  SellerCard(
                    imageUrl: 'https://via.placeholder.com/100',
                    name: 'Crane Solutions Inc.',
                    tag: 'Leading crane provider',
                  ),
                  SellerCard(
                    imageUrl: 'https://via.placeholder.com/100',
                    name: 'Global Crane Corp.',
                    tag: 'Worldwide crane supplier',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF181d35),
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xFF8e99cc),
        onTap: (index) {
          if (index == 0) {
            // Home - do nothing
          } else {
            _redirectToLogin(context);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'DM',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class ListingCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  const ListingCard({super.key, required this.imageUrl, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(imageUrl, height: 100, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(color: Color(0xFF8e99cc))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SellerCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String tag;

  const SellerCard({super.key, required this.imageUrl, required this.name, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(radius: 40, backgroundImage: NetworkImage(imageUrl)),
        const SizedBox(height: 8),
        Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        Text(tag, style: const TextStyle(color: Color(0xFF8e99cc))),
      ],
    );
  }
}
