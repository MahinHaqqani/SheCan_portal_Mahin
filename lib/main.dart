import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/leaderboard_screen.dart';
import 'screens/announcements_screen.dart';

void main() {
  runApp(const SheCanPortalApp());
}

class SheCanPortalApp extends StatelessWidget {
  const SheCanPortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'She Can Intern Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: const Color(0xFF6C63FF),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFFFF6584),
        ),
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) =>  LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/leaderboard': (context) => const LeaderboardScreen(),
        '/announcements': (context) =>  AnnouncementsScreen(),
      },
    );
  }
}