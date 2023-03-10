import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_recommendation_system_for_mental_health_patients/screens/welcome/welcome_screen.dart';

import '../screens/home/admin_home.dart';
import '../screens/home/home.dart';

class AdminAuthPage extends StatelessWidget {
  const AdminAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return AdminHomePage();
          } else {
            return WelcomeScreen();
          }
        },
      ),
    );
  }
}
