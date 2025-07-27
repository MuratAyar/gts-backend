import 'package:flutter/material.dart';
import 'package:gts_app/screens/auth_screen.dart';

void main() {
  runApp(const GTSApp());
}

class GTSApp extends StatelessWidget {
  const GTSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GTS Cranes',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF131520),
        fontFamily: 'Plus Jakarta Sans',
        colorScheme: ColorScheme.dark(
          primary: Colors.orangeAccent,
          background: const Color(0xFF131520),
        ),
      ),
      home: const AuthScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
