import 'package:flutter/material.dart';

import 'package:rest_api_crud/screens/booking_screen.dart';
import 'package:rest_api_crud/screens/show_bookings.dart';

import '../screens/profile_screen.dart';

nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

nextScreenReplacement(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void showSnackBar(context, message, color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(
        fontSize: 14,
      ),
    ),
    action: SnackBarAction(
      label: "OK",
      onPressed: () {},
      textColor: Colors.white,
    ),
    duration: const Duration(seconds: 2),
    backgroundColor: color,
  ));
}

const Color primaryColor = Colors.black;
const Color secondaryColor = Colors.grey;
const Color mobileBackgroundColor = Colors.white;

var homeScreenWidgets = [
  const BookingScreen(),
  const ShowBookingScreen(),
  const ProfileScreen(),
];

const textInputDecoration = InputDecoration(
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    enabledBorder: InputBorder.none);
