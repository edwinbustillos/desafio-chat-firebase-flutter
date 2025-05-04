// import 'package:desafio_firebase_flutter/providers/auth_provider.dart'
//     as my_auth;
import 'package:desafio_firebase_flutter/screens/auth_screen.dart';
import 'package:desafio_firebase_flutter/screens/room_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = FirebaseAuth.instance;

    return StreamBuilder<User?>(
      stream: firebaseAuth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return const RoomScreen();
        }

        return const AuthScreen();
      },
    );
  }
}
