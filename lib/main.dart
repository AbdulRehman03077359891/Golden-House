import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golden_house/Stacks/Auth/Screens/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImllcnZoaXJqaHZidGx2ZnBpZ21rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU3NjIxMzksImV4cCI6MjA2MTMzODEzOX0.qN5DGEnHdTdbdsxP9ZDRXF3tOFKl7JQKp-Hrl1CC4c8",
      url: "https://iervhirjhvbtlvfpigmk.supabase.co");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Golden House',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
          useMaterial3: true,
        ),
        home: AuthGate());
  }
}
