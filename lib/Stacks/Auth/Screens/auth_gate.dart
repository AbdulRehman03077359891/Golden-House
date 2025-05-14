import 'package:flutter/material.dart';
import 'package:golden_house/Helpers/res/user_data.dart';
import 'package:golden_house/Stacks/Auth/Controllers/auth_controller.dart';
import 'package:golden_house/Stacks/Auth/Screens/signin.dart';
import 'package:golden_house/Stacks/User/Screens/main_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();

    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final session = snapshot.data?.session;

        if (session != null) {
          // Now use FutureBuilder to wait for getData()
          return FutureBuilder<Map<String, dynamic>>(
            future: authService.getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(body: Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasError) {
                return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
              } else {
                user_Data = snapshot.data!;
                return MainScreen(userData: user_Data);
              }
            },
          );
        } else {
          return const SignIn();
        }
      },
    );
  }
}

