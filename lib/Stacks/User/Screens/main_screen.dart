import 'package:flutter/material.dart';
import 'package:golden_house/Helpers/Widgets/drawer_widget.dart';
import 'package:golden_house/Stacks/Auth/Controllers/auth_controller.dart';

class MainScreen extends StatefulWidget {
  final userData;
  const MainScreen({
    super.key,
    this.userData,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              await authService.logout();
            },
            child: const Text("Logout")),
      ),
      drawer: AdminDrawerWidget(userData: widget.userData,),
    );
  }
}
