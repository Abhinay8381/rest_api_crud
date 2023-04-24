import 'package:flutter/material.dart';

class ShowBookingScreen extends StatefulWidget {
  const ShowBookingScreen({super.key});

  @override
  State<ShowBookingScreen> createState() => _ShowBookingScreenState();
}

class _ShowBookingScreenState extends State<ShowBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("show book Screen")),
    );
  }
}
