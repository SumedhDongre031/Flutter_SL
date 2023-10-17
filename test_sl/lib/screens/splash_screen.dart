import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_sl/screens/home_screen.dart';
import 'package:test_sl/screens/login_screen.dart';
import 'package:test_sl/services/auth_service.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    //authService.signOut();
    return authService.currentUser == null 
        ? const LoginScreen() 
        : const HomeScreen();
  }
}
