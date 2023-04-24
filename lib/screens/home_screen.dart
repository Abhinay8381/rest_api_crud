import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_crud/provider/sign_in_provider.dart';
import 'package:rest_api_crud/utils/utils.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text("Logout"),
          onPressed: () async {
            await sp.userSignOut();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false);
          },
        ),
      ),
    );
  }
}
