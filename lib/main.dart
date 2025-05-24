import 'package:flutter/material.dart';
import 'features/activity/views/activity_screen.dart';
import 'features/membership/views/profile_screen.dart';
import 'features/home/views/notification_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Know Me', // 앱 이름
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple, // 테마 색상
        ),
      ),

      // ───────────────────────────────────────────
      // 초기 화면을 ActivityScreen 으로 변경
      home: const ProfileScreen(),
    );
  }
}
