// 📁 lib/main.dart
import 'package:flutter/material.dart';
import 'screens/unauthenticated_home.dart'; // kısa import
import 'screens/auth_screen.dart';

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
      },
    );
  }
}
