// 📁 lib/main.dart
import 'package:flutter/material.dart';
import 'screens/unauthenticated_home.dart';
import 'screens/auth_screen.dart';
import 'screens/crane_listings.dart';
import 'screens/crane_detail_page.dart'; // detay sayfasını da route olarak eklersen ileride işine yarar

void main() {
  runApp(const GTSApp());
}

class GTSApp extends StatelessWidget {
  const GTSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GTS Cranes',
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const UnauthenticatedHome(),
        '/auth': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as String?;
          return AuthScreen(initialTab: args ?? 'login');
        },
        '/listings': (context) => const CraneListingsPage(), // ✅ Burada ekledik
      },
    );
  }
}
