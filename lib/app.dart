import 'package:flutter/material.dart';
import 'package:laundry_pos_app/screens/main/main_screen.dart';

class LaundryApp extends StatelessWidget {
  const LaundryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {'/': (context) => const MainScreen()},
    );
  }
}
